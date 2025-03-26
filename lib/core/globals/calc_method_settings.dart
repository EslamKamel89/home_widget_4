import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:home_widget_4/core/heleprs/determine_position.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';
import 'package:home_widget_4/core/service_locator/service_locator.dart';
import 'package:home_widget_4/core/static_data/shared_prefrences_key.dart';
import 'package:home_widget_4/features/main_homepage/controllers/params.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<IslamicOrganization> selectedPrayersNotifier = ValueNotifier<IslamicOrganization>(
  selectedPrayersMethod,
);
IslamicOrganization selectedPrayersMethod = () {
  final sp = serviceLocator<SharedPreferences>();
  final cachedCalcValue = sp.getInt(ShPrefKey.calcPrayerTimeSetting);
  if (cachedCalcValue == null) return IslamicOrganization.muslimWorldLeague;
  return IslamicOrganization.values.firstWhere((calcMethod) => calcMethod.value == cachedCalcValue);
}();

void cachePrayerMehtod() {
  selectedPrayersNotifier.addListener(() {
    pr(selectedPrayersNotifier.value.value, 'Caching prayer caluclation method');
    serviceLocator<SharedPreferences>().setInt(
      ShPrefKey.calcPrayerTimeSetting,
      selectedPrayersNotifier.value.value,
    );
  });
}

Future<void> checkUserCountry() async {
  final t = prt('checkUserCountry');
  try {
    if (positionNotifier.value == null) return;
    pr(positionNotifier.value, '$t - positionNotifier.value');
    final sp = serviceLocator<SharedPreferences>();
    final cachedCalcValue = sp.getInt(ShPrefKey.calcPrayerTimeSetting);
    pr(cachedCalcValue, '$t - cachedCalcValue');
    if (cachedCalcValue != null) return;
    IslamicOrganization? calcMethod = await getPrayerCalcMethodByPosition();
    sp.setInt(ShPrefKey.calcPrayerTimeSetting, calcMethod?.value ?? 3);
    selectedPrayersNotifier.value = calcMethod ?? IslamicOrganization.muslimWorldLeague;
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //     positionNotifier.value!.latitude, positionNotifier.value!.longitude);
    // if (placemarks.isEmpty) return;
    // pr(placemarks, '$t - placemarks');
    // String? country = placemarks.first.country;
    // if (country == null) return;
    // pr(country, '$t - country');
    // final userCountry = country.toLowerCase();
    // final monitoredCountries = [
    //   'united states of america',
    //   'united states',
    //   'united arab emirates',
    //   'egypt',
    //   // 'saudi arabia',
    //   'kuwait',
    //   'qatar',
    //   'france',
    //   'morocco',
    // ];
    // if (!monitoredCountries.contains(userCountry)) return;
    // pr('country found', t);
    // switch (userCountry) {
    //   case 'united states of america':
    //     sp.setInt(ShPrefKey.calcPrayerTimeSetting,
    //         IslamicOrganization.islamicSocietyNorthAmerica.value);
    //     selectedPrayersNotifier.value =
    //         IslamicOrganization.islamicSocietyNorthAmerica;
    //     break;
    //   case 'united states':
    //     sp.setInt(ShPrefKey.calcPrayerTimeSetting,
    //         IslamicOrganization.islamicSocietyNorthAmerica.value);
    //     selectedPrayersNotifier.value =
    //         IslamicOrganization.islamicSocietyNorthAmerica;
    //     break;
    //   case 'united arab emirates':
    //     sp.setInt(
    //         ShPrefKey.calcPrayerTimeSetting, IslamicOrganization.dubai.value);
    //     selectedPrayersNotifier.value = pr(IslamicOrganization.dubai, t);

    //     break;
    //   case 'egypt':
    //     sp.setInt(ShPrefKey.calcPrayerTimeSetting,
    //         IslamicOrganization.egyptianGeneralAuthority.value);
    //     selectedPrayersNotifier.value =
    //         IslamicOrganization.egyptianGeneralAuthority;
    //     break;
    //   case 'kuwait':
    //     sp.setInt(
    //         ShPrefKey.calcPrayerTimeSetting, IslamicOrganization.kuwait.value);
    //     selectedPrayersNotifier.value = IslamicOrganization.kuwait;
    //     break;
    //   case 'qatar':
    //     sp.setInt(
    //         ShPrefKey.calcPrayerTimeSetting, IslamicOrganization.qatar.value);
    //     selectedPrayersNotifier.value = IslamicOrganization.qatar;
    //     break;
    //   case 'france':
    //     sp.setInt(ShPrefKey.calcPrayerTimeSetting,
    //         IslamicOrganization.unionOrganizationIslamicDeFrance.value);
    //     selectedPrayersNotifier.value =
    //         IslamicOrganization.unionOrganizationIslamicDeFrance;
    //     break;
    //   case 'morocco':
    //     sp.setInt(
    //         ShPrefKey.calcPrayerTimeSetting, IslamicOrganization.morocco.value);
    //     selectedPrayersNotifier.value = IslamicOrganization.morocco;
    //     break;
    // }
  } catch (e) {
    pr("Error occurred during geocoding: $e", 'checkUserCountry');
  }
}

Future<IslamicOrganization?> getPrayerCalcMethodByPosition() async {
  final t = prt('getPrayerCalcMethodByPosition');
  try {
    if (positionNotifier.value == null) return null;
    pr(positionNotifier.value, '$t - positionNotifier.value');
    List<Placemark> placemarks = await placemarkFromCoordinates(
      positionNotifier.value!.latitude,
      positionNotifier.value!.longitude,
    );
    if (placemarks.isEmpty) return null;
    pr(placemarks, '$t - placemarks');
    String? country = placemarks.first.country;
    if (country == null) return null;
    pr(country, '$t - country');
    final userCountry = country.toLowerCase();
    final monitoredCountries = [
      'united states of america',
      'united states',
      'united arab emirates',
      'egypt',
      'kuwait',
      'qatar',
      'france',
      'morocco',
    ];
    if (!monitoredCountries.contains(userCountry)) return null;
    pr('country found', t);
    IslamicOrganization? result;
    switch (userCountry) {
      case 'united states of america':
        result = IslamicOrganization.islamicSocietyNorthAmerica;
        break;
      case 'united states':
        result = IslamicOrganization.islamicSocietyNorthAmerica;
        break;
      case 'united arab emirates':
        result = IslamicOrganization.dubai;
        break;
      case 'egypt':
        result = IslamicOrganization.egyptianGeneralAuthority;
        break;
      case 'kuwait':
        result = IslamicOrganization.kuwait;
        break;
      case 'qatar':
        result = IslamicOrganization.qatar;
        break;
      case 'france':
        result = IslamicOrganization.unionOrganizationIslamicDeFrance;
        break;
      case 'morocco':
        result = IslamicOrganization.morocco;
        break;
    }
    return pr(result, '$t - result');
  } catch (e) {
    pr("Error occurred during geocoding: $e", t);
  }
  return null;
}
