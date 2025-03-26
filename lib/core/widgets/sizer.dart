import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizer extends StatelessWidget {
  const Sizer({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 10.w,
      height: height ?? 10.h,
    );
  }
}
