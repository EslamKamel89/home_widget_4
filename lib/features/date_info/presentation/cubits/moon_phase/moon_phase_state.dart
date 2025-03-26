part of 'moon_phase_cubit.dart';

class MoonPhaseState {
  List<MoonInfoModel> moonPhasesInfo = [];
  MoonPhaseEnum selectedMoonPhase;
  int selectedYear;
  ResponseEnum getMoonPhaseState = ResponseEnum.initial;
  String validationMessage = '';
  MoonPhaseState({
    this.moonPhasesInfo = const [],
    this.selectedYear = 2024,
    this.getMoonPhaseState = ResponseEnum.initial,
    this.validationMessage = '',
    this.selectedMoonPhase = MoonPhaseEnum.fullMoon,
  });

  MoonPhaseState copyWith({
    List<MoonInfoModel>? moonPhasesInfo,
    int? selectedYear,
    ResponseEnum? getMoonPhaseState,
    String? validationMessage,
    MoonPhaseEnum? selectedMoonPhase,
  }) {
    return MoonPhaseState(
      moonPhasesInfo: moonPhasesInfo ?? this.moonPhasesInfo,
      selectedYear: selectedYear ?? this.selectedYear,
      getMoonPhaseState: getMoonPhaseState ?? this.getMoonPhaseState,
      validationMessage: validationMessage ?? this.validationMessage,
      selectedMoonPhase: selectedMoonPhase ?? this.selectedMoonPhase,
    );
  }

  @override
  String toString() {
    return 'MoonPhaseState(moonPhasesInfo.length: ${moonPhasesInfo.length}, selectedYear: $selectedYear, getMoonPhaseState: $getMoonPhaseState, validationMessage: $validationMessage , selectedMoonPhase: $selectedMoonPhase)';
  }
}
