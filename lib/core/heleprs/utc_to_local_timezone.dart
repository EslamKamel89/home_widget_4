import 'package:timezone/timezone.dart' as tz;

DateTime utcToLocal(DateTime time, String currentTimeZone) {
  try {
    final timezone = tz.getLocation(currentTimeZone);
    return tz.TZDateTime.from(time, timezone);
  } on Exception catch (e) {
    return time;
  }
}
