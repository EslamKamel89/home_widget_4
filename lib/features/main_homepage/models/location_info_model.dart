// ignore_for_file: public_member_api_docs, sort_constructors_first

// class LocationInfoModel {
//   String? houseNumber;
//   String? road;
//   String? neighbourhood;
//   String? town;
//   String? village;
//   String? residential;
//   String? suburb;
//   String? city;
//   String? state;
//   String? iso31662Lvl4;
//   String? country;
//   String? countryCode;
//   String? county;

//   LocationInfoModel({
//     this.houseNumber,
//     this.road,
//     this.town,
//     this.neighbourhood,
//     this.village,
//     this.residential,
//     this.suburb,
//     this.city,
//     this.state,
//     this.iso31662Lvl4,
//     this.country,
//     this.countryCode,
//     this.county,
//   });

//   @override
//   String toString() {
//     return 'LocationInfoModel(houseNumber:$houseNumber  road: $road,town:$town neighbourhood: $neighbourhood,county:$county,residential:$residential, suburb:$suburb, village: $village city: $city, state: $state, iso31662Lvl4: $iso31662Lvl4, country: $country, countryCode: $countryCode)';
//   }

//   factory LocationInfoModel.fromJson(Map<String, dynamic> json) {
//     return LocationInfoModel(
//       road: json['road'] as String?,
//       neighbourhood: json['neighbourhood'] as String?,
//       city: json['city'] as String?,
//       state: json['state'] as String?,
//       iso31662Lvl4: json['ISO3166-2-lvl4'] as String?,
//       country: json['country'] as String?,
//       countryCode: json['country_code'] as String?,
//       county: json['county'] as String?,
//       town: json['town'] as String?,
//       houseNumber: json['house_number'] as String?,
//       residential: json['residential'] as String?,
//       suburb: json['suburb'] as String?,
//       // village: json['village'] as String?,
//       // village: json['village'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'road': road,
//         'neighbourhood': neighbourhood,
//         'city': city,
//         'state': state,
//         'ISO3166-2-lvl4': iso31662Lvl4,
//         'country': country,
//         'country_code': countryCode,
//         'town': town,
//         'village': village,
//         'house_number': houseNumber,
//       };
// }

import 'package:home_widget_4/core/models/api_locale.dart';

class LocationInfoModel {
  ApiLocale? one;
  ApiLocale? two;
  ApiLocale? three;
  ApiLocale? four;
  ApiLocale? displayName;
  LocationInfoModel({this.one, this.two, this.three, this.four, this.displayName});

  factory LocationInfoModel.fromMap(Map<String, dynamic> map) {
    return LocationInfoModel(
      one: map['1'] != null ? ApiLocale.fromJson(map['1']) : null,
      two: map['2'] != null ? ApiLocale.fromJson(map['2']) : null,
      three: map['3'] != null ? ApiLocale.fromJson(map['3']) : null,
      four: map['4'] != null ? ApiLocale.fromJson(map['4']) : null,
      displayName: map['display_name'] != null ? ApiLocale.fromJson(map['display_name']) : null,
    );
  }

  @override
  String toString() {
    return 'LocationInfoModel2(one: $one, two: $two, three: $three, four: $four)';
  }
}
