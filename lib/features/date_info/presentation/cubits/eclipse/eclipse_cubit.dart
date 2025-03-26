import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget_4/core/Errors/failure.dart';
import 'package:home_widget_4/core/enums/eclipse_enum.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/features/date_info/domain/entities/moon_info_model.dart';
import 'package:home_widget_4/features/date_info/domain/repo/date_year_repo.dart';

part 'eclipse_state.dart';

class EclipseCubit extends Cubit<EclipseState> {
  final DateInfoRepo dateInfoRepo;

  EclipseCubit({required this.dateInfoRepo}) : super(EclipseState());

  Future getEclipseInfoMonth(int year, EclipseEnum eclipse) async {
    final t = prt('getEclipseInfoMonth - EclipseCubit');
    emit(state.copyWith(getEclipseState: ResponseEnum.loading, selectedYear: year));
    final result = await dateInfoRepo.getEclipseInfoMonth(year, eclipse);
    return result.fold(
      (Failure failure) {
        pr(failure, t);
        emit(state.copyWith(getEclipseState: ResponseEnum.failure, moonPhasesInfo: []));
      },
      (List<MoonInfoModel> models) {
        pr(models, t);
        emit(state.copyWith(moonPhasesInfo: models, getEclipseState: ResponseEnum.success));
      },
    );
    // emit(state.copyWith(getDateYearState: ResponseState.loading, selectedYear: year));
    // final data = List.generate(10, (index) {
    //   return DateInfoEntity(
    //     id: 'id',
    //     fmStart: 'fmStart',
    //     fmEnd: 'fmEnd',
    //     hgStart: 'hgStart',
    //     hgEnd: 'hgEnd',
    //     hnStart: 'hnStart',
    //     hnEnd: 'hnEnd',
    //     oldHgHijriStart: 'oldHgHijriStart',
    //     oldHgHijriEnd: 'oldHgHijriEnd',
    //     oldFmHijriStart: 'oldFmHijriStart',
    //     oldFmHijriEnd: 'oldFmHijriEnd',
    //   );
    // });
    // pr(data, t);
    // await Future.delayed(const Duration(seconds: 2));
    // emit(state.copyWith(getDateYearState: ResponseState.failure));
    // await Future.delayed(const Duration(seconds: 2));
    // emit(
    //   state.copyWith(
    //     datesInfo: data,
    //     getDateYearState: ResponseState.success,
    //   ),
    // );
  }

  void validate(String validationMsg) {
    emit(state.copyWith(validationMessage: validationMsg));
  }
}
