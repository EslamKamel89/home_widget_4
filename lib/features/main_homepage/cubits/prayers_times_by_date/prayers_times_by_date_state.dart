// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prayers_times_by_date_cubit.dart';

class PrayersTimesByDateState {
  Position? currentPosition;
  PrayerTimes? prayerTimes;
  String? currentTimeZone;
  ResponseEnum? response;
  PrayersTimesByDateState({
    this.currentPosition,
    this.prayerTimes,
    this.currentTimeZone,
    this.response,
  });

  PrayersTimesByDateState copyWith({
    Position? currentPosition,
    PrayerTimes? prayerTimes,
    String? currentTimeZone,
    ResponseEnum? response,
  }) {
    return PrayersTimesByDateState(
      currentPosition: currentPosition ?? this.currentPosition,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      currentTimeZone: currentTimeZone ?? this.currentTimeZone,
      response: response ?? this.response,
    );
  }

  @override
  String toString() {
    return 'PrayersTimesByDateState(currentPosition: $currentPosition, prayerTimes: $prayerTimes, currentTimeZone: $currentTimeZone, response: $response)';
  }
}
