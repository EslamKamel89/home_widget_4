import 'package:home_widget_4/core/heleprs/is_ltr.dart';

String prayerNameTr(String prayer) {
  prayer = prayer.toLowerCase().trim();
  final translations = {
    'fajr': ['Fajr', 'الفجر'],
    'sunrise': ['Sunrise', 'الشروق'],
    'dhuhr': ['Dhuhr', 'الظهر'],
    'asr': ['Asr', 'العصر'],
    'sunset': ['Sunset', 'الغروب'],
    'maghrib': ['Maghrib', 'المغرب'],
    'isha': ['Isha', 'العشاء'],
    'imsak': ['Imsak', 'الإمساك'],
    'midnight': ['Midnight', 'منتصف الليل'],
    'firstthird': ['Firstthird', 'الثلث الأول'],
    'lastthird': ['Lastthird', 'الثلث الأخير'],
  };
  return isEnglish() ? (translations[prayer]?[0] ?? '') : (translations[prayer]?[1] ?? '');
}
