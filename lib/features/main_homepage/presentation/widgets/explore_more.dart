import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/themes/themedata.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class ExploreMore extends StatelessWidget {
  const ExploreMore({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(30.w),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.brightness_3, size: 30, color: lightClr.goldColor),
            txt(
              "Explore More",
              e: St.bold16,
              googleFontCallback: GoogleFonts.cinzel,
              c: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
