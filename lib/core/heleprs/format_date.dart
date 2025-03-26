import 'package:home_widget_4/core/heleprs/convert_numbers_to_arabic.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formateDateToArabic(DateTime dateTime) {
  initializeDateFormatting();
  Intl.defaultLocale = 'en';
  // Intl.initializeDateFormatting

  String formattedDate = DateFormat('EEEE d MMMM y', 'ar_SA').format(dateTime);
  return formattedDate;
}

String formateDateDetailed(DateTime dateTime) {
  initializeDateFormatting();
  Intl.defaultLocale = isEnglish() ? 'en' : 'ar';
  // Intl.initializeDateFormatting

  String formattedDate = DateFormat("EEEE d MMM yyyy").format(dateTime);
  Intl.defaultLocale = 'en';
  return formattedDate;
}

String formateDateEgnlish(DateTime dateTime) {
  initializeDateFormatting();
  Intl.defaultLocale = 'en';
  // Intl.initializeDateFormatting

  String formattedDate = DateFormat('d MMMM y').format(dateTime);
  return formattedDate;
}

String formatDateForApi(DateTime dateTime) {
  String formattedDate = DateFormat('dd-MM-yyyy', 'en').format(dateTime);
  pr(formattedDate);
  return formattedDate;
}

String formatGregorianDateToArabic(String gergorianDate) {
  Map<String, String> monthMapping = {
    "jan": "يناير",
    "feb": "فبراير",
    "mar": "مارس",
    "apr": "أبريل",
    "may": "مايو",
    "jun": "يونيو",
    "jul": "يوليو",
    "aug": "أغسطس",
    "sep": "سبتمبر",
    "oct": "أكتوبر",
    "nov": "نوفمبر",
    "dec": "ديسمبر",
  };

  try {
    if (gergorianDate.contains('-')) {
      List<String> date = gergorianDate.split('-');
      if (date.length != 3) return gergorianDate;
      // date = date.reversed.toList();
      date[1] = monthMapping[date[1].toLowerCase()] ?? date[1];
      return convertNumberToArabic(date.join(' - '));
    } else {
      DateTime parsedDate = DateFormat("MMMM d, yyyy", "en_US").parse(gergorianDate);
      return convertNumberToArabic(DateFormat.yMMMMd('ar').format(parsedDate));
    }
  } on Exception catch (_) {
    return gergorianDate;
  }
}

String localizeHijriDate(String? inputDate) {
  if (inputDate == null) return '';
  Map<String, String> dayMapping = {
    "sun": "الأحد",
    "mon": "الاثنين",
    "tue": "الثلاثاء",
    "wed": "الأربعاء",
    "thu": "الخميس",
    "fri": "الجمعة",
    "sat": "السبت",
  };

  Map<String, String> monthMapping = {
    "qid": "ذو القعدة",
    "rb1": "ربيع أول",
    "rbi": "ربيع أول",
    "raj": "رجب",
    "jm1": "جمادى أول",
    "hij": "ذو الحجة",
    "jm2": "جمادى الثاني",
    "muh": "محرم",
    "ram": "رمضان",
    "rb2": "ربيع ثاني",
    "saf": "صفر",
    "sha": "شعبان",
    "shw": "شوال",
  };

  List<String> parts = inputDate.split(' ');
  if (parts.length != 4) {
    return inputDate;
  }

  String englishDay = parts[0];
  String dayNumber = parts[1];
  String englishMonth = parts[2];

  String year = parts[3];

  String arabicDay = dayMapping[englishDay.toLowerCase()] ?? englishDay;
  if (dayMapping[englishDay.toLowerCase()] == null) {
    pr(englishDay, 'English day not found');
  }
  String arabicMonth = monthMapping[englishMonth.toLowerCase()] ?? englishMonth;
  if (monthMapping[englishMonth.toLowerCase()] == null) {
    pr(englishMonth, 'English month not found');
  }
  String localizedDate = "$arabicDay $dayNumber $arabicMonth $year";

  return convertNumberToArabic(localizedDate);
}
