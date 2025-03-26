import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';

class YearSearchWidget extends StatefulWidget {
  const YearSearchWidget({super.key, required this.handleInputChange});
  final Function handleInputChange;
  @override
  State<YearSearchWidget> createState() => _YearSearchWidgetState();
}

class _YearSearchWidgetState extends State<YearSearchWidget> {
  final TextEditingController _yearController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        // focusNode: focusNode,
        controller: _yearController,
        onChanged: (value) {
          _yearController.text = value;
          if (value.length >= 4) {
            focusNode.unfocus();
          }
          widget.handleInputChange(value);
        },
        keyboardType: TextInputType.number,
        maxLength: 4,
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          prefixIcon: SizedBox(
            width: 100.w,
            child: Center(
              child: Text(
                'GO_TO_YEAR'.tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
          hintText: 'YYYY',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color(0xFF0D3B66)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color(0xFF0D3B66)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color(0xFFB8860B)),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        ),
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }
}
