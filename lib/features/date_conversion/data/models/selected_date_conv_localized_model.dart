import 'package:home_widget_4/features/date_conversion/domain/entities/selected_date_conversion_entity.dart';

class SelectedDateConvLocalizedModel extends SelectedDateConversionEntity {
  String? searched;
  String? searchedAr;
  String? searchedGeogorian;
  String? searchedGeogorianAr;
  String? newHijri;
  String? newHijriAr;
  String? newHijriUp;
  String? newHijriUpAr;
  String? oldHijri;
  String? oldHijriGeogorian;
  String? oldHijriAr;
  String? oldHijriGeogorianAr;

  SelectedDateConvLocalizedModel({
    this.searched,
    this.searchedAr,
    this.searchedGeogorian,
    this.searchedGeogorianAr,
    this.newHijri,
    this.newHijriAr,
    this.newHijriUp,
    this.newHijriUpAr,
    this.oldHijri,
    this.oldHijriGeogorian,
    this.oldHijriAr,
    this.oldHijriGeogorianAr,
  }) : super(
         // selectedGeorgianDate: DateTime.now(),
         selectedOldHijriDate: oldHijri,
         selectedOldHijriDateAr: oldHijriAr,
         selectedNewHijriDate: newHijri,
         selectedNewHijriDateAr: newHijriAr,
         newHijriUpdated: newHijriUp,
         newHijriUpdatedAr: newHijriUpAr,
       );

  @override
  String toString() {
    return 'SelectedDateConvLocalizedModel(searched: $searched, searchedAr: $searchedAr, searchedGeogorian: $searchedGeogorian, searchedGeogorianAr: $searchedGeogorianAr, newHijri: $newHijri, newHijriAr: $newHijriAr, newHijriUp: $newHijriUp, oldHijri: $oldHijri, oldHijriGeogorian: $oldHijriGeogorian, oldHijriAr: $oldHijriAr, oldHijriGeogorianAr: $oldHijriGeogorianAr)';
  }

  factory SelectedDateConvLocalizedModel.fromJson(Map<String, dynamic> json) {
    return SelectedDateConvLocalizedModel(
      searched: json['searched'] as String?,
      searchedAr: json['searched_ar'] as String?,
      searchedGeogorian: json['searched_geogorian'] as String?,
      searchedGeogorianAr: json['searched_geogorian_ar'] as String?,
      newHijri: json['new_hijri'] as String?,
      newHijriAr: json['new_hijri_ar'] as String?,
      newHijriUp: json['new_hijri_up'] as String?, //! real hijri
      newHijriUpAr: json['new_hijri_up_ar'] as String?, //! real hijri arabic
      oldHijri: json['old_hijri'] as String?,
      oldHijriGeogorian: json['old_hijri_geogorian'] as String?,
      oldHijriAr: json['old_hijri_ar'] as String?,
      oldHijriGeogorianAr: json['old_hijri_geogorian_ar'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'searched': searched,
    'searched_ar': searchedAr,
    'searched_geogorian': searchedGeogorian,
    'searched_geogorian_ar': searchedGeogorianAr,
    'new_hijri': newHijri,
    'new_hijri_ar': newHijriAr,
    'new_hijri_up': newHijriUp,
    'new_hijri_up_ar': newHijriUpAr,
    'old_hijri': oldHijri,
    'old_hijri_geogorian': oldHijriGeogorian,
    'old_hijri_ar': oldHijriAr,
    'old_hijri_geogorian_ar': oldHijriGeogorianAr,
  };
}
