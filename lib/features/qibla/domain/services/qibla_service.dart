// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:home_widget_4/core/globals/globals_var.dart';
// import 'package:home_widget_4/core/heleprs/snackbar.dart';

// class QiblaService {
//   static Future<Position?> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     BuildContext? context = navigatorKey.currentContext;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       if (context != null) showSnackbar('Error', 'Location services are disabled.', true);
//       return null;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         if (context != null) showSnackbar('Error', 'Location services are denied.', true);
//         return null;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       if (context != null) {
//         showSnackbar('Error', 'Location permissions are permanently denied, we cannot request permissions.', true);
//       }
//       return null;
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   static double calculateQiblaBearing(double userLat, double userLng) {
//     const double kaabaLat = 21.4225;
//     const double kaabaLng = 39.8262;

//     // Convert degrees to radians
//     double userLatRad = userLat * (pi / 180);
//     double userLngRad = userLng * (pi / 180);
//     double kaabaLatRad = kaabaLat * (pi / 180);
//     double kaabaLngRad = kaabaLng * (pi / 180);

//     // Calculate bearing
//     double y = sin(kaabaLngRad - userLngRad) * cos(kaabaLatRad);
//     double x = cos(userLatRad) * sin(kaabaLatRad) - sin(userLatRad) * cos(kaabaLatRad) * cos(kaabaLngRad - userLngRad);
//     double bearing = atan2(y, x);

//     // Convert radians to degrees and normalize
//     bearing = (bearing * (180 / pi) + 360) % 360;

//     return bearing;
//   }
// }
