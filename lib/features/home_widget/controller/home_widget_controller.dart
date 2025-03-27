import 'package:home_widget/home_widget.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/features/main_homepage/controllers/prayers_controller.dart';

class HomeWidgetController {
  static const String appGroupId = 'group.gaztec4widget';
  static const String androidWidgetName = 'HomeWidget';
  static const String iosWidgetName = 'HomeWidget';
  static void sendDataToHomeWidget(String data) {
    HomeWidget.setAppGroupId(appGroupId);
    HomeWidget.saveWidgetData('data', data);
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
      pr(prayersResponse.data, 'prayersResponse.data');
    });
  }
}
