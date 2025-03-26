import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/globals/globals_var.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/features/main_homepage/presentation/widgets/city_widget.dart';
import 'package:home_widget_4/features/main_homepage/presentation/widgets/moon_phase_image.dart';

class PrayerCard extends StatefulWidget {
  final String prayerName;
  final Duration timeRemaining;
  const PrayerCard({super.key, required this.prayerName, required this.timeRemaining});

  @override
  State<PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  @override
  Widget build(BuildContext context) {
    // Format the remaining time as HH:MM:SS.
    final hours = widget.timeRemaining.inHours;
    final minutes = widget.timeRemaining.inMinutes.remainder(60);
    final seconds = widget.timeRemaining.inSeconds.remainder(60);
    final timeRemainingText =
        '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';

    return Card(
      elevation: 8,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        // constraints: BoxConstraints(minHeight: context.height / 4),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Colors.black,
                Colors.black,
                Colors.black87,
                Colors.black54,
                Color(0xFF0D3B66),
              ],
              stops: const [0.0, 0.5, 0.65, 0.8, 1.0],
              begin: isEnglish() ? Alignment.centerLeft : Alignment.centerRight,
              end: isEnglish() ? Alignment.centerRight : Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                // height: context.height * 0.3,
              ),
              Positioned.directional(
                start: 0,
                textDirection: isEnglish() ? ltr : rtl,
                child: Transform.translate(
                  offset: Offset(0, -20.h),
                  child: Transform.flip(flipX: !isEnglish(), child: const MoonPhaseImage()),
                ),
              ),
              Container(
                width: context.width,
                padding: EdgeInsetsDirectional.only(start: context.width * 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 20.w,
                      // width: double.infinity,
                    ),
                    Text(
                      'NEXT_PRAYER'.tr(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.prayerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TimeRemaining'.tr(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      timeRemainingText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Transform.translate(
                    //   offset: Offset(-40.w, 0),
                    //   child: const CityWidget(),
                    // ),
                    SizedBox(height: 70.h),
                    // const NewHijrWidget(),
                  ],
                ),
              ),
              Positioned(
                bottom: 15,
                right: 10,
                left: 10,
                child: SizedBox(width: context.width, child: const CityWidget()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
