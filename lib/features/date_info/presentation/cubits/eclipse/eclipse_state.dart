// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'eclipse_cubit.dart';

class EclipseState {
  List<MoonInfoModel> moonPhasesInfo = [];
  EclipseEnum selectedEclipse;
  int selectedYear;
  ResponseEnum getEclipseState = ResponseEnum.initial;
  String validationMessage = '';
  EclipseState({
    this.moonPhasesInfo = const [],
    this.selectedYear = 2024,
    this.getEclipseState = ResponseEnum.initial,
    this.validationMessage = '',
    this.selectedEclipse = EclipseEnum.totalSolar,
  });

  EclipseState copyWith({
    List<MoonInfoModel>? moonPhasesInfo,
    EclipseEnum? selectedEclipse,
    int? selectedYear,
    ResponseEnum? getEclipseState,
    String? validationMessage,
  }) {
    return EclipseState(
      moonPhasesInfo: moonPhasesInfo ?? this.moonPhasesInfo,
      selectedEclipse: selectedEclipse ?? this.selectedEclipse,
      selectedYear: selectedYear ?? this.selectedYear,
      getEclipseState: getEclipseState ?? this.getEclipseState,
      validationMessage: validationMessage ?? this.validationMessage,
    );
  }

  @override
  String toString() {
    return 'EclipseState(moonPhasesInfo: $moonPhasesInfo, selectedEclipse: $selectedEclipse, selectedYear: $selectedYear, getEclipseState: $getEclipseState, validationMessage: $validationMessage)';
  }
}
