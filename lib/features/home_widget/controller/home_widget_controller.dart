import 'package:home_widget/home_widget.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/int_parse.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/features/main_homepage/controllers/prayers_controller.dart';
import 'package:home_widget_4/features/main_homepage/models/prayers_time_model.dart';

class HomeWidgetController {
  static const String t = 'delete-debug';
  static const String appGroupId = 'group.gaztec4widget';
  static const String androidWidgetName = 'HomeWidget';
  static const String iosWidgetName = 'HomeWidget';
  static void sendDataToHomeWidget(PrayersTimeModel? model) {
    HomeWidget.setAppGroupId(appGroupId);
    /*
     fajr: "00:00", sunrise: "00:00" , dhuhr: "00:00" , asr: "00:00" , maghrib: "00:00" , isha: "00:00"
     */
    HomeWidget.saveWidgetData(
      'data',
      pr(
        "${_formatDateTime(model?.fajr)},${_formatDateTime(model?.sunrise)},${_formatDateTime(model?.dhuhr)},${_formatDateTime(model?.asr)},${_formatDateTime(model?.maghrib)},${_formatDateTime(model?.isha)}",
        t,
      ),
    );

    HomeWidget.updateWidget(iOSName: iosWidgetName, androidName: androidWidgetName);
  }

  static void getPrayerTimes() {
    positionNotifier.addListener(() async {
      pr('listener in HomeWidgetController is called because position is changed: ${positionNotifier.value}');
      if (positionNotifier.value == null) return;
      final params = PrayerTimeParams(
        latitude: positionNotifier.value!.latitude,
        longitude: positionNotifier.value!.longitude,
        method: IslamicOrganization.muslimWorldLeague,
        latitudeAdjustmentMethod: LatitudeAdjustmentMethod.angleBased,
        date: DateTime.now(),
      );
      final prayersResponse = await serviceLocator<PrayersController>().prayerTime(params);
      if (prayersResponse.response != ResponseEnum.success) return;
      // pr(prayersResponse.data, t);

      sendDataToHomeWidget(prayersResponse.data);
    });
  }

  static String? _formatDateTime(String? time) {
    if (time == null) return null;
    String? amOrpm;
    String? hourStr = time.split(':').first;
    String? minStr = time.split(':').last;
    if ([hourStr, minStr, time].contains(null)) {
      return null;
    }
    int? hour = intParse(hourStr);
    amOrpm = hour != null && hour >= 12 ? 'PM' : 'AM';
    hour =
        hour == null
            ? null
            : hour > 12
            ? hour - 12
            : hour;
    return '${hour.toString().padLeft(2, '0')}:$minStr\n$amOrpm';
  }
}
