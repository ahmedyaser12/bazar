import 'package:book_shop/core/utils/app_regex.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/login_screen/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/common_functions.dart';
import '../../../../core/widget/text_field.dart';

class EmailAndPasswordField extends StatefulWidget {
  final LoginCubit loginCubitObject;

  const EmailAndPasswordField({super.key, required this.loginCubitObject});

  @override
  State<EmailAndPasswordField> createState() => _EmailAndPasswordFieldState();
}

class _EmailAndPasswordFieldState extends State<EmailAndPasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          FormTextFieldItem(
            controller: widget.loginCubitObject.emailController,
            name: 'Email',
            title: 'Your email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty ||
                  value == null ||
                  !AppRegex.isEmailValid(value)) {
                return 'please entre a valid email';
              }
            },
          ),
          heightSpace(30),
          FormTextFieldItem(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be greater than 6 characters';
              }
              return null;
            },
            isPassword: true,
            controller: widget.loginCubitObject.passwordController,
            keyboardType: TextInputType.visiblePassword,
            name: 'Password',
            title: 'Your password',
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
          ),
        ],
      ),
    );
  }
}
