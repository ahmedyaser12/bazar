import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class PasswordValidation extends StatelessWidget {
  final bool haseLowerCase;
  final bool haseUpperCase;
  final bool haseSpecialCharacters;
  final bool haseNumber;
  final bool haseMinLength;

  const PasswordValidation(
      {super.key,
      required this.haseLowerCase,
      required this.haseUpperCase,
      required this.haseSpecialCharacters,
      required this.haseNumber,
      required this.haseMinLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow('At least 1 lowercase letter', haseLowerCase),
        heightSpace(2),
        buildValidationRow('At least 1 uppercase letter', haseUpperCase),
        heightSpace(2),
        buildValidationRow(
            'At least 1 special character', haseSpecialCharacters),
        heightSpace(2),
        buildValidationRow('At least 1 number', haseNumber),
        heightSpace(2),
        buildValidationRow('At least 8 character long', haseMinLength),
      ],
    );
  }

  buildValidationRow(String caseDetails, bool haseValidated) {
    return Row(
      children: [
        Icon(
          !haseValidated ? Icons.close : Icons.check,
          color: !haseValidated ? AppColors.redColor : AppColors.greenColor,
        ),
        Text(
          caseDetails,
          style: TextStyles.font14RedBold.copyWith(
            decoration: haseValidated ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.greenColor,
            decorationThickness: 2,
            color: haseValidated ? AppColors.greyColor : AppColors.primary,
          ),
        ),
      ],
    );
  }
}