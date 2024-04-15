import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
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

void showSnackBar(BuildContext context, String content) {
  final snackBar = SnackBar(
    content: Text(content),
    duration: const Duration(seconds: 3),
  );

  // Find the Scaffold in the widget tree and use it to show the SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showAlertDialog(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      alignment: Alignment.center,
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 32,
      ),
      content: Text(
        error,
        style: TextStyles.font16PrimarySemi,
        textAlign: TextAlign.center,
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

void showAcceptDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.green[100],
      icon: const Icon(
        Icons.check,
        color: Colors.green,
        size: 32,
      ),
      content: Text(
        message,
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
