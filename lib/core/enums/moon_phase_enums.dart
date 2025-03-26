enum MoonPhaseEnum {
  fullMoon,
  lastMoon,
  firstMoon,
  newMoon,
}

extension MoonPhaseEnumExtension on MoonPhaseEnum {
  String toShortString() {
    switch (this) {
      case MoonPhaseEnum.fullMoon:
        return 'full';
      case MoonPhaseEnum.lastMoon:
        return 'last';
      case MoonPhaseEnum.firstMoon:
        return 'first';
      case MoonPhaseEnum.newMoon:
        return 'new';
    }
  }

  String toFullString() {
    switch (this) {
      case MoonPhaseEnum.fullMoon:
        return 'Full Moon';
      case MoonPhaseEnum.lastMoon:
        return 'Last Moon';
      case MoonPhaseEnum.firstMoon:
        return 'First Moon';
      case MoonPhaseEnum.newMoon:
        return 'New Moon';
    }
  }

  String toFullString2() {
    switch (this) {
      case MoonPhaseEnum.fullMoon:
        return 'Full Moon';
      case MoonPhaseEnum.lastMoon:
        return 'Last Quarter';
      case MoonPhaseEnum.firstMoon:
        return 'First Quarter';
      case MoonPhaseEnum.newMoon:
        return 'New Moon';
    }
  }

  String toArabic() {
    switch (this) {
      case MoonPhaseEnum.fullMoon:
        return 'بدر';
      case MoonPhaseEnum.lastMoon:
        return 'آخر هلال';
      case MoonPhaseEnum.firstMoon:
        return 'أول هلال';
      case MoonPhaseEnum.newMoon:
        return 'هلال جديد';
    }
  }
}
