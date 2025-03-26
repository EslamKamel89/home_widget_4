import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultScreenPadding extends StatelessWidget {
  const DefaultScreenPadding(
      {super.key, required this.child, this.paddingParam});
  final Widget child;
  static final EdgeInsets padding =
      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w);
  final EdgeInsets? paddingParam;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingParam ?? padding,
      child: child,
    );
  }
}
