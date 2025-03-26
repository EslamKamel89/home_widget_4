import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:home_widget_4/core/globals/globals_var.dart';

bool isEnglish() {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) return true;
  return context.locale.languageCode != 'ar';
}
