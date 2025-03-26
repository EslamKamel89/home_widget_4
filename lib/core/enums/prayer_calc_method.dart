enum PrayerCalcMethod {
  muslimWorldLeague,
  egyptian,
  karachi,
  ummAlQura,
  dubai,
  qatar,
  kuwait,
  moonsightingCommittee,
  singapore,
  turkiye,
  tehran,
  northAmerica,
}

extension Description on PrayerCalcMethod {
  String description() {
    switch (this) {
      case PrayerCalcMethod.muslimWorldLeague:
        return 'Muslim World League. Standard Fajr time with an angle of 18°. Earlier Isha time with an angle of 17°.';
      case PrayerCalcMethod.egyptian:
        return 'Egyptian General Authority of Survey. Early Fajr time using an angle 19.5° and a slightly earlier Isha time using an angle of 17.5°.';
      case PrayerCalcMethod.karachi:
        return 'University of Islamic Sciences, Karachi. A generally applicable method that uses standard Fajr and Isha angles of 18°.';
      case PrayerCalcMethod.ummAlQura:
        return 'Umm al-Qura University, Makkah. Uses a fixed interval of 90 minutes from maghrib to calculate Isha. And a slightly earlier Fajr time with an angle of 18.5°. Note: you should add a +30 minute custom adjustment for Isha during Ramadan.';
      case PrayerCalcMethod.dubai:
        return 'Used in the UAE. Slightly earlier Fajr time and slightly later Isha time with angles of 18.2° for Fajr and Isha in addition to 3 minute offsets for sunrise, Dhuhr, Asr, and Maghrib.';
      case PrayerCalcMethod.qatar:
        return 'Same Isha interval as ummAlQura but with the standard Fajr time using an angle of 18°.';
      case PrayerCalcMethod.kuwait:
        return 'Standard Fajr time with an angle of 18°. Slightly earlier Isha time with an angle of 17.5°.';
      case PrayerCalcMethod.moonsightingCommittee:
        return 'Method developed by Khalid Shaukat, founder of Moonsighting Committee Worldwide. Uses standard 18° angles for Fajr and Isha in addition to seasonal adjustment values. This method automatically applies the 1/7 approximation rule for locations above 55° latitude. Recommended for North America and the UK.';
      case PrayerCalcMethod.singapore:
        return 'Used in Singapore, Malaysia, and Indonesia. Early Fajr time with an angle of 20° and standard Isha time with an angle of 18°.';
      case PrayerCalcMethod.turkiye:
        return 'An approximation of the Diyanet method used in Turkey. This approximation is less accurate outside the region of Turkey.';
      case PrayerCalcMethod.tehran:
        return 'Institute of Geophysics, University of Tehran. Early Isha time with an angle of 14°. Slightly later Fajr time with an angle of 17.7°. Calculates Maghrib based on the sun reaching an angle of 4.5° below the horizon.';
      case PrayerCalcMethod.northAmerica:
        return 'Also known as the ISNA method. Can be used for North America, but the moonsightingCommittee method is preferable. Gives later Fajr times and early Isha times with angles of 15°.';
    }
  }
}

extension Name on PrayerCalcMethod {
  String name() {
    switch (this) {
      case PrayerCalcMethod.muslimWorldLeague:
        return 'Muslim World League';
      case PrayerCalcMethod.egyptian:
        return 'Egyptian';
      case PrayerCalcMethod.karachi:
        return 'Karachi';
      case PrayerCalcMethod.ummAlQura:
        return 'Umm Al-Qura';
      case PrayerCalcMethod.dubai:
        return 'Dubai';
      case PrayerCalcMethod.qatar:
        return 'Qatar';
      case PrayerCalcMethod.kuwait:
        return 'Kuwait';
      case PrayerCalcMethod.moonsightingCommittee:
        return 'Moonsighting Committee';
      case PrayerCalcMethod.singapore:
        return 'Singapore';
      case PrayerCalcMethod.turkiye:
        return 'Turkiye';
      case PrayerCalcMethod.tehran:
        return 'Tehran';
      case PrayerCalcMethod.northAmerica:
        return 'North America';
    }
  }
}
