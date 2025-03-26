// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:home_widget_4/features/date_conversion/domain/entities/selected_date_conversion_entity.dart';

class SelectedDateConversionModel extends SelectedDateConversionEntity {
  SelectedDateConversionModel({
    super.selectedGeorgianDate,
    super.selectedOldHijriDate,
    super.selectedNewHijriDate,
    super.newHijriUpdated,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'selectedGeorgianDate': selectedGeorgianDate?.millisecondsSinceEpoch,
      'old_hijri': selectedOldHijriDate,
      'new_hijri': selectedNewHijriDate,
      'new_hijri_up': newHijriUpdated,
    };
  }

  factory SelectedDateConversionModel.fromJson(Map<String, dynamic> json) {
    return SelectedDateConversionModel(
      // selectedGeorgianDate: json['selectedGeorgianDate'] != null
      //     ? DateTime.fromMillisecondsSinceEpoch(json['selectedGeorgianDate'] as int)
      //     : null,
      selectedOldHijriDate:
          json['old_hijri'] != null ? json['old_hijri'] as String : null, // current hijri
      selectedNewHijriDate: json['new_hijri'] != null ? json['new_hijri'] as String : null,
      newHijriUpdated:
          json['new_hijri_up'] != null ? json['new_hijri_up'] as String : null, // real hijri
    );
  }
}
