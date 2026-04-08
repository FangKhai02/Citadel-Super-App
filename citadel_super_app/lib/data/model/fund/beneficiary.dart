import 'package:citadel_super_app/data/model/address.dart';

import '../profile/user.dart';

class Beneficiary extends User {
  final String? relationship;
  final int? userId;
  int? percentage;
  final Beneficiary? guardian;

  Beneficiary({
    this.relationship,
    this.percentage,
    this.guardian,
    this.userId,
    super.name,
    super.myKadNumber,
    super.dob,
    super.gender,
    super.nationality,
    super.address,
    super.residentialStatus,
    super.maritalStatus,
    super.mobileNumber,
    super.email,
    super.agentReferralCode,
    super.profileImage,
  });

  Beneficiary copyWith({
    String? relationship,
    int? percentage,
    Beneficiary? guardian,
    int? userId,
    String? name,
    String? myKadNumber,
    int? dob,
    String? gender,
    String? nationality,
    Address? address,
    String? residentialStatus,
    String? maritalStatus,
    String? mobileNumber,
    String? email,
    String? agentReferralCode,
    String? profileImage,
  }) {
    return Beneficiary(
      relationship: relationship ?? this.relationship,
      percentage: percentage ?? this.percentage,
      guardian: guardian ?? this.guardian,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      myKadNumber: myKadNumber ?? this.myKadNumber,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      address: address ?? this.address,
      residentialStatus: residentialStatus ?? this.residentialStatus,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      agentReferralCode: agentReferralCode ?? this.agentReferralCode,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Beneficiary.fromJson(super.json)
      : relationship = json['relationship'] ?? '',
        percentage = json['percentage'] as int?,
        guardian = json['guardian'] != null
            ? Beneficiary.fromJson(json['guardian'])
            : null,
        userId = json['userId'] as int?,
        super.fromJson();
}
