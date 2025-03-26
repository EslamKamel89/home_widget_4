// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'date_year_cubit.dart';

class DateYearState {
  List<DateInfoEntity> datesInfo = [];
  int selectedYear;
  ResponseEnum getDateYearState = ResponseEnum.initial;
  String validationMessage = '';
  DateYearState({
    this.datesInfo = const [],
    this.selectedYear = 2024,
    this.getDateYearState = ResponseEnum.initial,
    this.validationMessage = '',
  });

  DateYearState copyWith({
    List<DateInfoEntity>? datesInfo,
    int? selectedYear,
    ResponseEnum? getDateYearState,
    String? validationMessage,
  }) {
    return DateYearState(
      datesInfo: datesInfo ?? this.datesInfo,
      selectedYear: selectedYear ?? this.selectedYear,
      getDateYearState: getDateYearState ?? this.getDateYearState,
      validationMessage: validationMessage ?? this.validationMessage,
    );
  }

  @override
  String toString() {
    return 'DateYearState(datesInfo.length: ${datesInfo.length}, selectedYear: $selectedYear, getDateYearState: $getDateYearState, validationMessage: $validationMessage)';
  }
}
