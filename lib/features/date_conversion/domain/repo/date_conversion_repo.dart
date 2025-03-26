import 'package:dartz/dartz.dart';
import 'package:home_widget_4/core/Errors/failure.dart';
import 'package:home_widget_4/features/date_conversion/data/models/selected_date_conv_localized_model.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';

abstract class DateConversionRepo {
  Future<Either<Failure, SelectedDateConvLocalizedModel>> getDateConversion(
    DateTime selectedDate,
    DataProcessingOption selectedOption,
  );
}
