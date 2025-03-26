import 'package:flutter/material.dart';
import 'package:home_widget_4/core/enums/eclipse_enum.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';

class EclipseDropdownWidget extends StatefulWidget {
  const EclipseDropdownWidget({super.key, required this.handleEclipseSelected});
  final Function handleEclipseSelected;
  @override
  EclipseDropdownWidgetState createState() => EclipseDropdownWidgetState();
}

class EclipseDropdownWidgetState extends State<EclipseDropdownWidget> {
  // List of Eclipses
  final List<EclipseEnum> eclipses = [
    EclipseEnum.anullarSolar,
    EclipseEnum.hybridSolar,
    EclipseEnum.partialLunar,
    EclipseEnum.partialSolar,
    EclipseEnum.penumbralLunar,
    EclipseEnum.totalUmbralLunar,
    EclipseEnum.totalSolar,
  ];

  // Currently selected Eclipse
  EclipseEnum? selectedEclipse = EclipseEnum.anullarSolar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          DropdownButtonFormField<EclipseEnum>(
            value: selectedEclipse,
            items:
                eclipses.map((eclipse) {
                  return DropdownMenuItem(
                    value: eclipse,
                    child: Text(
                      isEnglish() ? eclipse.toFullString() : eclipse.toArabic(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedEclipse = value;
              });
              widget.handleEclipseSelected(value);
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
