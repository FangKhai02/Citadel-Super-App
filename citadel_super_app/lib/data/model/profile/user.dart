import 'package:citadel_super_app/data/model/address.dart';
import 'package:intl/intl.dart';

class User {
  final String name;
  final String myKadNumber;
  final int? dob;
  final String gender;
  final String nationality;
  final Address address;
  final String residentialStatus;
  final String maritalStatus;
  final String mobileNumber;
  final String email;
  final String agentReferralCode;
  final String profileImage;

  bool get isEmpty =>
      name.isEmpty &&
      myKadNumber.isEmpty &&
      dob == null &&
      gender.isEmpty &&
      nationality.isEmpty &&
      address.isEmpty &&
      residentialStatus.isEmpty &&
      maritalStatus.isEmpty &&
      mobileNumber.isEmpty &&
      email.isEmpty &&
      agentReferralCode.isEmpty &&
      profileImage.isEmpty;

  String get dobDisplay => dob == null
      ? ''
      : DateFormat('yyyy MMMM dd')
          .format(DateTime.fromMillisecondsSinceEpoch(dob!));

  User({
    this.name = '',
    this.myKadNumber = '',
    this.dob,
    this.gender = '',
    this.nationality = '',
    this.address = const Address(),
    this.residentialStatus = '',
    this.maritalStatus = '',
    this.mobileNumber = '',
    this.email = '',
    this.agentReferralCode = '',
    this.profileImage = '',
  });

  User.fromJson(dynamic json)
      : name = json['name'] ?? '',
        myKadNumber = json['myKadNumber'] ?? '',
        dob = json['dob'] as int?,
        gender = json['gender'] ?? '',
        nationality = json['nationality'] ?? '',
        address = Address.fromJson(json ?? {}),
        residentialStatus = json['residentialStatus'] ?? '',
        maritalStatus = json['maritalStatus'] ?? '',
        mobileNumber = json['mobileNumber'] ?? '',
        email = json['email'] ?? '',
        agentReferralCode = json['agentReferralCode'] ?? '',
        profileImage = json['profileImage'] ?? '';
}
