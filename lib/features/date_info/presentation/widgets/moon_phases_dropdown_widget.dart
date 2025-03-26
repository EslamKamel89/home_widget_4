// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/enums/moon_phase_enums.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';
import 'package:home_widget_4/core/widgets/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MoonPhasesDropdownWidget extends StatefulWidget {
  const MoonPhasesDropdownWidget({super.key, required this.handleMonthSelected});
  final Function handleMonthSelected;
  @override
  MoonPhasesDropdownWidgetState createState() => MoonPhasesDropdownWidgetState();
}

class MoonPhasesDropdownWidgetState extends State<MoonPhasesDropdownWidget> {
  MoonDrawerItem? selectedMoonPhase = moonPhases[0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          DropdownButtonFormField<MoonDrawerItem>(
            value: selectedMoonPhase,
            items:
                moonPhases.map((monthDrawerItem) {
                  return DropdownMenuItem(
                    value: monthDrawerItem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(monthDrawerItem.icon, color: context.secondaryHeaderColor, size: 20.w),
                        const Sizer(),
                        Text(
                          isEnglish()
                              ? monthDrawerItem.moon.toFullString()
                              : monthDrawerItem.moon.toArabic(),
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            onChanged: (MoonDrawerItem? value) {
              setState(() {
                selectedMoonPhase = value;
              });
              widget.handleMonthSelected(value!.moon);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            dropdownColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class MoonDrawerItem {
  MoonPhaseEnum moon;
  IconData icon;
  MoonDrawerItem({required this.moon, required this.icon});
}

final List<MoonDrawerItem> moonPhases = [
  MoonDrawerItem(moon: MoonPhaseEnum.fullMoon, icon: MdiIcons.moonFull),
  MoonDrawerItem(moon: MoonPhaseEnum.lastMoon, icon: MdiIcons.moonLastQuarter),
  MoonDrawerItem(moon: MoonPhaseEnum.firstMoon, icon: MdiIcons.moonFirstQuarter),
  MoonDrawerItem(moon: MoonPhaseEnum.newMoon, icon: MdiIcons.moonNew),
];
