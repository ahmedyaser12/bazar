import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/widget/app_buttons.dart';
import 'package:book_shop/screens/sign_up_screen/ui/widget/email_and_user_name_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/styles.dart';
import '../logic/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  context.pop();
                  showAcceptDialog(context, state.success);
                } else if (state is SignUpFailure) {
                  showAlertDialog(context, state.error);
                }
              },
              builder: (context, state) {
                final signUpCubitObject = context.read<SignUpCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyles.font24BlackBold,
                    ),
                    heightSpace(8),
                    Text(
                      'Create account and choose favorite menu',
                      style: TextStyles.font16grey,
                    ),
                    heightSpace(30),
                    EmailAndUserNameAndPasswordField(
                        signUpCubitObject: signUpCubitObject),
                    heightSpace(24),
                    state is SignUpLoading != true
                        ? primaryButton(title: 'Register', borderRadius: 50)
                            .onTap(() {
                            validateRegister(context);
                          })
                        : const Center(child: CircularProgressIndicator()),
                    heightSpace(24),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Have an account?',
                              style: TextStyles.font16grey,
                            ),
                            TextSpan(
                              text: ' Sign in',
                              style: TextStyles.font16PrimarySemi,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pop();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  validateRegister(BuildContext context) async {
    if (!context.read<SignUpCubit>().formKey.currentState!.validate() ||
        context.read<SignUpCubit>().pickImage == null) {
      return context.read<SignUpCubit>().pickImage == null
          ? showSnackBar(context,'please entre your photo')
          : null;
    }
    context.read<SignUpCubit>().signUp();
    return null;
  }
}


