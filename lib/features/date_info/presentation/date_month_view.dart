import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/enums/month_enums.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/widgets/default_drawer.dart';
import 'package:home_widget_4/core/widgets/default_screen_padding.dart';
import 'package:home_widget_4/core/widgets/sizer.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/year_search_widget.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/date_month/date_month_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/widgets/date_info_item_card.dart';
import 'package:home_widget_4/features/date_info/presentation/widgets/month_dropdown.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class DateMonthView extends StatefulWidget {
  const DateMonthView({super.key});

  @override
  State<DateMonthView> createState() => _DateMonthViewState();
}

class _DateMonthViewState extends State<DateMonthView> {
  late DateMonthCubit controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<DateMonthCubit>();
  }

  @override
  void dispose() {
    controller.state.datesInfo = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: txt('Month Calander', e: St.bold20)),
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
                    controller.getDateMonth(yearInt, controller.state.selectedMonth);
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
            BlocBuilder<DateMonthCubit, DateMonthState>(
              builder: (context, state) {
                return state.validationMessage.isEmpty
                    ? const SizedBox()
                    : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: txt(state.validationMessage, c: Colors.red, e: St.reg16),
                    );
              },
            ),
            MonthDropdownWidget(
              handleMonthSelected: (MonthEnum month) {
                int maxYear = context.read<DateConversionCubit>().state.lastDay.year;
                int minYear = context.read<DateConversionCubit>().state.firstDay.year;
                pr(minYear, 'minYear');
                pr(maxYear, 'maxYear');
                controller.state.selectedMonth = month;
                if (controller.state.selectedYear <= maxYear &&
                    controller.state.selectedYear >= minYear) {
                  controller.getDateMonth(
                    controller.state.selectedYear,
                    controller.state.selectedMonth,
                  );
                  controller.validate('');
                } else {
                  pr('condition not met');
                }
              },
            ),
            BlocBuilder<DateMonthCubit, DateMonthState>(
              builder: (context, state) {
                if (state.getDateYearState == ResponseEnum.failure) {
                  return Expanded(
                    child: Center(
                      child: txt(
                        'An unexpected error has occurred.\nPlease try again.',
                        c: Colors.red,
                        e: St.reg14,
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
