import 'package:flutter/material.dart';
import 'package:home_widget_4/core/enums/month_enums.dart';

class MonthDropdownWidget extends StatefulWidget {
  const MonthDropdownWidget({super.key, required this.handleMonthSelected});
  final Function handleMonthSelected;
  @override
  MonthDropdownWidgetState createState() => MonthDropdownWidgetState();
}

class MonthDropdownWidgetState extends State<MonthDropdownWidget> {
  // List of months
  final List<MonthEnum> months = [
    MonthEnum.january,
    MonthEnum.february,
    MonthEnum.march,
    MonthEnum.april,
    MonthEnum.may,
    MonthEnum.june,
    MonthEnum.july,
    MonthEnum.august,
    MonthEnum.september,
    MonthEnum.october,
    MonthEnum.november,
    MonthEnum.december,
  ];

  // Currently selected month
  MonthEnum? selectedMonth = MonthEnum.january;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          DropdownButtonFormField<MonthEnum>(
            value: selectedMonth,
            items:
                months.map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text(
                      month.toFullString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedMonth = value;
              });
              widget.handleMonthSelected(value);
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
