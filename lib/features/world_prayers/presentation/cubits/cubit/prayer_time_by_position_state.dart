// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prayer_time_by_position_cubit.dart';

class PrayerTimeByPositionState {
  LatLng? position;
  PrayerTimes? prayerTimes;
  String? currentTimeZone;
  ResponseEnum? response;
  String? city;
  PrayerTimeByPositionState({
    this.position,
    this.prayerTimes,
    this.currentTimeZone,
    this.response,
    this.city,
  });

  PrayerTimeByPositionState copyWith({
    LatLng? position,
    PrayerTimes? prayerTimes,
    String? currentTimeZone,
    ResponseEnum? response,
    String? city,
  }) {
    return PrayerTimeByPositionState(
      position: position ?? this.position,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      currentTimeZone: currentTimeZone ?? this.currentTimeZone,
      response: response ?? this.response,
      city: city ?? this.city,
    );
  }

  @override
  String toString() {
    return 'PrayerTimeByPositionState(position: $position, prayerTimes: $prayerTimes, currentTimeZone: $currentTimeZone, response: $response, city: $city)';
  }
}
