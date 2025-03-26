import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/utils/assets/assets.dart';

class PrayerTimesWidget extends StatelessWidget {
  const PrayerTimesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        double height = 250.h;
        List<String> images = [
          AssetsData.fajrPrayer,
          AssetsData.dahrPrayer,
          AssetsData.asrPrayer,
          AssetsData.maghrebPrayer,
          AssetsData.ashaPrayer,
        ];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                AssetsData.islamicPattern,
                fit: BoxFit.cover,
                height: height,
                width: double.infinity,
              ),
            ),
            Container(
              height: height,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 768) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(images.length, (index) {
                        return Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Image.asset(
                              images[index],
                              // width: 100.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        // width: 100.w,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
