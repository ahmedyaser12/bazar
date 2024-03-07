import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/common_functions.dart';

class FormTextFieldItem extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? title;
  final String? name;
  final String? hint;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? isSecure;
  final bool? isPassword;
  final bool optional = false;
  final int? lines;
  final Widget? suffixIcon;
  final Function(String)? validator;

  const FormTextFieldItem({
    super.key,
    this.controller,
    this.initialValue,
    this.title,
    this.name,
    this.hint,
    this.enabled,
    this.lines,
    this.suffixIcon,
    this.isSecure = false,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            name!,
            style: TextStyles.font15BlackMedium,
          ),
        ),
        if (title != null) heightSpace(8),
        Container(
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGery),
            color: AppColors.lightGery,
          ),
          width: double.infinity,
          child: Center(
            child: TextFormField(
              validator: (value) {
                return validator!(value!);
              },
              initialValue: initialValue,
              controller: controller,
              keyboardType: keyboardType,
              //style: TextStyles.font14PrimarySemi,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.gery50,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.redColor,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.redColor,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                //border: InputBorder.none,
                hintText: hint ?? title ?? "hint",
                suffixIcon: suffixIcon,
                counterText: '',
                //contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                isDense: true,
              ),
              maxLength: lines,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              enabled: enabled,
              obscureText: isPassword == true ? isSecure! : false,
            ),
          ),
        ),
      ],
    );
  }
}
