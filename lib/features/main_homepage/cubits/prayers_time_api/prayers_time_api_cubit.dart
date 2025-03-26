import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/features/main_homepage/controllers/prayers_controller.dart';
import 'package:home_widget_4/features/main_homepage/models/prayers_time_model.dart';

class PrayerTimesApiCubit extends Cubit<ApiResponseModel<PrayersTimeModel>> {
  final PrayersController controller = serviceLocator();
  PrayerTimeParams params;
  PrayerTimesApiCubit({required this.params})
    : super(ApiResponseModel<PrayersTimeModel>(response: ResponseEnum.initial));
  Future getPrayerTime() async {
    final t = prt('getPrayerTime - PrayerTimesApiCubit');
    emit(pr(state.copyWith(errorMessage: null, response: ResponseEnum.loading), t));
    pr(params, t);
    emit(pr(await controller.prayerTime(params), t));
  }
}
