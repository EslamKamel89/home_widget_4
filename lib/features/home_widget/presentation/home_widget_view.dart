import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/features/home_widget/controller/home_widget_controller.dart';

class HomeWidgetView extends StatefulWidget {
  const HomeWidgetView({super.key});

  @override
  State<HomeWidgetView> createState() => _HomeWidgetViewState();
}

class _HomeWidgetViewState extends State<HomeWidgetView> {
  @override
  void initState() {
    HomeWidgetController.sendDataToHomeWidget('this is a message from flutter app');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Home Widget')),
        body: SingleChildScrollView(
          child: Column(
            children: [Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: HomeWidgetPrayersTime())],
          ),
        ),
      ),
    );
  }
}

class HomeWidgetPrayersTime extends StatelessWidget {
  const HomeWidgetPrayersTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Fajr'),
            const SizedBox(height: 5),
            Container(
              width: 25.w,
              height: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Image.asset('assets/images/one.png', fit: BoxFit.fill),
            ),
            const SizedBox(height: 5),
            Text("3:00\nPM"),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sunrise'),
            const SizedBox(height: 5),
            Container(
              width: 25.w,
              height: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Image.asset('assets/images/one.png', fit: BoxFit.fill),
            ),
            const SizedBox(height: 5),
            Text("3:00\nPM"),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Asr'),
            const SizedBox(height: 5),
            Container(
              width: 25.w,
              height: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Image.asset('assets/images/one.png', fit: BoxFit.fill),
            ),
            const SizedBox(height: 5),
            Text("3:00\nPM"),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Maghrib'),
            const SizedBox(height: 5),
            Container(
              width: 25.w,
              height: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Image.asset('assets/images/one.png', fit: BoxFit.fill),
            ),
            const SizedBox(height: 5),
            Text("3:00\nPM"),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Isha'),
            const SizedBox(height: 5),
            Container(
              width: 25.w,
              height: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Image.asset('assets/images/one.png', fit: BoxFit.fill),
            ),
            const SizedBox(height: 5),
            Text("3:00\nPM"),
          ],
        ),
      ],
    );
  }
}
