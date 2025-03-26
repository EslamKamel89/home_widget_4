class ApiLocale {
  String? ar;
  String? en;
  ApiLocale({
    this.ar,
    this.en,
  });

  @override
  String toString() => 'ApiLocale(ar: $ar, en: $en)';

  factory ApiLocale.fromJson(Map<String, dynamic> json) {
    return ApiLocale(
      ar: json['ar'] != null ? json['ar'] as String : null,
      en: json['en'] != null ? json['en'] as String : null,
    );
  }
}
