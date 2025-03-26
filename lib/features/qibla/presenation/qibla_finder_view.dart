import 'dart:math';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/utils/assets/assets.dart';
// class QiblaFinderView extends StatefulWidget {
//   const QiblaFinderView({super.key});

//   @override
//   State<QiblaFinderView> createState() => _QiblaFinderViewState();
// }

// class _QiblaFinderViewState extends State<QiblaFinderView> {
//   Stream<double>? _compassStream;

// void initCompass() {
//   _compassStream = SensorsPlatform.instance
//       .map((event) => event.heading)
//       .handleError((error) {
//     // Handle sensor errors
//   });
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.grey.withOpacity(0.2),
//         foregroundColor: Colors.black,
//         title: const Text('Qibla Finder', style: TextStyle(color: Colors.black)),
//       ),
//       endDrawer: const DefaultDrawer(opacity: 0.7),
//       body: const SingleChildScrollView(
//         child: Column(
//           children: [],
//         ),
//       ),
//     );
//   }
// }

class QiblaFinderView extends StatefulWidget {
  const QiblaFinderView({super.key});

  @override
  State<QiblaFinderView> createState() => _QiblaFinderViewState();
}

class _QiblaFinderViewState extends State<QiblaFinderView> {
  Future<Position?>? getPosition;

  @override
  void initState() {
    super.initState();
    getPosition = serviceLocator<GeoPosition>().position();
  }

  @override
  Widget build(BuildContext context) {
    // return const CustomPainterTest();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: context.secondaryHeaderColor,
      appBar: AppBar(
        // backgroundColor: Colors.white.withOpacity(0.3),
        title: Text('FIND_QIBLA'.tr(), style: const TextStyle(color: Colors.white)),
      ),
      // endDrawer: const DefaultDrawer(opacity: 0.7),
      body: SafeArea(
        child: FutureBuilder<Position?>(
          future: getPosition,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Position positionResult = snapshot.data!;
              Coordinates coordinates = Coordinates(
                positionResult.latitude,
                positionResult.longitude,
              );
              double qiblaDirection = Qibla.qibla(coordinates);
              return StreamBuilder(
                stream: FlutterCompass.events,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error reading heading: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }

                  double? direction = snapshot.data!.heading;

                  // if direction is null,
                  // then device does not support this sensor

                  // show error message
                  if (direction == null) {
                    return const Center(child: Text("Device does not have sensors !"));
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: size,
                              painter: CompassCustomPainter(angle: direction),
                            ),
                            Transform.rotate(
                              angle: -2 * pi * (direction / 360),
                              child: Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.rotationZ(qiblaDirection * pi / 180),
                                origin: Offset.zero,
                                child: Image.asset(
                                  AssetsData.kabaa,
                                  width: 112,
                                  // height: 32,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              radius: 140,
                              child: Transform.rotate(
                                angle: -2 * pi * (direction / 360),
                                child: Transform(
                                  alignment: FractionalOffset.center,
                                  transform: Matrix4.rotationZ(qiblaDirection * pi / 180),
                                  origin: Offset.zero,
                                  child: const Align(
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.expand_less_outlined,
                                      color: Colors.black,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0, 0.45),
                              child: Text(
                                showHeading(direction, qiblaDirection),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          },
        ),
      ),
    );
  }
}

String showHeading(double direction, double qiblaDirection) {
  return qiblaDirection.toInt() != direction.toInt()
      ? '${direction.toStringAsFixed(0)}°'
      : "You're facing Makkah!";
}

class CompassCustomPainter extends CustomPainter {
  final double angle;

  const CompassCustomPainter({required this.angle});

  // Keeps rotating the North Red Triangle
  double get rotation => -angle * pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    // Minimal Compass

    // Center The Compass In The Middle Of The Screen
    canvas.translate(size.width / 2, size.height / 2);

    Paint circle =
        Paint()
          ..strokeWidth = 2
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    Paint shadowCircle =
        Paint()
          ..strokeWidth = 2
          ..color = Colors.grey.withOpacity(.2)
          ..style = PaintingStyle.fill;

    // Draw Shadow For Outer Circle
    canvas.drawCircle(Offset.zero, 107, shadowCircle);

    // Draw Outer Circle
    canvas.drawCircle(Offset.zero, 100, circle);

    Paint darkIndexLine =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round;

    Paint lightIndexLine =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    Paint northRedBrush =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 4;

    canvas.rotate(-pi / 2);

    // Draw The Light Grey Lines 16 Times While Rotating 22.5° Degrees
    for (int i = 1; i <= 16; i++) {
      canvas.drawLine(
        Offset.fromDirection(-(angle + 22.5 * i) * pi / 180, 60),
        Offset.fromDirection(-(angle + 22.5 * i) * pi / 180, 80),
        lightIndexLine,
      );
    }

    // Draw The Dark Grey Lines 3 Times While Rotating 90° Degrees
    for (int i = 1; i <= 3; i++) {
      canvas.drawLine(
        Offset.fromDirection(-(angle + 90 * i) * pi / 180, 60),
        Offset.fromDirection(-(angle + 90 * i) * pi / 180, 80),
        darkIndexLine,
      );
    }

    canvas.drawLine(
      Offset.fromDirection(rotation, 60),
      Offset.fromDirection(rotation, 80),
      northRedBrush,
    );

    // Draw North Triangle
    // Path path = Path();
    // path.moveTo(
    //   Offset.fromDirection(rotation, 85).dx,
    //   Offset.fromDirection(rotation, 85).dy,
    // );
    // path.lineTo(
    //   Offset.fromDirection(-(angle + 15) * pi / 180, 60).dx,
    //   Offset.fromDirection(-(angle + 15) * pi / 180, 60).dy,
    // );
    // path.lineTo(
    //   Offset.fromDirection(-(angle - 15) * pi / 180, 60).dx,
    //   Offset.fromDirection(-(angle - 15) * pi / 180, 60).dy,
    // );

    // path.close();
    // canvas.drawPath(path, northTriangle);

    // Draw Shadow For Inner Circle
    canvas.drawCircle(Offset.zero, 68, shadowCircle);

    // Draw Inner Circle
    canvas.drawCircle(Offset.zero, 65, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
