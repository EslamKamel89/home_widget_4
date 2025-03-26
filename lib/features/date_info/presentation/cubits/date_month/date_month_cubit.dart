import 'package:bloc/bloc.dart';
import 'package:home_widget_4/core/Errors/failure.dart';
import 'package:home_widget_4/core/enums/month_enums.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/features/date_info/data/models/date_info_model.dart';
import 'package:home_widget_4/features/date_info/domain/entities/date_info_entity.dart';
import 'package:home_widget_4/features/date_info/domain/repo/date_year_repo.dart';

part 'date_month_state.dart';

class DateMonthCubit extends Cubit<DateMonthState> {
  final DateInfoRepo dateInfoRepo;
  DateMonthCubit({required this.dateInfoRepo}) : super(DateMonthState());

  Future getDateMonth(int year, MonthEnum month) async {
    final t = prt('getDateMonth - DateMonthCubit');
    emit(state.copyWith(getDateYearState: ResponseEnum.loading, selectedYear: year));
    final result = await dateInfoRepo.getDateInfoMonth(year, month);
    return result.fold(
      (Failure failure) {
        pr(failure, t);
        emit(state.copyWith(getDateYearState: ResponseEnum.failure, datesInfo: []));
      },
      (List<DateInfoModel> models) {
        pr(models, t);
        emit(state.copyWith(datesInfo: models, getDateYearState: ResponseEnum.success));
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
