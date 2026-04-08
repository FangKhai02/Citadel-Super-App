import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';

extension NiuExtension on NiuGetApplicationDetailsVo? {
  String get applicationTypeDisplay => this?.applicationType ?? '';

  String get amountDisplay => this?.amountRequested == null
      ? ''
      : 'RM ${this!.amountRequested!.thousandSeparator()}';

  String get requestedDate => this?.requestedOn ?? '';

  bool get isPersonal =>
      (this?.applicationType ?? '').equalsIgnoreCase('personal');

  String get nameDisplay => this?.name ?? '';
  String get documentNumberDisplay => this?.documentNumber ?? '';
  String get fullAddressDisplay => this?.fullAddress ?? '';
  String get fullMobileNumberDisplay => this?.fullMobileNumber ?? '';
  String get emailDisplay => this?.email ?? '';
}
