class WisdomModel {
  String? id;
  String? wisdomAr;
  String? wisdomEn;

  WisdomModel({this.id, this.wisdomAr, this.wisdomEn});

  @override
  String toString() {
    return 'WisdomModel(id: $id, wisdomAr: $wisdomAr, wisdomEn: $wisdomEn)';
  }

  factory WisdomModel.fromJson(Map<String, dynamic> json) => WisdomModel(
        id: json['id'] as String?,
        wisdomAr: json['wisdom_ar'] as String?,
        wisdomEn: json['wisdom_en'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'wisdom_ar': wisdomAr,
        'wisdom_en': wisdomEn,
      };
}
