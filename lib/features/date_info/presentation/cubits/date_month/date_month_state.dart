part of 'date_month_cubit.dart';

class DateMonthState {
  List<DateInfoEntity> datesInfo = [];
  MonthEnum selectedMonth;
  int selectedYear;
  ResponseEnum getDateYearState = ResponseEnum.initial;
  String validationMessage = '';
  DateMonthState({
    this.datesInfo = const [],
    this.selectedYear = 2024,
    this.getDateYearState = ResponseEnum.initial,
    this.validationMessage = '',
    this.selectedMonth = MonthEnum.january,
  });

  DateMonthState copyWith({
    List<DateInfoEntity>? datesInfo,
    int? selectedYear,
    ResponseEnum? getDateYearState,
    String? validationMessage,
    MonthEnum? selectedMonth,
  }) {
    return DateMonthState(
      datesInfo: datesInfo ?? this.datesInfo,
      selectedYear: selectedYear ?? this.selectedYear,
      getDateYearState: getDateYearState ?? this.getDateYearState,
      validationMessage: validationMessage ?? this.validationMessage,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }

  @override
  String toString() {
    return 'DateMonthState(datesInfo.length: ${datesInfo.length}, selectedYear: $selectedYear, getDateYearState: $getDateYearState, validationMessage: $validationMessage , selectedMonth: $selectedMonth)';
  }
}
