import 'dart:convert';

import 'package:citadel_super_app/data/model/country_code.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

final countryCodeProvider =
    StateNotifierProvider<CountryCodeState, CountryCode>(
        (ref) => CountryCodeState());

class CountryCodeState extends StateNotifier<CountryCode> {
  CountryCodeState() : super(CountryCode(countryCodes: []));

  Future<void> initFromJson(BuildContext context) async {
    final countryJson = await rootBundle.loadString(Assets.json.countries);
    state = CountryCode.fromJson(jsonDecode(countryJson));
  }

  CountryCodes? getObjectByCountryName({String? country}) {
    if (country == null) return null;

    return state.countryCodes?.firstWhereOrNull((element) =>
        element.countryName?.toLowerCase().trim() ==
        country.toLowerCase().trim());
  }

  CountryCodes? getObjectByDialCode({String? dialCode}) {
    if (dialCode == null) return null;

    return state.countryCodes?.firstWhereOrNull(
        (element) => element.diallingCode?.trim() == dialCode.trim());
  }

  String? getCountryByCountryCode(String countryCode) {
    final country = state.countryCodes?.firstWhereOrNull((element) =>
        element.countryCode?.toLowerCase() == countryCode.toLowerCase());

    return country?.countryName;
  }
}
