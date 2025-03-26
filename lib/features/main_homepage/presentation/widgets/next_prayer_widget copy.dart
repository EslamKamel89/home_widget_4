// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:home_widget_4/core/enums/response_state.dart';
// import 'package:home_widget_4/core/extensions/context-extensions.dart';
// import 'package:home_widget_4/core/service_locator/service_locator.dart';
// import 'package:home_widget_4/core/widgets/sizer.dart';
// import 'package:home_widget_4/features/date_conversion/domain/repo/date_conversion_repo.dart';
// import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';
// import 'package:home_widget_4/features/main_homepage/cubits/prayer_times_today/prayers_times_today_cubit.dart';
// import 'package:home_widget_4/features/main_homepage/cubits/prayer_times_today/prayers_times_today_state.dart';
// import 'package:home_widget_4/features/main_homepage/presentation/widgets/city_widget.dart';
// import 'package:home_widget_4/utils/assets/assets.dart';

// class NextPrayerWidget extends StatefulWidget {
//   const NextPrayerWidget({
//     super.key,
//   });

//   @override
//   State<NextPrayerWidget> createState() => _NextPrayerWidgetState();
// }

// class _NextPrayerWidgetState extends State<NextPrayerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PrayersTimesTodayCubit, PrayersTimesTodayState>(
//       builder: (context, state) {
//         // if (state.nextPrayer == null || state.timeRemaining == null) return const SizedBox();
//         if (state.response != ResponseEnum.success) {
//           return const PrayerCard(
//                   prayerName: '', timeRemaining: Duration(seconds: 0))
//               .animate(onPlay: (controller) => controller.repeat)
//               .fade(duration: 500.ms, begin: 0, end: 0.5);
//         }
//         return PrayerCard(
//             prayerName: state.nextPrayer ?? '',
//             timeRemaining: state.timeRemaining ?? const Duration(seconds: 0));
//       },
//     );
//   }
// }

// class PrayerCard extends StatefulWidget {
//   final String prayerName;
//   final Duration timeRemaining;

//   const PrayerCard({
//     super.key,
//     required this.prayerName,
//     required this.timeRemaining,
//   });

//   @override
//   State<PrayerCard> createState() => _PrayerCardState();
// }

// class _PrayerCardState extends State<PrayerCard> {
//   @override
//   Widget build(BuildContext context) {
//     // Format the remaining time as HH:MM:SS.
//     final hours = widget.timeRemaining.inHours;
//     final minutes = widget.timeRemaining.inMinutes.remainder(60);
//     final seconds = widget.timeRemaining.inSeconds.remainder(60);
//     final timeRemainingText = '${hours.toString().padLeft(2, '0')}:'
//         '${minutes.toString().padLeft(2, '0')}:'
//         '${seconds.toString().padLeft(2, '0')}';

//     return Card(
//       elevation: 8,
//       color: Colors.transparent,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         // padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           // Gradient background for an attractive look
//           gradient: LinearGradient(
//             colors: [
//               context.primaryColor.withOpacity(0.4),
//               context.primaryColor
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Islamic themed icon; you can replace with a custom asset if needed.
//             // Icon(
//             //   MdiIcons.mosque,
//             //   color: Colors.white,
//             //   size: 40.w,
//             // ),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 decoration: const BoxDecoration(),
//                 clipBehavior: Clip.hardEdge,
//                 child: Image.asset(
//                   AssetsData.islamicBorder,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Next Prayer',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     widget.prayerName,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Time Remaining:',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 18,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   Text(
//                     timeRemainingText,
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const CityWidget(),
//                   const SizedBox(height: 5),
//                   // const NewHijrWidget(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NewHijrWidget extends StatefulWidget {
//   const NewHijrWidget({super.key});

//   @override
//   State<NewHijrWidget> createState() => _NewHijrWidgetState();
// }

// class _NewHijrWidgetState extends State<NewHijrWidget> {
//   String? newHijriDate;
//   @override
//   void initState() {
//     getNewHijri();
//     super.initState();
//   }

//   Future getNewHijri() async {
//     DateConversionRepo repo = serviceLocator();
//     final response = await repo.getDateConversion(
//         DateTime.now(), DataProcessingOption.regular);
//     response.fold((_) {}, (model) {
//       if (mounted) {
//         setState(() {
//           newHijriDate = model.newHijriUpdated;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (newHijriDate == null) return const SizedBox();
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Image.asset(
//           'assets/images/calendar_7.png',
//           width: 20.w,
//           height: 20.w,
//         ),
//         const Sizer(),
//         Text(
//           newHijriDate ?? '',
//           style: const TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//       ],
//     );
//   }
// }
