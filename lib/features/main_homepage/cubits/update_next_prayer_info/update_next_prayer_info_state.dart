// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_next_prayer_info_cubit.dart';

class UpdateNextPrayerInfoState {
  String? nextPrayer;
  Duration? timeRemaining;

  UpdateNextPrayerInfoState({
    this.nextPrayer,
    this.timeRemaining,
  });

  @override
  String toString() =>
      'UpdateNextPrayerInfoState(nextPrayer: $nextPrayer, timeRemaining: $timeRemaining)';
}
