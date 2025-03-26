extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return '$day/$month/$year';
  }
}
