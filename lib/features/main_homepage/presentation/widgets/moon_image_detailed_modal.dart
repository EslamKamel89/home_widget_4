import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/models/api_response_model.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/features/main_homepage/controllers/moon_image_controller.dart';

class MoonImageDetailedModal extends StatefulWidget {
  const MoonImageDetailedModal({super.key, required this.position, required this.date});
  final Position position;
  final DateTime date;
  @override
  State<MoonImageDetailedModal> createState() => _MoonImageDetailedModalState();
}

class _MoonImageDetailedModalState extends State<MoonImageDetailedModal> {
  ApiResponseModel<String?> moonImage = ApiResponseModel(response: ResponseEnum.initial);
  @override
  void initState() {
    _request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.primaryColor.withOpacity(0.8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        // padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.h),
        width: 500,
        height: 230,
        child:
            moonImage.response == ResponseEnum.success && moonImage.data != null
                ? Image.network(moonImage.data ?? '', fit: BoxFit.fill)
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future _request() async {
    final t = prt('_request - MoonImageDetailedModal');
    final MoonImageController controller = serviceLocator<MoonImageController>();
    if (mounted) {
      setState(() {
        moonImage = pr(moonImage.copyWith(errorMessage: null, response: ResponseEnum.loading), t);
      });
    }
    moonImage = pr(
      await controller.moonImage(position: widget.position, dateTime: widget.date, showInfo: true),
      t,
    );
    if (mounted) {
      setState(() {});
    }
  }
}
