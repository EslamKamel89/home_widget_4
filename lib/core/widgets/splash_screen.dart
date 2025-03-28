import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/globals/calc_method_settings.dart';
import 'package:home_widget_4/core/globals/globals_var.dart';
import 'package:home_widget_4/core/router/app_routes_names.dart';
import 'package:home_widget_4/core/themes/themedata.dart';
import 'package:home_widget_4/features/home_widget/controller/home_widget_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    cachePrayerMehtod();
    // HomeWidgetController.sendDataToHomeWidget('this is a message from flutter app');
    HomeWidgetController.getPrayerTimes();

    Future.delayed(const Duration(milliseconds: 3900), () {
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.mainHomepage, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ltr,
      child: Scaffold(
        backgroundColor: context.primaryColor, // Dark blue background
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.brightness_3, // Crescent moon icon
                size: 100,
                color: lightClr.goldColor, // Gold color
              ).animate().moveX(duration: const Duration(seconds: 2), begin: -600, end: 0),
              const SizedBox(height: 20),

              const AnimatedTextWidget(
                text: 'New Islamic Calendar',
                letterAnimationDuration: Duration(milliseconds: 150),
                recombineDuration: Duration(milliseconds: 150),
                textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),

              const SizedBox(height: 10),
              const AnimatedTextWidget(
                text: 'Organize your days with faith and ease',
                letterAnimationDuration: Duration(milliseconds: 100),
                recombineDuration: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedTextWidget extends StatelessWidget {
  final String text;
  final Duration letterAnimationDuration;
  final Duration recombineDuration;
  final TextStyle? textStyle;

  const AnimatedTextWidget({
    super.key,
    required this.text,
    this.letterAnimationDuration = const Duration(milliseconds: 300),
    this.recombineDuration = const Duration(milliseconds: 500),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: letterAnimationDuration * text.length + recombineDuration,
      builder: (context, progress, child) {
        final visibleCharacters = (progress * text.length).floor();
        final isRecombining = progress >= 1;

        if (isRecombining) {
          return Text(text, style: textStyle);
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(text.length, (index) {
            if (index < visibleCharacters) {
              final animationProgress = (progress - index / text.length).clamp(0.0, 1.0);
              return Text(
                    text[index],
                    style:
                        textStyle?.copyWith(color: textStyle?.color?.withOpacity(animationProgress)) ??
                        TextStyle(color: Colors.black.withOpacity(animationProgress)),
                  )
                  .animate()
                  .fadeIn(duration: letterAnimationDuration)
                  .scale(duration: letterAnimationDuration, curve: Curves.easeInOutBack);
            }
            return const SizedBox();
          }),
        );
      },
    );
  }
}
