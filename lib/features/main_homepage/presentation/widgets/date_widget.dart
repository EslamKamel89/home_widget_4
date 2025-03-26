import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/format_date.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key, required this.animationDuration});
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    // Get today's date
    final today = DateTime.now();
    final hijriDate = HijriCalendar.now();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100.withOpacity(0.1), Colors.blue.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Title
              txt(
                'Today’s Date',
                e: St.bold16,
                googleFontCallback: GoogleFonts.cinzel,
                c: context.secondaryHeaderColor,
              ).animate().moveX(duration: animationDuration, begin: -500, end: 0),
              const SizedBox(height: 5),
              // Gregorian Date
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 360) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        txt(
                          formateDateEgnlish(today),
                          e: St.reg16,
                          googleFontCallback: GoogleFonts.cinzel,
                          c: context.primaryColor,
                        ).animate().moveX(duration: animationDuration, begin: 500, end: 0),
                        const SizedBox(height: 5),
                        txt(
                          '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear}',
                          googleFontCallback: GoogleFonts.cinzel,
                          e: St.reg16,
                          c: context.primaryColor,
                        ).animate().moveX(duration: animationDuration, begin: -500, end: 0),
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      txt(
                        formateDateEgnlish(today),
                        e: St.reg16,
                        googleFontCallback: GoogleFonts.cinzel,
                        c: context.primaryColor,
                      ).animate().moveX(duration: animationDuration, begin: 500, end: 0),
                      const SizedBox(width: 5),
                      txt(
                        '${hijriDate.hDay} ${hijriDate.longMonthName} ${hijriDate.hYear}',
                        googleFontCallback: GoogleFonts.cinzel,
                        e: St.reg16,
                        c: context.primaryColor,
                      ).animate().moveX(duration: animationDuration, begin: -500, end: 0),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
