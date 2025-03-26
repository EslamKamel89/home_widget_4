// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/enums/response_state.dart';

class PrayersTimesTodayState {
  Position? currentPosition;
  PrayerTimes? prayerTimes;
  String? nextPrayer;
  Duration? timeRemaining;
  String? currentTimeZone;
  Timer? timer;
  ResponseEnum? response;
  PrayersTimesTodayState({
    this.currentPosition,
    this.prayerTimes,
    this.nextPrayer,
    this.timeRemaining,
    this.currentTimeZone,
    this.timer,
    this.response,
  });

  PrayersTimesTodayState copyWith({
    Position? currentPosition,
    PrayerTimes? prayerTimes,
    String? nextPrayer,
    Duration? timeRemaining,
    String? currentTimeZone,
    Timer? timer,
    ResponseEnum? response,
  }) {
    return PrayersTimesTodayState(
      currentPosition: currentPosition ?? this.currentPosition,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      currentTimeZone: currentTimeZone ?? this.currentTimeZone,
      timer: timer ?? this.timer,
      response: response ?? this.response,
    );
  }

  @override
  String toString() {
    return 'PrayersTimesTodayState(currentPosition: $currentPosition, prayerTimes: $prayerTimes, nextPrayer: $nextPrayer, timeRemaining: $timeRemaining, currentTimeZone: $currentTimeZone, timer: $timer, response: $response)';
  }
}
