import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/vo/client_agent_details_vo.dart';
import 'package:citadel_super_app/data/vo/client_employment_details_vo.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_vo.dart';
import 'package:citadel_super_app/data/vo/client_wealth_source_details_vo.dart';
import 'package:citadel_super_app/data/vo/guardian_vo.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:intl/intl.dart';

import '../data/vo/individual_beneficiary_vo.dart';

extension ClientPersonalExtension on ClientPersonalDetailsVo? {
  String get nameDisplay => this?.name ?? '';

  String get identityCardNumberDisplay => this?.identityCardNumber ?? '';

  String get dobDisplay => this?.dob == null
      ? ''
      : DateFormat('dd-MM-yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(this!.dob!));

  String get fullAddressDisplay =>
      '$addressDisplay, $postcodeDisplay, $cityDisplay, ${stateDisplay.toCamelCase()}, $countryDisplay';

  String get addressDisplay => this?.address ?? '';

  String get postcodeDisplay => this?.postcode ?? '';

  String get cityDisplay => this?.city ?? '';

  String get stateDisplay => this?.state ?? '';

  String get countryDisplay => this?.country ?? '';

  String get fullCorrespondingAddressDisplay {
    if (correspondingAddressDisplay.isEmpty &&
        correspondingPostcodeDisplay.isEmpty &&
        correspondingCityDisplay.isEmpty &&
        correspondingStateDisplay.isEmpty &&
        correspondingCountryDisplay.isEmpty) {
      return fullAddressDisplay;
    }
    return '$correspondingAddressDisplay, $correspondingPostcodeDisplay, $correspondingCityDisplay, ${correspondingStateDisplay.toCamelCase()}, $correspondingCountryDisplay';
  }

  String get correspondingAddressDisplay =>
      this?.correspondingAddress?.correspondingAddress ?? '';
  String get correspondingPostcodeDisplay =>
      this?.correspondingAddress?.correspondingPostcode ?? '';
  String get correspondingCityDisplay =>
      this?.correspondingAddress?.correspondingCity ?? '';
  String get correspondingStateDisplay =>
      this?.correspondingAddress?.correspondingState ?? '';
  String get correspondingCountryDisplay =>
      this?.correspondingAddress?.correspondingCountry ?? '';

  String get addressProofDocDisplay =>
      this?.correspondingAddress?.correspondingAddressProofKey ?? '';

  String get nationalityDisplay => this?.nationality ?? '';

  String get fullMobileNumberDisplay =>
      '${this?.mobileCountryCode ?? ''} ${this?.mobileNumber ?? ''}';

  String get mobileNumberDisplay => this?.mobileNumber ?? '';

  String get mobileCountryCodeDisplay => this?.mobileCountryCode ?? '';

  String get genderDisplay => this?.gender ?? '';

  String get emailDisplay => this?.email ?? '';

  String get maritalStatusDisplay => this?.maritalStatus ?? '';

  String get residentialStatusDisplay => this?.residentialStatus ?? '';

  Address get addressModel => Address(
        street: addressDisplay,
        postCode: postcodeDisplay,
        city: cityDisplay,
        state: stateDisplay,
        country: countryDisplay,
        isSameCorrespondingAddress:
            this?.correspondingAddress?.isSameCorrespondingAddress ?? false,
        correspondAddress: Address(
          street: correspondingAddressDisplay,
          postCode: correspondingPostcodeDisplay,
          city: correspondingCityDisplay,
          state: correspondingStateDisplay,
          country: correspondingCountryDisplay,
        ),
      );

  bool get isNew =>
      (nameDisplay.isEmpty &&
          identityCardNumberDisplay.isEmpty &&
          this?.dob == null &&
          addressDisplay.isEmpty &&
          postcodeDisplay.isEmpty &&
          cityDisplay.isEmpty &&
          stateDisplay.isEmpty &&
          countryDisplay.isEmpty &&
          mobileNumberDisplay.isEmpty &&
          genderDisplay.isEmpty &&
          emailDisplay.isEmpty &&
          maritalStatusDisplay.isEmpty &&
          residentialStatusDisplay.isEmpty &&
          nationalityDisplay.isEmpty) ||
      this == null;
}

extension ClientEmploymentExtension on ClientEmploymentDetailsVo? {
  String get employmentTypeDisplay => this?.employmentType ?? '';

  String get employerNameDisplay => this?.employerName ?? '-';

  String get industryTypeDisplay => this?.industryType ?? '-';

  String get jobTitleDisplay => this?.jobTitle ?? '-';

  String get employerAddressDisplay => this?.employerAddress ?? '';

  String get employerPostcodeDisplay => this?.employerPostcode ?? '';

  String get employerCityDisplay => this?.employerCity ?? '';

  String get employerStateDisplay => this?.employerState ?? '';

  String get employerCountryDisplay => this?.employerCountry ?? '';

  String get employerFullAddressDisplay {
    if (employerAddressDisplay.isEmpty &&
        employerPostcodeDisplay.isEmpty &&
        employerCityDisplay.isEmpty &&
        employerStateDisplay.isEmpty &&
        employerCountryDisplay.isEmpty) {
      return '-';
    }
    return '$employerAddressDisplay, $employerPostcodeDisplay, $employerCityDisplay, $employerStateDisplay, $employerCountryDisplay';
  }

  Address get employerAddressObject => Address(
        street: employerAddressDisplay,
        postCode: employerPostcodeDisplay,
        city: employerCityDisplay,
        state: employerStateDisplay,
        country: employerCountryDisplay,
      );

  bool get isNew =>
      (employmentTypeDisplay.isEmpty &&
          employerNameDisplay.isEmpty &&
          industryTypeDisplay.isEmpty &&
          jobTitleDisplay.isEmpty &&
          employerAddressDisplay.isEmpty &&
          employerPostcodeDisplay.isEmpty &&
          employerCityDisplay.isEmpty &&
          employerStateDisplay.isEmpty &&
          employerCountryDisplay.isEmpty) ||
      this == null;
}

extension ClientAgentExtension on ClientAgentDetailsVo? {
  String get agentNameDisplay => this?.agentName ?? '';

  String get agentReferralCodeDisplay => this?.agentReferralCode ?? '';

  String get agentIdDisplay => this?.agentId ?? '';

  String get agencyNameDisplay => this?.agencyName ?? '';

  String get agencyIdDisplay => this?.agencyId ?? '';

  String get agentCountryCodeDisplay => this?.agentCountryCode ?? '';

  String get agentMobileNumberDisplay => this?.agentMobileNumber ?? '';

  String get agentFullMobileDisplay =>
      '$agentCountryCodeDisplay $agentMobileNumberDisplay';

  bool get isNew =>
      (agentNameDisplay.isEmpty &&
          agentReferralCodeDisplay.isEmpty &&
          agencyNameDisplay.isEmpty &&
          agentMobileNumberDisplay.isEmpty) ||
      this == null;
}

extension ClientWealthSourceExtension on ClientWealthSourceDetailsVo? {
  String get annualIncomeDeclarationDisplay =>
      this?.annualIncomeDeclaration ?? '';

  String get sourceOfIncomeDisplay => this?.sourceOfIncome ?? '';

  bool get isNew =>
      (annualIncomeDeclarationDisplay.isEmpty &&
          sourceOfIncomeDisplay.isEmpty) ||
      this == null;
}

extension ClientBeneficiaryExtension on IndividualBeneficiaryVo {
  Address get addressObject => Address(
        street: address ?? '',
        state: state ?? '',
        postCode: postcode ?? '',
        city: city ?? '',
        country: country ?? '',
      );
}

extension ClientGuardianExtension on GuardianVo? {
  String get nameDisplay => this?.fullName ?? '';

  String get icPassportDisplay => this?.icPassport ?? '';

  String get dobDisplay => this?.dob == null
      ? ''
      : DateFormat('dd MMMM yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(this!.dob!));

  String get genderDisplay => this?.gender ?? '';

  String get nationalityDisplay => this?.nationality ?? '';

  String get fullAddressDisplay =>
      '$addressDisplay, $postcodeDisplay, $cityDisplay, $stateDisplay, $countryDisplay';

  String get addressDisplay => this?.address ?? '';

  String get postcodeDisplay => this?.postcode ?? '';

  String get cityDisplay => this?.city ?? '';

  String get stateDisplay => this?.state ?? '';

  String get countryDisplay => this?.country ?? '';

  String get mobileNumberDisplay => this?.mobileNumber ?? '';

  String get mobileCountryCodeDisplay => this?.mobileCountryCode ?? '';

  String get fullMobileNumberDisplay =>
      '${this?.mobileCountryCode ?? ''} ${this?.mobileNumber ?? ''}';

  String get emailDisplay => this?.email ?? '';

  String get residentialStatusDisplay => this?.residentialStatus ?? '';

  String get maritalStatusDisplay => this?.maritalStatus ?? '';
}
