import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/common_functions.dart';

class VerifyTextField extends StatelessWidget {
  const VerifyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      verifyCodeWidget(context),
      widthSpace(24),
      verifyCodeWidget(context),
      widthSpace(24),
      verifyCodeWidget(context),
      widthSpace(24),
      verifyCodeWidget(context),
    ]);
  }
}

Widget verifyCodeWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: const Color(0x0f8a8585),
    ),
    width: 56,
    height: 56,
    child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ]),
  );
}
