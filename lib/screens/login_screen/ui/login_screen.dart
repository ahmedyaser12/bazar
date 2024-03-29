import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/widget/app_buttons.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:book_shop/screens/login_screen/ui/widget/email_and_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/styles.dart';
import '../../../core/widget/divider_widget.dart';
import 'widget/social_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubitObject = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor),
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  showAcceptDialog(context);
                } else if (state is LoginFailure) {
                  showAlertDialog(context, state.error);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back 👋',
                      style: TextStyles.font24BlackBold,
                    ),
                    heightSpace(8),
                    Text(
                      'Sign to your account',
                      style: TextStyles.font16grey,
                    ),
                    heightSpace(30),
                    EmailAndPasswordField(
                      loginCubitObject: loginCubitObject,
                    ),
                    heightSpace(16),
                    Text(
                      'Forget Password?',
                      style: TextStyles.font14PrimarySemi,
                    ),
                    heightSpace(24),
                    if (state is LoginLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      primaryButton(title: 'Login', borderRadius: 50).onTap(() {
                        validateRegister(context);
                      }),
                    heightSpace(24),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don’t have an account?',
                              style: TextStyles.font16grey,
                            ),
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyles.font16PrimarySemi,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.navigateTo(RouteName.SIGNUP);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    heightSpace(24),
                    const DividerWidget(),
                    heightSpace(24),
                    const SocialLogin(
                      socialIcon: 'assets/svgs/Google.svg',
                      title: ' Sign in with Google',
                    ),
                    heightSpace(15),
                    const SocialLogin(
                      socialIcon: 'assets/svgs/apple.svg',
                      title: ' Sign in with Apple',
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

  void validateRegister(BuildContext context) async {
    if (!context.read<LoginCubit>().formKey.currentState!.validate()) {
      return;
    }
    context.read<LoginCubit>().login();
  }

  void showAlertDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font16PrimarySemi,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font16PrimarySemi,
            ),
          ),
        ],
      ),
    );
  }
}

  void showAcceptDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.green[100],
      icon: const Icon(
        Icons.check,
        color: Colors.green,
        size: 32,
      ),
      content: Text(
        'Login Success',
        style: TextStyles.font16PrimarySemi,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            'OK',
            style: TextStyles.font16PrimarySemi,
          ),
        ),
      ],
    ),
  );
}
