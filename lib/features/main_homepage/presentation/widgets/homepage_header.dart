import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class HomepageHeader extends StatelessWidget {
  const HomepageHeader({
    super.key,
    required this.animationDuration,
    required this.secondaryAnimationDuration,
  });

  final Duration animationDuration;
  final Duration secondaryAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 360) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              txt(
                    'New Islamic Calendar',
                    e: St.bold18,
                    googleFontCallback: GoogleFonts.cinzel,
                    c: context.primaryColor,
                  )
                  .animate()
                  .moveX(duration: animationDuration, begin: -500, end: 0)
                  .scale(
                    duration: secondaryAnimationDuration,
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                  ),
              SizedBox(height: 10.w),
              txt(
                    'التقويم الهجري',
                    e: St.bold18,
                    googleFontCallback: GoogleFonts.amiri,
                    c: context.primaryColor,
                  )
                  .animate()
                  .moveX(duration: animationDuration, begin: 500, end: 0)
                  .scale(
                    duration: secondaryAnimationDuration,
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                  ),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txt(
                  'Hijri Calendar',
                  e: St.bold18,
                  googleFontCallback: GoogleFonts.cinzel,
                  c: context.primaryColor,
                )
                .animate()
                .moveX(duration: animationDuration, begin: -500, end: 0)
                .scale(
                  duration: secondaryAnimationDuration,
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                ),
            SizedBox(width: 15.w),
            txt(
                  'التقويم الهجري',
                  e: St.bold18,
                  googleFontCallback: GoogleFonts.amiri,
                  c: context.primaryColor,
                )
                .animate()
                .moveX(duration: animationDuration, begin: 500, end: 0)
                .scale(
                  duration: secondaryAnimationDuration,
                  begin: const Offset(0, 0),
                  end: const Offset(1, 1),
                ),
          ],
        );
      },
    );
  }
}
