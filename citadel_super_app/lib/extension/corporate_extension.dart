import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_client_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_details_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_guardian_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_base_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_vo.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:intl/intl.dart';

extension CoporateShareholderExtension on CorporateShareholderVo {
  Address get shareholderAddressObject => Address(
        street: address ?? '',
        state: state ?? '',
        postCode: postcode ?? '',
        city: city ?? '',
        country: country ?? '',
      );
}

extension CorporateGuardianExtension on CorporateBeneficiaryVo {
  Address get addressObject => Address(
        street: address ?? '',
        state: state ?? '',
        postCode: postcode ?? '',
        city: city ?? '',
        country: country ?? '',
      );
}

extension CorporateDetailExtension on CorporateDetailsVo {
  Address get registeredAddressObject => Address(
        street: registeredAddress ?? '',
        state: state ?? '',
        postCode: postcode ?? '',
        city: city ?? '',
        country: country ?? '',
      );

  Address get businessAddressObject => Address(
        street: corporateAddressDetails?.businessAddress ?? '',
        state: corporateAddressDetails?.businessState ?? '',
        postCode: corporateAddressDetails?.businessPostcode ?? '',
        city: corporateAddressDetails?.businessCity ?? '',
        country: corporateAddressDetails?.businessCountry ?? '',
      );
}

extension CorporateClientExtension on CorporateClientVo? {
  String get profilePictureDisplay => this?.profilePicture ?? '';

  String get nameDisplay => this?.name ?? '';

  String get identityCardNumberDisplay => this?.identityCardNumber ?? '';

  String get dobDisplay => this?.dob == null
      ? ''
      : DateFormat('dd MMMM yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(this!.dob!));

  String get fullAddressDisplay =>
      '$addressDisplay, $postcodeDisplay, $cityDisplay, $stateDisplay, $countryDisplay';

  String get addressDisplay => this?.address ?? '';

  String get postcodeDisplay => this?.postcode ?? '';

  String get cityDisplay => this?.city ?? '';

  String get stateDisplay => this?.state ?? '';

  String get countryDisplay => this?.country ?? '';

  String get fullMobileDisplay =>
      '$mobileCountryCodeDisplay $mobileNumberDisplay';

  String get mobileCountryCodeDisplay => this?.mobileCountryCode ?? '';

  String get mobileNumberDisplay => this?.mobileNumber ?? '';

  String get emailDisplay => this?.email ?? '';

  String get annualIncomeDeclarationDisplay =>
      this?.annualIncomeDeclaration ?? '';

  String get sourceofIncomeDisplay => this?.sourceOfIncome ?? '';
}

extension CorporateDetailsExtension on CorporateDetailsVo? {
  String get entityNameDisplay => this?.entityName ?? '';

  String get entityTypeDisplay => this?.entityType ?? '';

  String get registrationNumberDisplay => this?.registrationNumber ?? '';

  String get dateIncorporateDisplay => this?.dateIncorporate == null
      ? ''
      : DateFormat('dd MMMM yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(this!.dateIncorporate!));

  String get placeIncorporateDisplay => this?.placeIncorporate ?? '';

  String get businessTypeDisplay => this?.businessType ?? '';

  String get fullRegisteredAddressDisplay =>
      '$registeredAddressDisplay, $postcodeDisplay, $cityDisplay, ${stateDisplay.toCamelCase()}, $countryDisplay';

  String get registeredAddressDisplay => this?.registeredAddress ?? '';

  String get cityDisplay => this?.city ?? '';

  String get stateDisplay => this?.state ?? '';

  String get postcodeDisplay => this?.postcode ?? '';

  String get countryDisplay => this?.country ?? '';

  String get fullBusinessAddressDisplay =>
      '$businessAddressDisplay, $businessPostcodeDisplay, $businessCityDisplay, ${businessStateDisplay.toCamelCase()}, $businessCountryDisplay';

  String get businessAddressDisplay =>
      this?.corporateAddressDetails?.businessAddress ?? '';

  String get businessPostcodeDisplay =>
      this?.corporateAddressDetails?.businessPostcode ?? '';

  String get businessCityDisplay =>
      this?.corporateAddressDetails?.businessCity ?? '';

  String get businessStateDisplay =>
      this?.corporateAddressDetails?.businessState ?? '';

  String get businessCountryDisplay =>
      this?.corporateAddressDetails?.businessCountry ?? '';

  String get contactNameDisplay => this?.contactName ?? '';

  String get contactDesignationDisplay => this?.contactDesignation ?? '';

  String get fullMobileDisplay =>
      '$contactCountryCodeDisplay $contactMobileNumberDisplay';

  String get contactCountryCodeDisplay => this?.contactCountryCode ?? '';

  String get contactMobileNumberDisplay => this?.contactMobileNumber ?? '';

  String get contactEmailDisplay => this?.contactEmail ?? '';
}

extension ShareholderExtension on CorporateShareholderBaseVo? {
  String get nameDisplay => this?.name ?? '';

  String get percentageOfShareholdings =>
      this?.percentageOfShareholdings.toString() ?? '';
}

extension ShareholderDetailsExtension on CorporateShareholderVo? {
  String get nameDisplay => this?.name ?? '';

  String get percentageOfShareholdings =>
      this?.percentageOfShareholdings.toString() ?? '';

  String get mobileCountryCodeDisplay => this?.mobileCountryCode ?? '';

  String get mobileNumberDisplay => this?.mobileNumber ?? '';

  String get emailDisplay => this?.email ?? '';

  String get fullAddressDisplay =>
      '$addressDisplay, $postcodeDisplay, $cityDisplay, $stateDisplay, $countryDisplay';

  String get addressDisplay => this?.address ?? '';

  String get postcodeDisplay => this?.postcode ?? '';

  String get cityDisplay => this?.city ?? '';

  String get stateDisplay => this?.state ?? '';

  String get countryDisplay => this?.country ?? '';
}

extension GuardianDetailExtension on CorporateGuardianVo? {
  String get nameDisplay => this?.fullName ?? '';

  String get identityCardNumberDisplay => this?.identityCardNumber ?? '';

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

  String get fullMobileDisplay =>
      '$mobileCountryCodeDisplay $mobileNumberDisplay';

  String get mobileCountryCodeDisplay => this?.mobileCountryCode ?? '';

  String get mobileNumberDisplay => this?.mobileNumber ?? '';

  String get emailDisplay => this?.email ?? '';

  String get residentialStatusDisplay => this?.residentialStatus ?? '';

  String get maritalStatusDisplay => this?.maritalStatus ?? '';
}
