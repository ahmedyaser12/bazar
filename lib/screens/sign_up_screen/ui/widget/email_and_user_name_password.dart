import 'package:book_shop/core/utils/app_regex.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:book_shop/screens/sign_up_screen/ui/widget/password_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widget/text_field.dart';

class EmailAndUserNameAndPasswordField extends StatefulWidget {
  final SignUpCubit signUpCubitObject;

  const EmailAndUserNameAndPasswordField(
      {super.key, required this.signUpCubitObject});

  @override
  State<EmailAndUserNameAndPasswordField> createState() =>
      _EmailAndPasswordFieldState();
}

class _EmailAndPasswordFieldState
    extends State<EmailAndUserNameAndPasswordField> {
  bool isObscure = true;
  bool haseLowerCase = false;

  bool haseUpperCase = false;
  bool haseSpecialCharacters = false;
  bool haseNumber = false;
  bool haseMinLength = false;
  late TextEditingController passwordController;

  @override
  void initState() {
    passwordController = context.read<SignUpCubit>().passwordController;
    setupPasswordControllerListener();
    super.initState();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        haseLowerCase = AppRegex.hasLowerCase(passwordController.text);
        haseUpperCase = AppRegex.hasUpperCase(passwordController.text);
        haseSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        haseNumber = AppRegex.hasNumber(passwordController.text);
        haseMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.signUpCubitObject.formKey,
      child: Column(
        children: [

          FormTextFieldItem(
            //key: widget.signUpCubitObject.formKey,
            controller: widget.signUpCubitObject.nameController,
            name: 'name'[0].toUpperCase() + 'name'.substring(1),
            title: 'entre your Name',
            validator: (value) {
              if (value.isEmpty ||
                  value == null ||
                  AppRegex.isEmailValid(value)) {
                return 'please entre your name';
              }
            },
          ),
          heightSpace(16),
          FormTextFieldItem(
              //key: widget.signUpCubitObject.formKey,
              controller: widget.signUpCubitObject.emailController,
              name: 'Email',
              title: 'entre your email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please entre a valid email';
                }
              }),
          heightSpace(16),
          FormTextFieldItem(
            lines: 11,
            controller: widget.signUpCubitObject.phoneController,
            keyboardType: TextInputType.phone,
            name: 'phone'[0].toUpperCase() + 'phone'.substring(1),
            title: 'entre your Phone',
            validator: (value) {
              if (value.isEmpty || value == null || AppRegex.hasNumber(value)) {
                return 'please entre your phone';
              }
            },
          ),
          heightSpace(16),
          FormTextFieldItem(
              //key: widget.signUpCubitObject.formKey,
              isPassword: true,
              controller: widget.signUpCubitObject.passwordController,
              keyboardType: TextInputType.visiblePassword,
              name: 'Password',
              title: 'entre your password',
              suffixIcon: Icon(
                !isObscure ? Icons.visibility : Icons.visibility_off,
                //color: AppColors.greyColor,
                size: 25,
              ).onTap(() {
                setState(() {
                  isObscure = !isObscure;
                });
              }),
              isSecure: isObscure,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please entre a valid password';
                }
              }),
          heightSpace(16),
          FormTextFieldItem(
              //key: widget.signUpCubitObject.formKey,
              isPassword: true,
              controller: widget.signUpCubitObject.confirmController,
              keyboardType: TextInputType.visiblePassword,
              name: 'confirm Password',
              title: 'entre your password',
              suffixIcon: Icon(
                !isObscure ? Icons.visibility : Icons.visibility_off,
                //color: AppColors.greyColor,
                size: 25,
              ).onTap(() {
                setState(() {
                  isObscure = !isObscure;
                });
              }),
              isSecure: isObscure,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please entre a valid password';
                }
              }),
          heightSpace(20),
          PasswordValidation(
              haseLowerCase: haseLowerCase,
              haseUpperCase: haseUpperCase,
              haseSpecialCharacters: haseSpecialCharacters,
              haseNumber: haseNumber,
              haseMinLength: haseMinLength)
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
