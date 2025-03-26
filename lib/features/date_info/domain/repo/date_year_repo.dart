import 'package:dartz/dartz.dart';
import 'package:home_widget_4/core/Errors/failure.dart';
import 'package:home_widget_4/core/enums/eclipse_enum.dart';
import 'package:home_widget_4/core/enums/month_enums.dart';
import 'package:home_widget_4/core/enums/moon_phase_enums.dart';
import 'package:home_widget_4/features/date_info/data/models/date_info_model.dart';
import 'package:home_widget_4/features/date_info/domain/entities/moon_info_model.dart';

abstract class DateInfoRepo {
  Future<Either<Failure, List<DateInfoModel>>> getDateInfoYear(int year);
  Future<Either<Failure, List<DateInfoModel>>> getDateInfoMonth(int year, MonthEnum month);
  Future<Either<Failure, List<MoonInfoModel>>> getMoonInfoMonth(int year, MoonPhaseEnum moonPhase);
  Future<Either<Failure, List<MoonInfoModel>>> getEclipseInfoMonth(int year, EclipseEnum eclipse);
}
