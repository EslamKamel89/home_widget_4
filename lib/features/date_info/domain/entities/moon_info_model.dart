import 'package:home_widget_4/core/enums/eclipse_enum.dart';
import 'package:home_widget_4/core/enums/moon_phase_enums.dart';
import 'package:home_widget_4/core/heleprs/format_date.dart';
import 'package:home_widget_4/core/heleprs/is_ltr.dart';

class MoonInfoModel {
  String? id;
  String? datetime;
  String? phase;
  String? friendlydate;
  String? hjridate;
  String? ecllipse;

  MoonInfoModel({
    this.id,
    this.datetime,
    this.phase,
    this.friendlydate,
    this.hjridate,
    this.ecllipse,
  });

  @override
  String toString() {
    return 'MoonInfoModel(id: $id, datetime: $datetime, phase: $phase, friendlydate: $friendlydate, hjridate: $hjridate, ecllipse: $ecllipse)';
  }

  factory MoonInfoModel.fromJson(Map<String, dynamic> json) => MoonInfoModel(
    id: json['id'] as String?,
    datetime: json['datetime'] as String?,
    phase: json['phase'] as String?,
    friendlydate: json['friendlydate'] as String?,
    hjridate: json['hjridate'] as String?,
    ecllipse: json['ecllipse'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'datetime': datetime,
    'phase': phase,
    'friendlydate': friendlydate,
    'hjridate': hjridate,
    'ecllipse': ecllipse,
  };
  String getPahse() {
    try {
      if (isEnglish() || phase == null) return phase ?? '';
      final phases = MoonPhaseEnum.values.where(
        (e) => e.toFullString2().trim().toLowerCase().contains(phase!.trim().toLowerCase()),
      );
      if (phases.isEmpty) return phase ?? '';
      return phases.first.toArabic();
    } on Exception catch (_) {
      return phase ?? '';
    }
  }

  String getFriendlyDate() {
    if (isEnglish() || friendlydate == null) return friendlydate ?? '';
    return formatGregorianDateToArabic(friendlydate!);
  }

  String getHjriDate() {
    if (isEnglish()) return hjridate ?? '';
    return localizeHijriDate(hjridate);
  }

  String getEclipse() {
    if (isEnglish()) return ecllipse ?? '';
    return EclipseEnum.values
        .where(
          (e) => e.toFullString().trim().toLowerCase().contains(ecllipse!.trim().toLowerCase()),
        )
        .first
        .toArabic();
  }
}
