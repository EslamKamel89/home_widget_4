import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/core/widgets/sizer.dart';
import 'package:home_widget_4/features/date_conversion/domain/repo/date_conversion_repo.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/data_selector.dart';

class NewHijrWidget extends StatefulWidget {
  const NewHijrWidget({super.key});

  @override
  State<NewHijrWidget> createState() => _NewHijrWidgetState();
}

class _NewHijrWidgetState extends State<NewHijrWidget> {
  String? newHijriDate;
  @override
  void initState() {
    getNewHijri();
    super.initState();
  }

  Future getNewHijri() async {
    DateConversionRepo repo = serviceLocator();
    final response = await repo.getDateConversion(DateTime.now(), DataProcessingOption.regular);
    response.fold((_) {}, (model) {
      if (mounted) {
        setState(() {
          newHijriDate = model.newHijriUpdated;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (newHijriDate == null) return const SizedBox();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset('assets/images/calendar_7.png', width: 20.w, height: 20.w),
        const Sizer(),
        Text(
          newHijriDate ?? '',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
