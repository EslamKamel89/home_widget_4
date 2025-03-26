import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/themes/themedata.dart';
import 'package:home_widget_4/features/date_info/domain/entities/moon_info_model.dart';

class MoonInfoItemCard extends StatefulWidget {
  final MoonInfoModel model;

  const MoonInfoItemCard({super.key, required this.model});

  @override
  State<MoonInfoItemCard> createState() => _MoonInfoItemCardState();
}

class _MoonInfoItemCardState extends State<MoonInfoItemCard> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Creates a shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      margin: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.primaryColor, context.primaryColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20), // Same as card shape for consistency
          boxShadow: [
            BoxShadow(
              color: context.secondaryHeaderColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.model.getFriendlyDate(),
                      // "Main title",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: context.secondaryHeaderColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: context.secondaryHeaderColor,
                      size: 30.w,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: isVisible,
                child: Column(
                  children: [
                    _buildDataItem('MOON_PHASE'.tr(), widget.model.getPahse()),
                    _buildDataItem('HIJRI_DATE'.tr(), widget.model.getHjriDate()),
                    widget.model.ecllipse == '' || widget.model.ecllipse == null
                        ? const SizedBox()
                        : _buildDataItem('MOON_ECLIPSE'.tr(), widget.model.getEclipse()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontSize: 17.sp, color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          Text(value, style: TextStyle(fontSize: 17.sp, color: Colors.white70)),
          Divider(color: lightTheme.secondaryHeaderColor),
        ],
      ),
    );
  }
}
