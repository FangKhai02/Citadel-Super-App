import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/vo/agent_personal_details_vo.dart';
import 'package:intl/intl.dart';

extension AgentProfileExtension on AgentPersonalDetailsVo? {
  String get nameDisplay => this?.name ?? '';

  String get identityCardNumberDisplay => this?.identityCardNumber ?? '';

  String get dobDisplay => this?.dob == null
      ? ''
      : DateFormat('dd-MM-yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(this!.dob!));

  String get fullAddressDisplay =>
      '$addressDisplay, $postcodeDisplay, $cityDisplay, $stateDisplay, $countryDisplay';

  String get addressDisplay => this?.address ?? '';

  String get postcodeDisplay => this?.postcode ?? '';

  String get cityDisplay => this?.city ?? '';

  String get stateDisplay => this?.state ?? '';

  String get countryDisplay => this?.country ?? '';

  String get mobileNumberDisplay =>
      '${this?.mobileCountryCode ?? ''} ${this?.mobileNumber ?? ''}';

  String get fullMobileNumberDisplay =>
      '${this?.mobileCountryCode ?? ''}${this?.mobileNumber ?? ''}';

  String get emailDisplay => this?.email ?? '';

  bool get isNew =>
      (nameDisplay.isEmpty &&
          identityCardNumberDisplay.isEmpty &&
          this?.dob == null &&
          addressDisplay.isEmpty &&
          postcodeDisplay.isEmpty &&
          cityDisplay.isEmpty &&
          stateDisplay.isEmpty &&
          countryDisplay.isEmpty) ||
      this == null;

  Address get addressModel => Address(
        street: addressDisplay,
        postCode: postcodeDisplay,
        city: cityDisplay,
        state: stateDisplay,
        country: countryDisplay,
      );
}
