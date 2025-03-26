// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:home_widget_4/core/api_service/api_consumer.dart';
import 'package:home_widget_4/core/api_service/end_points.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/features/date_conversion/data/models/selected_date_conv_localized_model.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';

class HomeRepoDataSource {
  final ApiConsumer api;
  HomeRepoDataSource({required this.api});
  Future<SelectedDateConvLocalizedModel> getDateConversion(
    DateTime selectedDate,
    DataProcessingOption selectedOption,
  ) async {
    String year = DateFormat('yyyy').format(selectedDate);
    String month = DateFormat('MMM').format(selectedDate).toLowerCase();
    String day = DateFormat('d').format(selectedDate);
    final t = prt('getDateConversion - HomeRepoDataSource');
    String endPoint =
        selectedOption == DataProcessingOption.lunar
            ? EndPoint.dateConversionLunarEndPoint
            : EndPoint.dateConversionEndPoint;
    final data = await api.get(
      endPoint,
      queryParameter: {'year': year, 'month': month, 'day': day, 'lang': isEnglish() ? 'en' : 'ar'},
    );
    SelectedDateConvLocalizedModel model = pr(
      SelectedDateConvLocalizedModel.fromJson(jsonDecode(data)),
      t,
    );
    return model;
  }
}
