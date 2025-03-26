import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';

class WisdomCarousel extends StatelessWidget {
  // List of Islamic wisdoms

  const WisdomCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Text(
        //   "Wisdom of the Day",
        //   style: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //     color: Color(0xFF0D3B66),
        //   ),
        // ),
        // const SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: 75.0.h,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 5),
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
          ),
          items:
              wisdoms.map((wisdom) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: context.secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          wisdom,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: context.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}

final List<String> wisdoms = [
  "Speak good or remain silent.",
  // "The best among you are those who have the best manners and character.",
  "A smile is charity.",
  // "Do not waste water, even if you perform ablution on a running river.",
  "Seek knowledge from the cradle to the grave.",
  "Strive for excellence in whatever you do.",
  "Kindness is a mark of faith, and whoever is not kind has no faith.",
  // "The strong is not the one who overcomes others, but the one who controls himself in anger.",
  "He who does not thank people does not thank Allah.",
  "Patience is the key to relief.",
  // "The best among you is the one who doesn't harm others with his tongue and hands.",
  "Modesty brings nothing except good.",
  "Seek knowledge from the cradle to the grave.",
];
