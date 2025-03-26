import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/enums/prayer_calc_method.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/get_local_timezone.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';

part 'prayers_times_by_date_state.dart';

class PrayersTimesByDateCubit extends Cubit<PrayersTimesByDateState> {
  PrayersTimesByDateCubit() : super(PrayersTimesByDateState(response: ResponseEnum.initial));
  Future getPrayersTimesByDate(DateTime date) async {
    final t = prt('getPrayersTimesByDate - PrayersTimesByDateCubit');
    emit(state.copyWith(response: ResponseEnum.loading));
    Position? currentPosition = await serviceLocator<GeoPosition>().position();
    if (currentPosition == null) return pr('currentPosition is null', t);
    String currentTimeZone = await getLocalTimezone();

    final coordinates = Coordinates(currentPosition.latitude, currentPosition.longitude);
    final params = _params();
    params.madhab = Madhab.hanafi;
    PrayerTimes prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: date,
      calculationParameters: params,
      precision: true,
    );

    emit(
      pr(
        state.copyWith(
          currentPosition: currentPosition,
          prayerTimes: prayerTimes,
          currentTimeZone: currentTimeZone,
          response: ResponseEnum.success,
        ),
        t,
      ),
    );
  }

  dynamic _params() {
    PrayerCalcMethod calcMethod = PrayerCalcMethod.muslimWorldLeague;
    pr(calcMethod);

    switch (calcMethod) {
      case PrayerCalcMethod.muslimWorldLeague:
        return CalculationMethod.muslimWorldLeague();
      case PrayerCalcMethod.egyptian:
        return CalculationMethod.egyptian();
      case PrayerCalcMethod.karachi:
        return CalculationMethod.karachi();
      case PrayerCalcMethod.ummAlQura:
        return CalculationMethod.ummAlQura();
      case PrayerCalcMethod.dubai:
        return CalculationMethod.dubai();
      case PrayerCalcMethod.qatar:
        return CalculationMethod.qatar();
      case PrayerCalcMethod.kuwait:
        return CalculationMethod.kuwait();
      case PrayerCalcMethod.moonsightingCommittee:
        return CalculationMethod.moonsightingCommittee();
      case PrayerCalcMethod.singapore:
        return CalculationMethod.singapore();
      case PrayerCalcMethod.turkiye:
        return CalculationMethod.turkiye();
      case PrayerCalcMethod.tehran:
        return CalculationMethod.tehran();
      case PrayerCalcMethod.northAmerica:
        return CalculationMethod.northAmerica();
    }
  }
}
