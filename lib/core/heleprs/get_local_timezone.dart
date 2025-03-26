import 'package:flutter_timezone/flutter_timezone.dart';

Future<String> getLocalTimezone() async {
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  return currentTimeZone;
}
