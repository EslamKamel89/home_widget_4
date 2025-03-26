enum MonthEnum {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

extension MonthEnumExtension on MonthEnum {
  String toShortString() {
    switch (this) {
      case MonthEnum.january:
        return 'jan';
      case MonthEnum.february:
        return 'feb';
      case MonthEnum.march:
        return 'mar';
      case MonthEnum.april:
        return 'apr';
      case MonthEnum.may:
        return 'may';
      case MonthEnum.june:
        return 'jun';
      case MonthEnum.july:
        return 'jul';
      case MonthEnum.august:
        return 'aug';
      case MonthEnum.september:
        return 'sep';
      case MonthEnum.october:
        return 'oct';
      case MonthEnum.november:
        return 'nov';
      case MonthEnum.december:
        return 'dec';
    }
  }

  String toFullString() {
    switch (this) {
      case MonthEnum.january:
        return 'January';
      case MonthEnum.february:
        return 'February';
      case MonthEnum.march:
        return 'March';
      case MonthEnum.april:
        return 'April';
      case MonthEnum.may:
        return 'May';
      case MonthEnum.june:
        return 'June';
      case MonthEnum.july:
        return 'July';
      case MonthEnum.august:
        return 'August';
      case MonthEnum.september:
        return 'September';
      case MonthEnum.october:
        return 'October';
      case MonthEnum.november:
        return 'November';
      case MonthEnum.december:
        return 'December';
    }
  }
}
