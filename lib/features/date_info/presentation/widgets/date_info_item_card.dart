import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/themes/themedata.dart';
import 'package:home_widget_4/features/date_info/domain/entities/date_info_entity.dart';

class DateInfoItemCard extends StatefulWidget {
  final DateInfoEntity model;

  const DateInfoItemCard({super.key, required this.model});

  @override
  State<DateInfoItemCard> createState() => _DateInfoItemCardState();
}

class _DateInfoItemCardState extends State<DateInfoItemCard> {
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
                      "New Hijri Start Date:\n${widget.model.hnStart}",
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
                    _buildDataItem('Full Moon Start', '${widget.model.fmStart}'),
                    _buildDataItem('Full Moon End', '${widget.model.fmEnd}'),
                    _buildDataItem('Hijri Start', '${widget.model.hgStart}'),
                    _buildDataItem('Hijri End', '${widget.model.hgEnd}'),
                    _buildDataItem('Hijri New Start', '${widget.model.hnStart}'),
                    _buildDataItem('Hijri New End', '${widget.model.hnEnd}'),
                    _buildDataItem('Hijri Old Start', '${widget.model.oldHgHijriStart}'),
                    _buildDataItem('Hijri Old End', '${widget.model.oldHgHijriEnd}'),
                    _buildDataItem('Old FM Hijri Start', '${widget.model.oldFmHijriStart}'),
                    _buildDataItem('Old FM Moon Hijri End', '${widget.model.oldFmHijriEnd}'),
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
