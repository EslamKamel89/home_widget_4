import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget_4/core/extensions/context-extensions.dart';
import 'package:home_widget_4/core/widgets/custom_fading_widget.dart';
import 'package:home_widget_4/utils/styles/styles.dart';

class ConversionDateInfoLoadingWidget extends StatelessWidget {
  const ConversionDateInfoLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 250.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        color: context.secondaryHeaderColor.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txt('DATE_INFO'.tr(), e: St.bold18, c: context.primaryColor),
          const SizedBox(height: 20.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShimmerEffectContainer(),
                _buildShimmerEffectContainer(),
                _buildShimmerEffectContainer(),
                // _buildShimmerEffectContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffectContainer() {
    return CustomFadingWidget(
      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
    );
  }
}

class ConversionDateInfoFailureWidget extends StatelessWidget {
  const ConversionDateInfoFailureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 250.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        color: context.secondaryHeaderColor.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txt('Date Information', e: St.bold18, c: context.primaryColor),
          const SizedBox(height: 20.0),
          Expanded(
            child: Center(
              child: txt(
                'An unexpected error has occurred.\nPlease try again.',
                e: St.reg16,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
