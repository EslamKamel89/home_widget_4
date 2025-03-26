import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tz;
import 'package:latlong2/latlong.dart';

part 'prayer_time_by_position_state.dart';

class PrayerTimeByPositionCubit extends Cubit<PrayerTimeByPositionState> {
  PrayerTimeByPositionCubit() : super(PrayerTimeByPositionState());
  Future getPrayersTimes(LatLng currentPosition) async {
    final t = prt('getPrayersTimes - PrayerTimeByPositionCubit');
    emit(state.copyWith(response: ResponseEnum.loading));
    String currentTimeZone = tz.latLngToTimezoneString(
      currentPosition.latitude,
      currentPosition.longitude,
    );

    final coordinates = Coordinates(currentPosition.latitude, currentPosition.longitude);
    final params = CalculationMethod.muslimWorldLeague();
    params.madhab = Madhab.hanafi;

    final date = DateTime.now();
    PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
      precision: true,
    );

    emit(
      pr(
        state.copyWith(
          position: currentPosition,
          prayerTimes: prayerTimes,
          currentTimeZone: currentTimeZone,
          response: ResponseEnum.success,
          city: await getCityNameByPosition(currentPosition),
        ),
        t,
      ),
    );
  }
}
