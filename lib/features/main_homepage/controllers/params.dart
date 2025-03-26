// https://api.aladhan.com/v1/timings/01-01-2025?latitude=51.5194682&longitude=-0.1360365&method=3&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6&timezonestring=UTC&calendarMethod=UAQ
class PrayerTimeParams {
  double? latitude;
  double? longitude;
  IslamicOrganization? method;
  DateTime? date;
  LatitudeAdjustmentMethod? latitudeAdjustmentMethod;
  PrayerTimeParams(
      {this.latitude,
      this.longitude,
      this.method,
      this.latitudeAdjustmentMethod,
      this.date});

  PrayerTimeParams copyWith({
    double? latitude,
    double? longitude,
    IslamicOrganization? method,
    LatitudeAdjustmentMethod? latitudeAdjustmentMethod,
    DateTime? date,
  }) {
    return PrayerTimeParams(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      method: method ?? this.method,
      latitudeAdjustmentMethod:
          latitudeAdjustmentMethod ?? this.latitudeAdjustmentMethod,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'method': method?.value,
      'latitudeAdjustmentMethod': latitudeAdjustmentMethod?.value,
    };
  }

  @override
  String toString() {
    return 'PrayerTimeParams(latitude: $latitude, longitude: $longitude, method: $method, latitudeAdjustmentMethod: $latitudeAdjustmentMethod)';
  }
}

enum IslamicOrganization {
  // jafariShiaIthnaAshari(0, 'Jafari / Shia Ithna-Ashari'),
  auto(1, 'auto', "اوتو"),
  universityIslamicSciencesKarachi(1, 'University of Islamic Sciences, Karachi',
      "جامعة العلوم الإسلامية، كراتشي"),
  islamicSocietyNorthAmerica(2, 'Islamic Society of North America',
      "الجمعية الإسلامية لأمريكا الشمالية"),
  muslimWorldLeague(3, 'Muslim World League', "رابطة العالم الإسلامي"),
  ummAlQuraUniversity(
      4, 'Umm Al-Qura University, Makkah', "جامعة أم القرى، مكة"),
  egyptianGeneralAuthority(5, 'Egyptian General Authority of Survey',
      "الهيئة المصرية العامة للمساحة"),
  instituteOfGeophysics(7, 'Institute of Geophysics, University of Tehran',
      "معهد الجيوفيزياء، جامعة طهران"),
  gulfRegion(8, 'Gulf Region', "منطقة الخليج"),
  kuwait(9, 'Kuwait', "الكويت"),
  qatar(10, 'Qatar', "قطر"),
  majlisUgamaIslamSingapura(11, 'Majlis Ugama Islam Singapura, Singapore',
      "مجلس العلماء المسلمين، سنغافورة"),
  unionOrganizationIslamicDeFrance(
      12, 'Union Organization islamic de France', "المنظمة الإسلامية الفرنسية"),
  diyanetIsleri(
      13, 'Diyanet İşleri Başkanlığı, Turkey', "رئاسة الشؤون الدينية التركية"),
  spiritualAdministrationMuslimsRussia(
      14,
      'Spiritual Administration of Muslims of Russia',
      "الإدارة الدينية لمسلمي روسيا"),
  moonsightingCommitteeWorldwide(
      15,
      'Moonsighting Committee Worldwide (also requires shafaq parameter)',
      "لجنة رؤية الهلال العالمية (يتطلب أيضا معلمة الشفق)"),
  dubai(16, 'Dubai (experimental)', "دبي (تجريبي)"),
  jabatanKemajuanIslamMalaysia(17, 'Jabatan Kemajuan Islam Malaysia (JAKIM)',
      "إدارة التنمية الإسلامية الماليزية"),
  tunisia(18, 'Tunisia', "تونس"),
  algeria(19, 'Algeria', "الجزائر"),
  kemenagIndonesia(20, 'KEMENAG - Kementerian Agama Republik Indonesia',
      "وزارة الشؤون الدينية للجمهورية الإندونيسية"),
  morocco(21, 'Morocco', "المغرب"),
  comunidadeIslamicaLisboa(
      22, 'Comunidade Islamica de Lisboa', "الجماعة الإسلامية في لشبونة"),
  ministryAwqafJordan(
      23,
      'Ministry of Awqaf, Islamic Affairs and Holy Places, Jordan',
      "وزارة الأوقاف والشؤون والمقدسات الإسلامية، الأردن");
  // custom(99, 'Custom');

  final int value;
  final String fullString;
  final String arabicString;

  const IslamicOrganization(this.value, this.fullString, this.arabicString);
}

enum LatitudeAdjustmentMethod {
  middleOfTheNight(1, 'Middle of the Night'),
  oneSeventh(2, 'One Seventh'),
  angleBased(3, 'Angle Based');

  final int value;
  final String fullString;

  const LatitudeAdjustmentMethod(this.value, this.fullString);
}
