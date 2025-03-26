import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_widget_4/core/api_service/api_consumer.dart';
import 'package:home_widget_4/core/api_service/end_points.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/format_date.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/heleprs/snackbar.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/core/widgets/loading_widget.dart';
import 'package:home_widget_4/features/main_homepage/models/wisdom_model.dart';
import 'package:home_widget_4/features/main_homepage/presentation/widgets/all_prays_time_widget.dart';
import 'package:home_widget_4/utils/assets/assets.dart';

class IslamicWisdomCard extends StatefulWidget {
  // final String wisdom;
  // final String author;

  const IslamicWisdomCard({
    super.key,
    // required this.wisdom,
    // required this.author,
  });
  @override
  State<IslamicWisdomCard> createState() => _IslamicWisdomCardState();
}

class _IslamicWisdomCardState extends State<IslamicWisdomCard> {
  ApiResponseModel<WisdomModel> wisdomApi = ApiResponseModel<WisdomModel>(
    response: ResponseEnum.initial,
  );
  @override
  void initState() {
    request();
    selectedDateNotifier.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    selectedDateNotifier.removeListener(_listener);

    super.dispose();
  }

  _listener() {
    request(date: selectedDateNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onHorizontalDragStart: (_) {
      //   _request();
      // },
      // onHorizontalDragEnd: (_) {
      //   _request();
      // },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.2),
              context.primaryColor.withOpacity(0.2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: const DecorationImage(
            image: AssetImage(AssetsData.islamicPattern2),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color(0xffFFB800).withOpacity(0.5), width: 1),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            // borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                child:
                    wisdomApi.response == ResponseEnum.success
                        ? Text(
                          isEnglish()
                              ? (wisdomApi.data?.wisdomEn ?? '')
                              : (wisdomApi.data?.wisdomAr ?? ''),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : const LoadingWidget(
                          rowCount: 4,
                          height: 20,
                          space: 10,
                          width: double.infinity,
                        ),
              ),
              const SizedBox(height: 16),
              // The author of the wisdom.
              // Container(
              //   padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
              //   child: Text(
              //     '- $author',
              //     textAlign: TextAlign.right,
              //     style: const TextStyle(
              //       fontFamily: 'Scheherazade',
              //       fontSize: 16,
              //       color: Colors.black,
              //       fontStyle: FontStyle.italic,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future request({DateTime? date}) async {
    final t = prt('wisdom - Islamic Wisdom Card');
    final ApiConsumer api = serviceLocator<ApiConsumer>();
    date = date ?? DateTime.now();
    try {
      setState(() {
        wisdomApi = ApiResponseModel(response: ResponseEnum.loading);
      });
      final response = await api.get(
        EndPoint.wisdomEndPoint,
        queryParameter: {'date': formatDateForApi(date)},
      );
      if (mounted) {
        setState(() {
          wisdomApi = pr(
            ApiResponseModel(
              response: ResponseEnum.success,
              data: WisdomModel.fromJson((jsonDecode(response) as List)[0]),
            ),
            t,
          );
        });
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      showSnackbar('Error', errorMessage, true);
      if (mounted) {
        setState(() {
          wisdomApi = pr(
            ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failure),
            t,
          );
        });
      }
    }
  }
}
