import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/features/date_conversion/presentation/cubits/date_conversion/date_conversion_cubit.dart';

class DataSelector extends StatefulWidget {
  const DataSelector({super.key});

  @override
  DataSelectorState createState() => DataSelectorState();
}

enum DataProcessingOption { regular, lunar }

class DataSelectorState extends State<DataSelector> {
  // DataProcessingOption? _selectedOption = DataProcessingOption.after;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<DateConversionCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'SELECT_DATA_TYPE'.tr(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: context.primaryColor,
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                child: RadioListTile<DataProcessingOption>(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LUNAR'.tr(),
                        style: TextStyle(
                          color:
                              controller.state.selectedOption == DataProcessingOption.lunar
                                  ? context.primaryColor
                                  : null,
                          fontWeight:
                              controller.state.selectedOption == DataProcessingOption.lunar
                                  ? FontWeight.bold
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  value: DataProcessingOption.lunar,
                  selectedTileColor: context.secondaryHeaderColor,
                  activeColor: context.secondaryHeaderColor,
                  groupValue: controller.state.selectedOption,
                  onChanged: (DataProcessingOption? value) {
                    setState(() {
                      controller.state.selectedOption = value!;
                    });
                    // pr(controller.state.selectedOption, 'DataProcessingOption - after');
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<DataProcessingOption>(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGULAR'.tr(),
                        style: TextStyle(
                          color:
                              controller.state.selectedOption == DataProcessingOption.regular
                                  ? context.primaryColor
                                  : null,
                          fontWeight:
                              controller.state.selectedOption == DataProcessingOption.regular
                                  ? FontWeight.bold
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  value: DataProcessingOption.regular,
                  selectedTileColor: context.secondaryHeaderColor,
                  activeColor: context.secondaryHeaderColor,
                  groupValue: controller.state.selectedOption,
                  onChanged: (DataProcessingOption? value) {
                    setState(() {
                      controller.state.selectedOption = value!;
                    });
                    // pr(controller.state.selectedOption, 'DataProcessingOption - before');
                  },
                ),
              ),
            ],
          ),
          // const SizedBox(height: 32.0),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_selectedOption != null) {
          //       _showSelectedOption(context, _selectedOption!);
          //     }
          //   },
          //   child: const Text('Submit'),
          // ),
        ],
      ),
    );
  }
}
