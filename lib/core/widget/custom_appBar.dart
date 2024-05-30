import 'package:book_shop/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final String title;
  final IconThemeData? iconThemeData;
  final Color? color;
  final List<Widget>? action;

  const CustomAppBar(
      {super.key,
      this.leading,
      required this.title,
      this.iconThemeData,
      this.color,
      this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: leading,
      iconTheme: iconThemeData,
      title: Text(
        title,
        style: TextStyles.font18BlackBold(context),
      ),
      backgroundColor: color,
      actions: action,
    );
  }
}

customAppBarr({
  required context,
  final Widget? leading,
  required String title,
  final IconThemeData? iconThemeData,
  final Color? color,
  final List<Widget>? action,
}) {
  return AppBar(
    centerTitle: true,
    leading: leading,
    iconTheme: iconThemeData,
    title: Text(
      title,
      style: TextStyles.font18BlackBold(context),
    ),
    backgroundColor: color,
    actions: action,
  );
}
