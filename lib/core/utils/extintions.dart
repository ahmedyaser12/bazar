import 'package:flutter/material.dart';

extension WidgetExtention on Widget {
  Widget onTap(
    Function function, {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(5)),
  }) {
    return InkWell(
      onTap: function as void Function()?,
      borderRadius: borderRadius,
      child: this,
    );
  }
}

extension Navigation on BuildContext {
  Future<dynamic> navigateTo(String routeName, {Object? argument}) {
    return Navigator.of(this).pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToAndReplacement(String routeName,
      {Object? argument}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}
