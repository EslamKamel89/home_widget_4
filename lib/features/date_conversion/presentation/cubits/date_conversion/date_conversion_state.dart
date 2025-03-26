// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'date_conversion_cubit.dart';

class DateConversionState {
  int? selectedYear;
  DateTime firstDay = DateTime.utc(1, 1, 1);
  DateTime lastDay = DateTime.utc(4000, 12, 31);
  DateTime? selectedGeorgianDate = DateTime.now();
  // String? selectedOldHijriDate;
  // String? selectedNewHijriDate;
  ResponseEnum? getSelectedDateInfoState = ResponseEnum.initial;
  SelectedDateConversionEntity? selectedDateConversionEntity;
  DataProcessingOption? selectedOption = DataProcessingOption.regular;
  String? buildWhen = '';
  DateConversionState({
    this.selectedYear,
    this.selectedGeorgianDate,
    // this.selectedOldHijriDate,
    // this.selectedNewHijriDate,
    this.selectedDateConversionEntity,
    this.getSelectedDateInfoState,
    this.buildWhen,
    this.selectedOption,
  });

  DateConversionState copyWith({
    int? selectedYear,
    DateTime? selectedGeorgianDate,
    String? selectedOldHijriDate,
    String? selectedNewHijriDate,
    SelectedDateConversionEntity? selectedDateConversionEntity,
    ResponseEnum? getSelectedDateInfoState,
    String? buildWhen,
    DataProcessingOption? selectedOption,
  }) {
    return DateConversionState(
      selectedYear: selectedYear ?? this.selectedYear,
      selectedGeorgianDate: selectedGeorgianDate ?? this.selectedGeorgianDate,
      // selectedOldHijriDate: selectedOldHijriDate ?? this.selectedOldHijriDate,
      // selectedNewHijriDate: selectedNewHijriDate ?? this.selectedNewHijriDate,
      selectedDateConversionEntity:
          selectedDateConversionEntity ?? this.selectedDateConversionEntity,
      getSelectedDateInfoState:
          getSelectedDateInfoState ?? this.getSelectedDateInfoState,
      buildWhen: buildWhen ?? this.buildWhen,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  @override
  String toString() {
    // return 'DateConversionState(selectedYear: $selectedYear, selectedGeorgianDate: $selectedGeorgianDate, selectedOldHijriDate: $selectedOldHijriDate, selectedNewHijriDate: $selectedNewHijriDate, getSelectedDateInfoState: $getSelectedDateInfoState, selectedDateConversionEntity: $selectedDateConversionEntity, selectedOption: $selectedOption)';
    return 'DateConversionState(selectedYear: $selectedYear, selectedGeorgianDate: $selectedGeorgianDate, getSelectedDateInfoState: $getSelectedDateInfoState, selectedDateConversionEntity: $selectedDateConversionEntity, selectedOption: $selectedOption, buildWhen: $buildWhen)';
  }
}
