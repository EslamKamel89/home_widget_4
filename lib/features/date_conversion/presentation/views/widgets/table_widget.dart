import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/format_date.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/widgets/sizer.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/conversion_date_info_loading_widget.dart';
import 'package:home_widget_4/utils/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DateConversionCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          BlocBuilder<DateConversionCubit, DateConversionState>(
            buildWhen: (prev, current) {
              return current.buildWhen == 'UPDATE_TABLE_WIDGET';
            },
            builder: (context, state) {
              DateTime selectedGeorgianDate =
                  controller.state.selectedGeorgianDate ?? DateTime.now();
              return TableCalendar(
                locale: context.locale.languageCode,
                firstDay: state.firstDay,
                lastDay: state.lastDay,
                // focusedDay: state.selectedYear == null ? selectedDay : DateTime(state.selectedYear!, 1, 1),
                focusedDay: selectedGeorgianDate,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedGeorgianDate, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedGeorgianDate = selectedDay;
                  });
                  _showIslamicInfo(context, selectedDay);
                  controller.getSelectedDateInfo(selectedDay);
                  // FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onFormatChanged: (format) {
                  // setState(() {
                  //   _calendarFormat = format;
                  // });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: context.secondaryHeaderColor,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  headerMargin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // formatButtonTextStyle: TextStyle(
                  //   color: Theme.of(context).primaryColor,
                  //   fontSize: 16.0,
                  // ),
                  titleTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showIslamicInfo(BuildContext context, DateTime selectedDay) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<DateConversionCubit, DateConversionState>(
          builder: (context, state) {
            if (state.getSelectedDateInfoState == ResponseEnum.loading) {
              return const ConversionDateInfoLoadingWidget();
            } else if (state.getSelectedDateInfoState == ResponseEnum.failure) {
              return const ConversionDateInfoFailureWidget();
            } else if (state.getSelectedDateInfoState == ResponseEnum.success) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                height: 250.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                  color: context.secondaryHeaderColor.withOpacity(0.4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    txt('DATE_INFO'.tr(), e: St.bold18, c: context.primaryColor),
                    const SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDateRow(
                            image: 'calendar_5.png',
                            title: 'GEORGIAN'.tr(),
                            date: formateDateDetailed(
                              (state.selectedDateConversionEntity?.selectedGeorgianDate)!,
                            ),
                          ),
                          _buildDateRow(
                            image: 'calendar_7.png',
                            title: 'REAL_HIJRI'.tr(),
                            // date: isEnglish()
                            //     ? (state.selectedDateConversionEntity?.newHijriUpdated ?? '')
                            //     : (state.selectedDateConversionEntity?.newHijriUpdatedAr ?? ''),
                            date: _localize(
                              state.selectedDateConversionEntity?.newHijriUpdated,
                              state.selectedDateConversionEntity?.newHijriUpdatedAr,
                              state.selectedDateConversionEntity?.selectedGeorgianDate,
                            ),
                          ),
                          _buildDateRow(
                            image: 'calendar_3.png',
                            title: 'CURRENT_HIJRI'.tr(),
                            // date: isEnglish()
                            //     ? (state.selectedDateConversionEntity?.selectedOldHijriDate ?? '')
                            //     : (state.selectedDateConversionEntity?.selectedOldHijriDateAr ?? ''),
                            date: _localize(
                              state.selectedDateConversionEntity?.selectedOldHijriDate,
                              state.selectedDateConversionEntity?.selectedOldHijriDateAr,
                              state.selectedDateConversionEntity?.selectedGeorgianDate,
                            ),
                          ),

                          // _buildDateRow(
                          //   image: 'calendar_9.png',
                          //   title: 'New Hijri date',
                          //   // date: state.selectedDateConversionEntity?.selectedNewHijriDate ?? '',
                          //   date: state.selectedOption == DataProcessingOption.after
                          //       ? state.selectedDateConversionEntity?.newHijriDateProccessed() ?? ''
                          //       : state.selectedDateConversionEntity?.selectedNewHijriDate ?? '',
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }

  String _localize(String? valueEn, String? valueAr, DateTime? selectedDate) {
    if (isEnglish() && valueEn != null && selectedDate != null) {
      return '$valueEn ${selectedDate.year >= 622 ? '(H)' : '(BH)'}';
    }
    if (!isEnglish() && valueAr != null && selectedDate != null) {
      return '$valueAr ${selectedDate.year >= 622 ? '(هجريا)' : '(قبل الهجرة)'}';
    }
    return '';
  }

  Widget _buildDateRow({required String title, required String date, required image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/$image', width: 20.w, height: 20.w),
          const Sizer(),
          txt('$title: ', e: St.semi16, c: context.primaryColor),
          Expanded(child: txt(date, e: St.reg14, maxLines: 2)),
        ],
      ),
    );
  }
}
