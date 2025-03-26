import 'package:shared_preferences/shared_preferences.dart';

class AppMiddleWare {
  SharedPreferences sharedPreferences;
  AppMiddleWare({required this.sharedPreferences});
  static bool _onBoarding() {
    return true;
  }

  static bool _isSignedIn() {
    return true;
  }

  String? middlleware(String? routeName) {
    return routeName;
  }
}
