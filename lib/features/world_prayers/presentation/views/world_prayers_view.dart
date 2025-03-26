import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/router/app_routes_names.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/features/main_homepage/cubits/prayers_time_api/prayers_time_api_cubit.dart';
import 'package:home_widget_4/features/main_homepage/models/prayers_time_model.dart';
import 'package:home_widget_4/features/main_homepage/presentation/widgets/all_prays_time_widget.dart';
import 'package:home_widget_4/utils/assets/assets.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as Lot;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WorldPrayersView extends StatefulWidget {
  const WorldPrayersView({super.key});

  @override
  State<WorldPrayersView> createState() => _WorldPrayersViewState();
}

class _WorldPrayersViewState extends State<WorldPrayersView> {
  Marker? _marker;

  void _handleTap(LatLng latlng) {
    setState(() {
      _marker = Marker(point: latlng, child: Icon(MdiIcons.mosque, color: Colors.red, size: 40));
    });
    _showLatLngDialog(latlng);
  }

  void _showLatLngDialog(LatLng latlng) {
    showDialog(
      context: context,
      builder:
          (ctx) => Dialog.fullscreen(
            backgroundColor: Colors.white.withOpacity(0.7),
            child: WorldPrayersModal(latLng: latlng),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WORLD_PRAYERS'.tr(), style: const TextStyle(color: Colors.white)),
      ),
      // endDrawer: const DefaultDrawer(opacity: 0.7),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(21.4225, 39.8262),
          initialZoom: 5,
          onTap: (tapPosition, latlng) => _handleTap(latlng),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          if (_marker != null) MarkerLayer(markers: [_marker!]),
          // const RichAttributionWidget(
          //   attributions: [
          //     // TextSourceAttribution(
          //     //   'OpenStreetMap contributors',
          //     //   // onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
          //     // ),
          //     // Also add images...
          //   ],
          // ),
        ],
      ),
    );
  }
}

class WorldPrayersModal extends StatefulWidget {
  const WorldPrayersModal({super.key, required this.latLng});
  final LatLng latLng;

  @override
  State<WorldPrayersModal> createState() => _WorldPrayersModalState();
}

class _WorldPrayersModalState extends State<WorldPrayersModal> {
  @override
  Widget build(BuildContext context) {
    final lat = widget.latLng.latitude.toStringAsFixed(3);
    final long = widget.latLng.longitude.toStringAsFixed(3);
    return BlocProvider(
      create:
          (context) => PrayerTimesApiCubit(
            params: PrayerTimeParams(
              latitude: widget.latLng.latitude,
              longitude: widget.latLng.longitude,
              date: DateTime.now(),
              latitudeAdjustmentMethod: LatitudeAdjustmentMethod.angleBased,
              method: IslamicOrganization.muslimWorldLeague,
            ),
          )..getPrayerTime(),
      child: BlocBuilder<PrayerTimesApiCubit, ApiResponseModel<PrayersTimeModel>>(
        builder: (context, state) {
          return Container(
            width: context.width,
            height: context.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetsData.worldPrayersBackground),
              ),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 100),
                // const Text(
                //   'Coordinates',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       'Latitude: ',
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //     ),
                //     Text(
                //       lat,
                //       style: TextStyle(fontSize: 25, color: context.primaryColor),
                //     ),
                //     const Text(
                //       ' | Longitude: ',
                //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //     ),
                //     Text(
                //       long,
                //       style: TextStyle(fontSize: 25, color: context.primaryColor),
                //     ),
                //   ],
                // ),
                if (state.response == ResponseEnum.loading)
                  SizedBox(height: 180.h, child: const Center(child: CircularProgressIndicator())),
                if (state.response == ResponseEnum.success)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       'Time Zone: ',
                      //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      //     ),
                      //     Text(
                      //       state.currentTimeZone ?? '',
                      //       style: TextStyle(fontSize: 25, color: context.primaryColor),
                      //     ),
                      //   ],
                      // ),
                      CityAndCountryByPositionWidget(position: widget.latLng),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: PrayersWidget(state.data),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                      label: Text('BACK'.tr(), style: const TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 19),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed:
                          () => Navigator.of(
                            context,
                          ).pushNamedAndRemoveUntil(AppRoutesNames.mainHomepage, (_) => false),
                      label: Text('HOME'.tr(), style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CityAndCountryByPositionWidget extends StatefulWidget {
  const CityAndCountryByPositionWidget({super.key, required this.position});
  final LatLng position;
  @override
  State<CityAndCountryByPositionWidget> createState() => _CityAndCountryByPositionWidgetState();
}

class _CityAndCountryByPositionWidgetState extends State<CityAndCountryByPositionWidget> {
  String? city;
  @override
  void initState() {
    getCityNameByPosition(widget.position).then((fetchedCity) {
      setState(() {
        city = fetchedCity;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (city == null)
            Opacity(
              opacity: 0.1,
              child: Lot.Lottie.asset(AssetsData.map, width: 90, height: 90, fit: BoxFit.cover),
            ),
          if (city != null)
            SizedBox(
              child: Lot.Lottie.asset(AssetsData.map, width: 90, height: 90, fit: BoxFit.cover),
            ).animate().moveX(duration: 1000.ms, begin: 200, end: 0),
          const SizedBox(width: 5),
          if (city != null)
            Expanded(
              child: AutoSizeText(
                city!,
                style: TextStyle(fontSize: 25, color: context.primaryColor),
              ),
            ).animate().moveX(duration: 1000.ms, begin: 200, end: 0),
        ],
      ),
    );
  }
}
// class WorldPrayersWidget extends StatelessWidget {
//   const WorldPrayersWidget(
//     this.state, {
//     super.key,
//   });
//   final PrayerTimeByPositionState state;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SizedBox(width: 5.w),
//         PrayTimeWidget2(
//           pray: 'Fajr',
//           imagePath: AssetsData.three,
//           dateTime: state.prayerTimes?.fajr,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget2(
//           pray: 'Dhuhr',
//           imagePath: AssetsData.two,
//           dateTime: state.prayerTimes?.dhuhr,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget2(
//           pray: 'Asr',
//           imagePath: AssetsData.one,
//           dateTime: state.prayerTimes?.asr,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget2(
//           pray: 'Maghrib',
//           imagePath: AssetsData.four,
//           dateTime: state.prayerTimes?.maghrib,
//           currentTimeZone: state.currentTimeZone,
//         ),
//         PrayTimeWidget2(
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

// class PrayTimeWidget2 extends StatelessWidget {
//   const PrayTimeWidget2(
//       {super.key, required this.pray, required this.imagePath, required this.dateTime, required this.currentTimeZone});
//   final String pray;
//   final DateTime? dateTime;
//   final String imagePath;
//   final String? currentTimeZone;
//   @override
//   Widget build(BuildContext context) {
//     // if (dateTime == null) return const SizedBox();
//     DateTime? localTime = dateTime == null || currentTimeZone == null ? null : utcToLocal(dateTime!, currentTimeZone!);
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
