import 'package:flutter/material.dart';

Widget widthSpace(double widthSpace) {
  return SizedBox(
    width: widthSpace,
  );
}

Widget heightSpace(double heightSpace) {
  return SizedBox(
    height: heightSpace,
  );
}

String notNullString(any) {
  return any == null ? '' : any.toString();
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
