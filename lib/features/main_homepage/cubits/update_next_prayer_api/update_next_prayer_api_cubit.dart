import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/now.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/features/main_homepage/controllers/prayers_controller.dart';
import 'package:home_widget_4/features/main_homepage/models/prayers_time_model.dart';

part 'update_next_prayer_api_state.dart';

class UpdateNextPrayerApiCubit extends Cubit<UpdateNextPrayerApiState> {
  final PrayersController controller = serviceLocator();
  Timer? timer;
  PrayerTimeParams? params;
  UpdateNextPrayerApiCubit() : super(UpdateNextPrayerApiState(response: ResponseEnum.initial));
  Future init() async {
    // ignore: prefer_conditional_assignment
    if (params == null) {
      // Position? position = await serviceLocator<GeoPosition>().position();
      // if (position == null) {
      //   await Future.delayed(const Duration(seconds: 1));
      //   position = await serviceLocator<GeoPosition>().position();
      //   if (position == null) {
      //     showSnackbar('Error', "Can't fetch location", true);
      //     return;
      //   }
      // }
      params = PrayerTimeParams(
        // latitude: position.latitude,
        // longitude: position.longitude,
        latitudeAdjustmentMethod: LatitudeAdjustmentMethod.angleBased,
        method: IslamicOrganization.muslimWorldLeague,
        date: customNow(),
      );
    }
    emit(state.copyWith(response: ResponseEnum.loading));
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) async {
      await _nextPrayerPeriodicFunction();
    });
  }

  Future _nextPrayerPeriodicFunction() async {
    // final t = prt('_nextPrayerPeriodicFunction - UpdateNextPrayerApiCubit');
    DateTime now = customNow();
    Position? position = await serviceLocator<GeoPosition>().position();
    if ([position, position?.latitude, position?.longitude].contains(null)) {
      // pr('position is null', t);
      return;
    }
    params = params!.copyWith(latitude: position!.latitude, longitude: position.longitude);

    if (params!.date?.day != now.day || state.prayerTimeModel == null) {
      params!.date = now;
      state.prayerTimeModel = (await controller.prayerTime(params!)).data;
      state.nextDayPrayerTimeModel =
          (await controller.prayerTime(
            params!.copyWith(date: params?.date?.add(const Duration(days: 1))),
          )).data;
    }
    if (state.prayerTimeModel == null || state.nextDayPrayerTimeModel == null) {
      // pr('Error Occured: prayerTimeModel is null', t);
      return;
    }
    NextPrayerModel nextPrayerModel = state.prayerTimeModel!.getNextPrayer();
    if (nextPrayerModel.nextPrayer?.contains('Fajr') == true) {
      // state.prayerTimeModel =
      //     (await controller.prayerTime(params!.copyWith(date: now.add(const Duration(days: 1))))).data;
      DateTime? fajrTime =
          nextPrayerModel.nextPrayerTime ?? state.nextDayPrayerTimeModel?.fajrDateTime();
      // pr(fajrTime, '$t - next day fajr time');
      emit(
        state.copyWith(
          nextPrayer: nextPrayerModel.nextPrayer,
          nextPrayerTime: fajrTime,
          prayerTimeModel: state.prayerTimeModel,
          timeRemaining: fajrTime?.difference(now),
          response: ResponseEnum.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          nextPrayer: nextPrayerModel.nextPrayer,
          nextPrayerTime: nextPrayerModel.nextPrayerTime,
          prayerTimeModel: state.prayerTimeModel,
          timeRemaining: nextPrayerModel.nextPrayerTime?.difference(now),
          response: ResponseEnum.success,
        ),
      );
    }
  }
}
