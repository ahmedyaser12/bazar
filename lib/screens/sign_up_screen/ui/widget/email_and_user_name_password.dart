import 'package:book_shop/core/utils/app_regex.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:book_shop/screens/sign_up_screen/ui/widget/add_image.dart';
import 'package:book_shop/screens/sign_up_screen/ui/widget/password_validation.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController passwordController;
  late TextEditingController confirmController;

  bool isObscure = true;
  bool isObscureConfirm = true;
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    // Reinitialize controllers through cubit
    widget.signUpCubitObject.reinitializeControllers();
    passwordController = widget.signUpCubitObject.passwordController;
    confirmController = widget.signUpCubitObject.confirmController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      final text = passwordController.text;
      setState(() {
        hasLowerCase = AppRegex.hasLowerCase(text);
        hasUpperCase = AppRegex.hasUpperCase(text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(text);
        hasNumber = AppRegex.hasNumber(text);
        hasMinLength = AppRegex.hasMinLength(text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.signUpCubitObject.formKey,
      child: Column(
        children: [
          const PickImageWidget(),
          heightSpace(16),
          FormTextFieldItem(
            //key: widget.signUpCubitObject.formKey,
            controller: widget.signUpCubitObject.nameController,
            name: 'name'[0].toUpperCase() + 'name'.substring(1),
            title: 'entre your Name',
            validator: (value) {
              if (value.isEmpty || value == null) {
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
                if (value == null ||
                    value.isEmpty ||
                    !AppRegex.isEmailValid(value)) {
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
              if (value.isEmpty ||
                  value == null ||
                  !AppRegex.hasNumber(value)) {
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
                  return 'Please enter your password';
                }  else if (!AppRegex.isPasswordValid(value)) {
                  return 'Password must be same of the instruction below';
                }
                return null;
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
                !isObscureConfirm ? Icons.visibility : Icons.visibility_off,
                //color: AppColors.greyColor,
                size: 25,
              ).onTap(() {
                setState(() {
                  isObscureConfirm = !isObscureConfirm;
                });
              }),
              isSecure: isObscureConfirm,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != widget.signUpCubitObject.passwordController.text) {
                  return 'The password not a same';
                }
              }),
          heightSpace(20),
          PasswordValidation(
              haseLowerCase: hasLowerCase,
              haseUpperCase: hasUpperCase,
              haseSpecialCharacters: hasSpecialCharacters,
              haseNumber: hasNumber,
              haseMinLength: hasMinLength)
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Since the cubit manages the controllers, avoid disposing them here
    widget.signUpCubitObject
        .disposeControllers(); // Optionally call this if the cubit is scoped to the screen
    super.dispose();
  }
}
