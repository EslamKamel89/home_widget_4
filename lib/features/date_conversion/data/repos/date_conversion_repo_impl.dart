import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:home_widget_4/core/Errors/failure.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/features/date_conversion/data/data_source/date_conversion_data_source.dart';
import 'package:home_widget_4/features/date_conversion/data/models/selected_date_conv_localized_model.dart';
import 'package:home_widget_4/features/date_conversion/domain/repo/date_conversion_repo.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';

class DateConversionRepoImpl implements DateConversionRepo {
  final HomeRepoDataSource homeRepoDataSource;

  DateConversionRepoImpl({required this.homeRepoDataSource});
  @override
  Future<Either<Failure, SelectedDateConvLocalizedModel>> getDateConversion(
    DateTime selectedDate,
    DataProcessingOption selectedOption,
  ) async {
    final t = prt('getDateConversion - DateConversionRepoImpl');
    try {
      SelectedDateConvLocalizedModel model = await homeRepoDataSource.getDateConversion(
        selectedDate,
        selectedOption,
      );
      pr(model, t);
      return Right(model);
    } catch (e) {
      if (e is DioException) {
        pr('DioException occured : ${e.response?.data}', t);
        return Left(ServerFailure.formDioError(e));
      }
      pr('Exception occured : $e', t);
      return Left(ServerFailure(e.toString()));
    }
  }
}
