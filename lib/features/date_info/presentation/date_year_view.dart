import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/widgets/default_drawer.dart';
import 'package:home_widget_4/core/widgets/default_screen_padding.dart';
import 'package:home_widget_4/core/widgets/sizer.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/year_search_widget.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/date_year/date_year_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/widgets/date_info_item_card.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class DateYearView extends StatefulWidget {
  const DateYearView({super.key});

  @override
  State<DateYearView> createState() => _DateYearViewState();
}

class _DateYearViewState extends State<DateYearView> {
  late DateYearCubit controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<DateYearCubit>();
  }

  @override
  void dispose() {
    controller.state.datesInfo = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: txt('Year Calander', e: St.bold20)),
      resizeToAvoidBottomInset: false,
      drawer: const DefaultDrawer(),
      body: DefaultScreenPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Sizer(),
            YearSearchWidget(
              handleInputChange: (String year) {
                try {
                  int yearInt = int.parse(year);
                  int maxYear = context.read<DateConversionCubit>().state.lastDay.year;
                  int minYear = context.read<DateConversionCubit>().state.firstDay.year;
                  pr(minYear, 'minYear');
                  pr(maxYear, 'maxYear');
                  pr(yearInt, 'enteredYear');
                  if (yearInt <= maxYear && yearInt >= minYear) {
                    controller.getDateYear(yearInt);
                    controller.validate('');
                  } else {
                    pr('condition not met');
                    controller.validate('Year range between $minYear and $maxYear');
                  }
                } catch (e) {
                  controller.validate('You have to enter numeric values');
                  // showSnackbar('Error', 'You have to enter numeric values', true);
                }
              },
            ),
            BlocBuilder<DateYearCubit, DateYearState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: txt(state.validationMessage, c: Colors.red, e: St.reg16),
                );
              },
            ),
            BlocBuilder<DateYearCubit, DateYearState>(
              builder: (context, state) {
                if (state.getDateYearState == ResponseEnum.failure) {
                  return Expanded(
                    child: Center(
                      child: txt(
                        'An unexpected error has occurred.\nPlease try again.',
                        c: Colors.red,
                        e: St.reg16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                if (state.getDateYearState == ResponseEnum.loading) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return DateInfoItemCard(model: state.datesInfo[index]);
                    },
                    itemCount: state.datesInfo.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
