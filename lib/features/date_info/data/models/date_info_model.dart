import 'package:home_widget_4/features/date_info/domain/entities/date_info_entity.dart';

class DateInfoModel extends DateInfoEntity {
  DateInfoModel({
    super.id,
    super.fmStart,
    super.fmEnd,
    super.hgStart,
    super.hgEnd,
    super.hnStart,
    super.hnEnd,
    super.oldHgHijriStart,
    super.oldHgHijriEnd,
    super.oldFmHijriStart,
    super.oldFmHijriEnd,
  });
  /*
  `fm_start`, `fm_end`, `hg_start`, `hg_end`, `hn_start`, `hn_end`, `old_hg_hijri_start`, `old_hg_hijri_end`, `old_fm_hijri_start`
  
   */
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fm_start': fmStart,
      'fm_end': fmEnd,
      'hg_start': hgStart,
      'hg_end': hgEnd,
      'hn_start': hnStart,
      'hn_end': hnEnd,
      'old_hg_hijri_start': oldHgHijriStart,
      'old_hg_hijri_end': oldHgHijriEnd,
      'old_fm_hijri_start': oldFmHijriStart,
      'old_fm_hijri_end': oldFmHijriEnd,
    };
  }

  factory DateInfoModel.fromJson(Map<String, dynamic> json) {
    return DateInfoModel(
      id: json['id'] != null ? json['id'] as String : null,
      fmStart: json['fm_start'] != null ? json['fm_start'] as String : null,
      fmEnd: json['fm_end'] != null ? json['fm_end'] as String : null,
      hgStart: json['hg_start'] != null ? json['hg_start'] as String : null,
      hgEnd: json['hg_end'] != null ? json['hg_end'] as String : null,
      hnStart: json['hn_start'] != null ? json['hn_start'] as String : null,
      hnEnd: json['hn_end'] != null ? json['hn_end'] as String : null,
      oldHgHijriStart:
          json['old_hg_hijri_start'] != null ? json['old_hg_hijri_start'] as String : null,
      oldHgHijriEnd: json['old_hg_hijri_end'] != null ? json['old_hg_hijri_end'] as String : null,
      oldFmHijriStart:
          json['old_fm_hijri_start'] != null ? json['old_fm_hijri_start'] as String : null,
      oldFmHijriEnd: json['old_fm_hijri_end'] != null ? json['old_fm_hijri_end'] as String : null,
    );
  }
}
