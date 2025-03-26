import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/globals/calc_method_settings.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class PrayerCalcOptions extends StatefulWidget {
  const PrayerCalcOptions({super.key});

  @override
  State<PrayerCalcOptions> createState() => _PrayerCalcOptionsState();
}

class _PrayerCalcOptionsState extends State<PrayerCalcOptions> {
  @override
  void initState() {
    selectedPrayersNotifier.addListener(_listner);
    super.initState();
  }

  @override
  void dispose() {
    selectedPrayersNotifier.removeListener(_listner);

    super.dispose();
  }

  void _listner() {
    pr(selectedPrayersNotifier.value, 'updating the selected value');
    selectedPrayersMethod = selectedPrayersNotifier.value;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        txt('CALC_METHOD'.tr(), e: St.bold20),
        const Divider(),
        AutoCalcMethodWidget(
          selectedMethod: selectedPrayersNotifier.value,
          onTap: () {
            selectedPrayersMethod = IslamicOrganization.auto;
            selectedPrayersNotifier.value = IslamicOrganization.auto;
            setState(() {});
            Navigator.of(context).pop();
          },
        ),
        ...List.generate(IslamicOrganization.values.length, (index) {
          final prayerCalc = IslamicOrganization.values[index];
          if (prayerCalc == IslamicOrganization.auto) return const SizedBox();
          return CalcMethodWidget(
            selectedMethod: selectedPrayersNotifier.value,
            prayerCalc: prayerCalc,
            onTap: () {
              selectedPrayersMethod = prayerCalc;
              selectedPrayersNotifier.value = prayerCalc;
              setState(() {});
              Navigator.of(context).pop();
            },
          );
        }),
      ],
    );
  }
}

class CalcMethodWidget extends StatelessWidget {
  const CalcMethodWidget({
    super.key,
    required this.selectedMethod,
    required this.prayerCalc,
    required this.onTap,
  });
  final IslamicOrganization selectedMethod;
  final IslamicOrganization prayerCalc;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: selectedMethod == prayerCalc ? context.primaryColor : null,
      borderOnForeground: true,
      child: ListTile(
        tileColor: selectedMethod == prayerCalc ? context.primaryColor : null,
        title: txt(
          isEnglish() ? prayerCalc.fullString : prayerCalc.arabicString,
          maxLines: 20,
          e: St.bold18,
          c: selectedMethod == prayerCalc ? Colors.white : null,
        ),
        // subtitle: txt(prayerCalc.description(),
        //     e: St.reg14,
        //     maxLines: 20,
        //     c: selectedMethod == prayerCalc ? Colors.white : null),
        onTap: onTap,
      ),
    );
  }
}

class AutoCalcMethodWidget extends StatelessWidget {
  const AutoCalcMethodWidget({super.key, required this.selectedMethod, required this.onTap});
  final IslamicOrganization selectedMethod;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    context.locale;
    return FutureBuilder(
      future: getPrayerCalcMethodByPosition(),
      builder: (context, snapShot) {
        return Stack(
          children: [
            Padding(
              // padding: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.only(top: 0),
              child: Card(
                color:
                    selectedMethod == IslamicOrganization.auto
                        ? context.primaryColor
                        // : context.secondaryHeaderColor.withOpacity(0.2),
                        : null,
                borderOnForeground: true,
                child: ListTile(
                  tileColor:
                      selectedMethod == IslamicOrganization.auto ? context.primaryColor : null,
                  title: txt(
                    isEnglish() ? 'Automatic' : "تلقائي",
                    e: St.bold18,
                    c: selectedMethod == IslamicOrganization.auto ? Colors.white : null,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapShot.connectionState != ConnectionState.done
                          ? txt(
                            isEnglish()
                                ? 'Calculating.... '
                                : 'يتم حساب'
                                    '...',
                            maxLines: 20,
                            e: St.reg16,
                            c: selectedMethod == IslamicOrganization.auto ? Colors.white : null,
                          )
                          : txt(
                            isEnglish()
                                ? (snapShot.data?.fullString ??
                                    IslamicOrganization.muslimWorldLeague.fullString)
                                : (snapShot.data?.arabicString ??
                                    IslamicOrganization.muslimWorldLeague.arabicString),
                            maxLines: 20,
                            e: St.reg16,
                            c: selectedMethod == IslamicOrganization.auto ? Colors.white : null,
                          ),
                    ],
                  ),
                  // subtitle: txt(prayerCalc.description(),
                  //     e: St.reg14,
                  //     maxLines: 20,
                  //     c: selectedMethod == prayerCalc ? Colors.white : null),
                  // subtitle: txt('Automatic Detection By\nCurrent Location',
                  //     c: selectedMethod == IslamicOrganization.auto
                  //         ? Colors.white
                  //         : null,
                  //     e: St.reg18),
                  onTap: onTap,
                ),
              ),
            ),
            // Positioned.directional(
            //   textDirection: isEnglish() ? ltr : rtl,
            //   top: 0,
            //   end: 0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: context.secondaryHeaderColor,
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //     child: txt('Auto Detected By Location',
            //         c: Colors.white,
            //         e: St.bold14,
            //         textAlign: TextAlign.center),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
