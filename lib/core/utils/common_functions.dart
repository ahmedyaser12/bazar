import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget widthSpace(double widthSpace) {
  return SizedBox(
    width: widthSpace.w,
  );
}

Widget heightSpace(double heightSpace) {
  return SizedBox(
    height: heightSpace.h,
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
