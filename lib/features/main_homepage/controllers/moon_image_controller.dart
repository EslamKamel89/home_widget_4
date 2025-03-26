import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/api_service/api_consumer.dart';
import 'package:home_widget_4/core/api_service/end_points.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/globals/globals_var.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/heleprs/snackbar.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';

class MoonImageController {
  ApiConsumer api = serviceLocator();

  Future<ApiResponseModel<String?>> moonImage({
    required Position position,
    required DateTime dateTime,
    bool showInfo = false,
  }) async {
    final t = prt('moonImage - MoonImageController');
    try {
      final temp = api.dio.options.headers;
      api.dio.options.headers = EndPoint.authorizationHeader();
      final response = await api.post(
        EndPoint.moonPhaseEndPoint,
        data: _requestData(position, dateTime, showInfo),
      );
      api.dio.options.headers = temp;
      return pr(
        ApiResponseModel(response: ResponseEnum.success, data: response['data']['imageUrl']),
        t,
      );
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      BuildContext? context = navigatorKey.currentContext;
      if (context != null) {
        showSnackbar('Error', errorMessage, true);
      }
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failure), t);
    }
  }

  Map<String, dynamic> _requestData(Position position, DateTime dateTime, bool showInfo) {
    return {
      "format": "png",
      "style": {
        "moonStyle": "default",
        "backgroundStyle": showInfo ? "stars" : "solid",
        "backgroundColor": "transparent",
        "headingColor": showInfo ? "white" : "transparent",
        "textColor": showInfo ? "white" : "transparent",
      },
      "observer": {
        "latitude": position.latitude,
        "longitude": position.longitude,
        "date": DateFormat('yyyy-MM-dd', 'en').format(dateTime),
      },
      "view": {"type": "landscape-simple", "orientation": "south-up"},
    };
  }
}
