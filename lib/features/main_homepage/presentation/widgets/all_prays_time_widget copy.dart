// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:home_widget_4/core/heleprs/format_date.dart';
// import 'package:home_widget_4/core/heleprs/utc_to_local_timezone.dart';
// import 'package:home_widget_4/core/service_locator/service_locator.dart';
// import 'package:home_widget_4/core/widgets/custom_fading_widget.dart';
// import 'package:home_widget_4/core/widgets/setting_drop_down.dart';
// import 'package:home_widget_4/features/date_conversion/domain/repo/date_conversion_repo.dart';
// import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';
// import 'package:home_widget_4/features/main_homepage/cubits/prayers_times_by_date/prayers_times_by_date_cubit.dart';
// import 'package:home_widget_4/utils/assets/assets.dart';
// import 'package:home_widget_4/utils/styles/styles.dart';

// class AllPraysTimeWidget extends StatefulWidget {
//   const AllPraysTimeWidget({
//     super.key,
//   });

//   @override
//   State<AllPraysTimeWidget> createState() => _AllPraysTimeWidgetState();
// }

// class _AllPraysTimeWidgetState extends State<AllPraysTimeWidget> {
//   DateTime selectedDate = DateTime.now();
//   String? newHijriDate;
//   @override
//   void initState() {
//     super.initState();
//     getNewHijri();
//     selectedPrayersNotifier.addListener(() {
//       if (mounted) {
//         context
//             .read<PrayersTimesByDateCubit>()
//             .getPrayersTimesByDate(selectedDate);
//       }
//     });
//   }

//   Future getNewHijri() async {
//     DateConversionRepo repo = serviceLocator();
//     final response = await repo.getDateConversion(
//         selectedDate, DataProcessingOption.regular);
//     response.fold((_) {}, (model) {
//       if (mounted) {
//         setState(() {
//           newHijriDate = model.newHijriUpdated;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PrayersTimesByDateCubit, PrayersTimesByDateState>(
//       builder: (context, state) {
//         final controller = context.read<PrayersTimesByDateCubit>();
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 2),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                         onTap: () async {
//                           selectedDate =
//                               selectedDate.subtract(const Duration(days: 1));
//                           controller.getPrayersTimesByDate(selectedDate);
//                           getNewHijri();
//                         },
//                         child: Icon(Icons.arrow_back_ios_rounded, size: 30.w)),
//                     Column(
//                       children: [
//                         txt(formateDateDetailed(selectedDate)),
//                         if (newHijriDate != null) txt(newHijriDate ?? ''),
//                       ],
//                     ),
//                     InkWell(
//                         onTap: () async {
//                           selectedDate =
//                               selectedDate.add(const Duration(days: 1));
//                           controller.getPrayersTimesByDate(selectedDate);
//                           getNewHijri();
//                         },
//                         child:
//                             Icon(Icons.arrow_forward_ios_rounded, size: 30.w)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Material(
//                 borderRadius: BorderRadius.circular(15.w),
//                 elevation: 2,
//                 shadowColor: Colors.grey.withOpacity(0.3),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.w),
//                     color: Colors.white,
//                   ),
//                   child: PrayersWidget(state)
//                       .animate()
//                       .fade(duration: 1000.ms, begin: 0, end: 1),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class PrayersWidget extends StatelessWidget {
//   const PrayersWidget(
//     this.state, {
//     super.key,
//   });
//   final PrayersTimesByDateState state;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SizedBox(width: 5.w),
//         PrayTimeWidget(
//           pray: 'Fajr',
//           imagePath: AssetsData.three,
//           dateTime: state.prayerTimes?.fajr,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget(
//           pray: 'Dhuhr',
//           imagePath: AssetsData.two,
//           dateTime: state.prayerTimes?.dhuhr,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget(
//           pray: 'Asr',
//           imagePath: AssetsData.one,
//           dateTime: state.prayerTimes?.asr,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget(
//           pray: 'Maghrib',
//           imagePath: AssetsData.four,
//           dateTime: state.prayerTimes?.maghrib,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget(
//           pray: 'Isha',
//           imagePath: AssetsData.five,
//           dateTime: state.prayerTimes?.isha,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         SizedBox(width: 5.w),
//       ],
//     );
//   }
// }

// class PrayTimeWidget extends StatelessWidget {
//   const PrayTimeWidget(
//       {super.key,
//       required this.pray,
//       required this.imagePath,
//       required this.dateTime,
//       required this.currentTimeZone});
//   final String pray;
//   final DateTime? dateTime;
//   final String imagePath;
//   final String? currentTimeZone;
//   @override
//   Widget build(BuildContext context) {
//     // if (dateTime == null) return const SizedBox();
//     DateTime? localTime = dateTime == null || currentTimeZone == null
//         ? null
//         : utcToLocal(dateTime!, currentTimeZone!);
//     String? amOrpm;
//     int? hour = localTime == null
//         ? null
//         : localTime.hour > 12
//             ? localTime.hour - 12
//             : localTime.hour;
//     amOrpm = localTime == null
//         ? null
//         : localTime.hour >= 12
//             ? 'PM'
//             : 'AM';
//     String hoursStr = hour == null
//         ? ''
//         : hour.toString().length == 1
//             ? '0$hour'
//             : hour.toString();
//     String minutesStr = localTime == null
//         ? ''
//         : localTime.minute.toString().length == 1
//             ? '0${localTime.minute}'
//             : localTime.minute.toString();

//     return SizedBox(
//       // height: 110.h,
//       // color: Colors.red,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           txt((pray)),
//           const SizedBox(height: 5),
//           dateTime == null
//               ? CustomFadingWidget(
//                   child: _buildImage(),
//                 )
//               : _buildImage(),
//           const SizedBox(height: 5),
//           dateTime == null
//               ? CustomFadingWidget(child: txt('00:00', e: St.reg14))
//               : txt('$hoursStr:$minutesStr\n$amOrpm', e: St.reg14),
//         ],
//       ),
//     );
//   }

//   Container _buildImage() {
//     return Container(
//       width: 30.w,
//       height: 30.w,
//       clipBehavior: Clip.hardEdge,
//       decoration: const BoxDecoration(),
//       child: Image.asset(imagePath, fit: BoxFit.fill),
//     );
//   }
// }
