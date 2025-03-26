import 'package:flutter/foundation.dart';

T prx<T>(T variable, [String? title]) {
  return variable;
}

T prt<T>(
  T title,
) {
  if (kDebugMode) {
    String message =
        '${_toYellow("< eslam dev - ${title.toString()} >>>>>>>>>>>>>>>>>>>>>>>>>>>>> ")} ';
    print(message);
  }
  return title;
}

T pr<T>(T variable, [String? title]) {
  if (kDebugMode) {
    String message =
        '${_toRed("< eslam dev ${title == null ? "" : " - $title"}>")} '
        '${_toGreen(variable.toString())}';
    print(message);
  }
  return variable;
}

// yellow
String _toYellow(String text) {
  return '\x1B[33m$text\x1B[0m';
}

// red
String _toRed(String text) {
  return '\x1B[31m$text\x1B[0m';
}

// blue
String _toBlue(String text) {
  return '\x1B[34m$text\x1B[0m';
}

//green
String _toGreen(String text) {
  return '\x1B[32m$text\x1B[0m';
}
