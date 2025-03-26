// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:home_widget_4/core/heleprs/print_helper.dart';

class SelectedDateConversionEntity {
  DateTime? selectedGeorgianDate;
  // DateTime? selectedGeorgianDateAr;
  String? selectedOldHijriDate;
  String? selectedOldHijriDateAr;
  String? selectedNewHijriDate;
  String? selectedNewHijriDateAr;
  String? newHijriUpdated;
  String? newHijriUpdatedAr;
  SelectedDateConversionEntity({
    this.selectedGeorgianDate,
    this.selectedOldHijriDate,
    this.selectedOldHijriDateAr,
    this.selectedNewHijriDate,
    this.selectedNewHijriDateAr,
    this.newHijriUpdated,
    this.newHijriUpdatedAr,
  });

  String? newHijriDateProccessed() {
    final t = prt('newHijriDateProccessed  - SelectedDateConversionEntity');
    try {
      if (selectedOldHijriDate == null || selectedNewHijriDate == null) {
        return selectedNewHijriDate;
      }
      String oldDay = selectedOldHijriDate!.split(' ')[1].trim();
      String newDay = selectedNewHijriDate!.split(',')[1].trim();
      String resultNewHijri = selectedNewHijriDate!.replaceFirst(',$newDay,', ',$oldDay,');
      // pr(oldDay, '$t - oldDay');
      // pr(newDay, '$t - newDay');
      pr(resultNewHijri, '$t - resultNewHijri');
      return resultNewHijri;
    } catch (e) {
      pr('Exeption in parsing: $e', t);
      return selectedNewHijriDate;
    }
  }

  String? newHijriUpdatedDateProccessed() {
    final t = prt('newHijriUpdatedDateProccessed  - SelectedDateConversionEntity');
    try {
      if (selectedOldHijriDate == null || selectedNewHijriDate == null) {
        return selectedNewHijriDate;
      }
      String oldDay = selectedOldHijriDate!.split(' ')[1].trim();
      String newDay = newHijriUpdated!.split(',')[1].trim();
      int oldDayMinusOne = int.parse(oldDay);
      oldDayMinusOne = oldDayMinusOne == 1 ? 1 : oldDayMinusOne - 1;
      String resultNewHijriUpdated = newHijriUpdated!.replaceFirst(
        ',$newDay,',
        ',$oldDayMinusOne,',
      );
      pr(resultNewHijriUpdated, '$t - resultNewHijriUpdated');
      return resultNewHijriUpdated;
    } catch (e) {
      pr('Exeption in parsing: $e', t);
      return selectedNewHijriDate;
    }
  }

  @override
  String toString() {
    return 'SelectedDateConversionEntity(selectedGeorgianDate: $selectedGeorgianDate, selectedOldHijriDate: $selectedOldHijriDate, selectedOldHijriDateAr: $selectedOldHijriDateAr, selectedNewHijriDate: $selectedNewHijriDate, selectedNewHijriDateAr: $selectedNewHijriDateAr, newHijriUpdated: $newHijriUpdated, newHijriUpdatedAr: $newHijriUpdatedAr)';
  }

  SelectedDateConversionEntity copyWith({
    DateTime? selectedGeorgianDate,
    String? selectedOldHijriDate,
    String? selectedOldHijriDateAr,
    String? selectedNewHijriDate,
    String? selectedNewHijriDateAr,
    String? newHijriUpdated,
    String? newHijriUpdatedAr,
  }) {
    return SelectedDateConversionEntity(
      selectedGeorgianDate: selectedGeorgianDate ?? this.selectedGeorgianDate,
      selectedOldHijriDate: selectedOldHijriDate ?? this.selectedOldHijriDate,
      selectedOldHijriDateAr: selectedOldHijriDateAr ?? this.selectedOldHijriDateAr,
      selectedNewHijriDate: selectedNewHijriDate ?? this.selectedNewHijriDate,
      selectedNewHijriDateAr: selectedNewHijriDateAr ?? this.selectedNewHijriDateAr,
      newHijriUpdated: newHijriUpdated ?? this.newHijriUpdated,
      newHijriUpdatedAr: newHijriUpdatedAr ?? this.newHijriUpdatedAr,
    );
  }
}
