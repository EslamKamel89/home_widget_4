import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/get_local_timezone.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/cubits/update_next_prayer_info/update_next_prayer_info_cubit.dart';
import 'package:home_widget_4/utils/assets/assets.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayerTimes2Widget extends StatefulWidget {
  const PrayerTimes2Widget({super.key});
  @override
  State<PrayerTimes2Widget> createState() => _PrayerTimes2WidgetState();
}

class _PrayerTimes2WidgetState extends State<PrayerTimes2Widget> {
  Position? _currentPosition;
  PrayerTimes? _prayerTimes;
  String? _nextPrayer;
  Duration? _timeRemaining;
  String? _currentTimeZone;
  Timer? _timer;
  late UpdateNextPrayerInfoCubit _nextPrayerController;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    _nextPrayerController = context.read<UpdateNextPrayerInfoCubit>();
    _currentPosition = await serviceLocator<GeoPosition>().position();
    if (_currentPosition == null) return;
    getLocalTimezone().then((localTimeZone) {
      _currentTimeZone = localTimeZone;
      _getPrayerTimes();
      _timer = Timer.periodic(1000.ms, (_) {
        _calculateNextPrayer();
      });
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _getPrayerTimes() {
    if (_currentPosition != null) {
      final coordinates = Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      final params = CalculationMethod.muslimWorldLeague();
      params.madhab = Madhab.hanafi;

      final date = DateTime.now();
      _prayerTimes = PrayerTimes(
        coordinates: coordinates,
        date: date,
        calculationParameters: params,
        precision: true,
      );
    }
  }

  void _calculateNextPrayer() {
    if (_prayerTimes == null) return;

    final now = DateTime.now();
    final prayers = {
      'Fajr': _prayerTimes!.fajr,
      'Dhuhr': _prayerTimes!.dhuhr,
      'Asr': _prayerTimes!.asr,
      'Maghrib': _prayerTimes!.maghrib,
      'Isha': _prayerTimes!.isha,
    };

    DateTime? nextPrayerTime;
    String? nextPrayerName;

    for (final entry in prayers.entries) {
      if (entry.value?.isAfter(now) == true) {
        nextPrayerTime = entry.value;
        nextPrayerName = entry.key;
        break;
      }
    }

    if (nextPrayerTime != null && nextPrayerName != null) {
      _nextPrayer = nextPrayerName;
      _timeRemaining = nextPrayerTime.difference(now);
      _nextPrayerController.update(
        UpdateNextPrayerInfoState(nextPrayer: _nextPrayer, timeRemaining: _timeRemaining),
      );
    }
    // pr(_nextPrayer, 'next prayer');
    // pr(_timeRemaining, 'time remaining');
  }

  DateTime _utcToLocal(DateTime time) {
    final timezone = tz.getLocation(_currentTimeZone!);
    return tz.TZDateTime.from(time, timezone);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          Container(
            width: context.width - 8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(AssetsData.prayers, fit: BoxFit.fitWidth),
          ),
          if (_prayerTimes != null)
            Positioned(
              bottom: 10,
              child: SizedBox(
                height: 100.h,
                width: context.width - 8,
                child: Row(
                  children: [
                    _prayerWidget(
                      _prayerTimes?.fajr,
                    ).animate().moveY(delay: 0.ms, begin: -700.h, end: 0, duration: 1000.ms),
                    _prayerWidget(
                      _prayerTimes?.dhuhr,
                    ).animate().moveY(delay: 300.ms, begin: -700.h, end: 0, duration: 1000.ms),
                    _prayerWidget(
                      _prayerTimes?.asr,
                    ).animate().moveY(delay: 600.ms, begin: -700.h, end: 0, duration: 1000.ms),
                    _prayerWidget(
                      _prayerTimes?.maghrib,
                    ).animate().moveY(delay: 900.ms, begin: -700.h, end: 0, duration: 1000.ms),
                    _prayerWidget(
                      _prayerTimes?.isha,
                    ).animate().moveY(delay: 1200.ms, begin: -700.h, end: 0, duration: 1000.ms),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _prayerWidget(DateTime? dateTime) {
    if (dateTime == null) return const SizedBox();
    DateTime localTime = _utcToLocal(dateTime);
    String amOrpm = 'AM';
    int hour = localTime.hour > 12 ? localTime.hour - 12 : localTime.hour;
    amOrpm = localTime.hour >= 12 ? 'PM' : 'AM';
    String hoursStr = hour.toString().length == 1 ? '0$hour' : hour.toString();
    String minutesStr =
        localTime.minute.toString().length == 1
            ? '0${localTime.minute}'
            : localTime.minute.toString();
    return Flexible(
      flex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$hoursStr :',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              minutesStr,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              amOrpm,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
