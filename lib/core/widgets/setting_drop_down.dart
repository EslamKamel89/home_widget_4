import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:home_widget_4/core/enums/prayer_calc_method.dart';
import 'package:home_widget_4/core/widgets/language_selector.dart';
import 'package:home_widget_4/core/widgets/prayer_calc_options.dart';

class SettingsDropdown extends StatefulWidget {
  const SettingsDropdown({super.key});
  @override
  State<SettingsDropdown> createState() => _SettingsDropdownState();
}

class _SettingsDropdownState extends State<SettingsDropdown> {
  PrayerCalcMethod selectedMethod = PrayerCalcMethod.muslimWorldLeague;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
            Icons.settings,
            size: 36,
            // color: Theme.of(context).colorScheme.primary,
            color: Colors.white,
          )
          .animate(onPlay: (controller) => controller.repeat())
          .rotate(duration: 10000.ms, begin: 0, end: 2),
      onPressed: () {
        _showModernDropdown(context);
      },
      tooltip: 'Open Settings',
    );
  }

  void _showModernDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const OptionsWidget(),
    );
  }
}

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({super.key});
  @override
  State<OptionsWidget> createState() => OptionsWidgetState();
}

class OptionsWidgetState extends State<OptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: const [
          // ElevatedButton(
          //   onPressed: () {
          //     serviceLocator<SharedPreferences>().clear();
          //   },
          //   child: const Text('Clear Memory'),
          // ),
          SizedBox(height: 20),
          LanguageSelector(),
          PrayerCalcOptions(),
        ],
      ),
    );
  }
}
