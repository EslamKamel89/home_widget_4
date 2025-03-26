import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/enums/moon_phase_enums.dart';
import 'package:home_widget_4/core/enums/response_state.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/widgets/default_screen_padding.dart';
import 'package:home_widget_4/core/widgets/sizer.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';
import 'package:home_widget_4/features/date_conversion/presentation/views/widgets/year_search_widget.dart';
import 'package:home_widget_4/features/date_info/presentation/cubits/moon_phase/moon_phase_cubit.dart';
import 'package:home_widget_4/features/date_info/presentation/widgets/moon_phase_item_card.dart';
import 'package:home_widget_4/features/date_info/presentation/widgets/moon_phases_dropdown_widget.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class MoonInfoView extends StatefulWidget {
  const MoonInfoView({super.key});

  @override
  State<MoonInfoView> createState() => _MoonInfoViewState();
}

class _MoonInfoViewState extends State<MoonInfoView> {
  late MoonPhaseCubit controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<MoonPhaseCubit>();
  }

  @override
  void dispose() {
    controller.state.moonPhasesInfo = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: txt("MOON_PHASE".tr(), e: St.bold20)),
      resizeToAvoidBottomInset: false,
      // drawer: const DefaultDrawer(),
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
                    controller.getMoonPhase(yearInt, controller.state.selectedMoonPhase);
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
            BlocBuilder<MoonPhaseCubit, MoonPhaseState>(
              builder: (context, state) {
                return state.validationMessage.isEmpty
                    ? const SizedBox()
                    : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: txt(state.validationMessage, c: Colors.red, e: St.reg16),
                    );
              },
            ),
            MoonPhasesDropdownWidget(
              handleMonthSelected: (MoonPhaseEnum moonPhase) {
                int maxYear = context.read<DateConversionCubit>().state.lastDay.year;
                int minYear = context.read<DateConversionCubit>().state.firstDay.year;
                pr(minYear, 'minYear');
                pr(maxYear, 'maxYear');
                controller.state.selectedMoonPhase = moonPhase;
                if (controller.state.selectedYear <= maxYear &&
                    controller.state.selectedYear >= minYear) {
                  controller.getMoonPhase(
                    controller.state.selectedYear,
                    controller.state.selectedMoonPhase,
                  );
                  controller.validate('');
                } else {
                  pr('condition not met');
                }
              },
            ),
            BlocBuilder<MoonPhaseCubit, MoonPhaseState>(
              builder: (context, state) {
                if (state.getMoonPhaseState == ResponseEnum.failure) {
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
                if (state.getMoonPhaseState == ResponseEnum.loading) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return MoonInfoItemCard(model: state.moonPhasesInfo[index]);
                    },
                    itemCount: state.moonPhasesInfo.length,
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
