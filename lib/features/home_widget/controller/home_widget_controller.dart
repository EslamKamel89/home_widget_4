import 'package:home_widget/home_widget.dart';

class HomeWidgetController {
  static const String appGroupId = 'group.gaztec4widget';
  static const String androidWidgetName = 'HomeWidget';
  static const String iosWidgetName = 'HomeWidget';
  static void sendDataToHomeWidget(String data) {
    HomeWidget.setAppGroupId(appGroupId);
    HomeWidget.saveWidgetData('data', data);
    HomeWidget.updateWidget(iOSName: iosWidgetName, androidName: androidWidgetName);
  }
}
