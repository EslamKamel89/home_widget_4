import 'dart:convert';

import 'package:home_widget_4/core/heleprs/format_date.dart';

class EndPoint {
  static const String baseUrl = "https://gaztec.org";
  static const String dateConversionEndPoint = "$baseUrl/moon/getdate.php";
  static const String dateConversionLunarEndPoint = "$baseUrl/moon/getdatelunar.php";
  static const String dateInfoYearEndPoint = "$baseUrl/moon/getyear.php";
  static const String dateInfoMonthEndPoint = "$baseUrl/moon/getmonth.php";
  static const String getMoonPhaseEndPoint = "$baseUrl/moon/getphase.php";
  static const String getEclipseEndPoint = "$baseUrl/moon/getecllipse.php";
  static const String wisdomEndPoint = "$baseUrl/moon/wisdoms.php";
  // https://api.aladhan.com/v1/timings/01-01-2025?latitude=51.5194682&longitude=-0.1360365&method=3&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&timezonestring=UTC&calendarMethod=UAQ
  static String prayerTimesEndPoint(DateTime date) =>
      'https://api.aladhan.com/v1/timings/${formatDateForApi(date)}';
  static String moonPhaseEndPoint = "https://api.astronomyapi.com/api/v2/studio/moon-phase";
  static String applicationID = "6199c52b-a212-4f1a-be01-aeee53ebd04a";
  static String applicationSecretKey =
      "e8445168f919dfee14bb201d54bfa77652cdb01f058d427dc369280d4b0bdcff2d251c872b3c491c21f5cee0836d4035cf60103239690803e5dc691ca654322cd98e9813f57c9a5a4e079d9c3f2fe9eb98bdc4b42df33786831f9e21c5a1d66a57e768b256a48d826c74837f3ba2c3c2";
  static Map<String, String> authorizationHeader() => {
    'Authorization': 'Basic ${base64Encode(utf8.encode('$applicationID:$applicationSecretKey'))}',
  };
  // {
  //   'Authorization':
  //       'Basic NjE5OWM1MmItYTIxMi00ZjFhLWJlMDEtYWVlZTUzZWJkMDRhOmU4NDQ1MTY4ZjkxOWRmZWUxNGJiMjAxZDU0YmZhNzc2NTJjZGIwMWYwNThkNDI3ZGMzNjkyODBkNGIwYmRjZmYyZDI1MWM4NzJiM2M0OTFjMjFmNWNlZTA4MzZkNDAzNWNmNjAxMDMyMzk2OTA4MDNlNWRjNjkxY2E2NTQzMjJjZDk4ZTk4MTNmNTdjOWE1YTRlMDc5ZDljM2YyZmU5ZWI5OGJkYzRiNDJkZjMzNzg2ODMxZjllMjFjNWExZDY2YTU3ZTc2OGIyNTZhNDhkODI2Yzc0ODM3ZjNiYTJjM2My'
  // };
}
