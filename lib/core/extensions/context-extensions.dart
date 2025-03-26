import 'package:flutter/material.dart';

extension ScreenWidth on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get secondaryHeaderColor => Theme.of(this).secondaryHeaderColor;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(this).dialogBackgroundColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get canvasColor => Theme.of(this).canvasColor;
}
