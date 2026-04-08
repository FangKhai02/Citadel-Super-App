import 'package:citadel_super_app/data/model/agent.dart';
import 'package:citadel_super_app/data/model/fund/beneficiary.dart';
import 'package:citadel_super_app/data/model/profile/employment.dart';
import 'package:citadel_super_app/data/model/profile/user.dart';
import 'package:citadel_super_app/data/model/profile/wealth_source.dart';

import '../fund/bank.dart';

class Profile {
  final User user;
  final Employment employment;
  final WealthSource wealthSource;
  final List<Bank> bankList;
  final List<Beneficiary> beneficiaryList;
  final Agent agent;

  Profile({
    User? user,
    Employment? employment,
    WealthSource? wealthSource,
    List<Bank>? bankList,
    List<Beneficiary>? beneficiaryList,
    Agent? agent,
  })  : user = user ?? User(),
        wealthSource = wealthSource ?? WealthSource(),
        employment = employment ?? Employment(),
        bankList = bankList ?? [],
        beneficiaryList = beneficiaryList ?? [],
        agent = agent ?? Agent();

  Profile copyWith({
    User? user,
    Employment? employment,
    WealthSource? wealthSource,
    List<Bank>? bankList,
    List<Beneficiary>? beneficiaryList,
    Agent? agent,
  }) {
    return Profile(
      user: user ?? this.user,
      employment: employment ?? this.employment,
      wealthSource: wealthSource ?? this.wealthSource,
      bankList: bankList ?? this.bankList,
      beneficiaryList: beneficiaryList ?? this.beneficiaryList,
      agent: agent ?? this.agent,
    );
  }

  Profile.fromJson(dynamic json)
      : user = User.fromJson(json),
        employment = Employment.fromJson(json),
        wealthSource = WealthSource.fromJson(json),
        bankList = (json['banks'] as List? ?? [])
            .map((e) => Bank.fromJson(e))
            .toList(),
        beneficiaryList = (json['beneficiaryList'] as List? ?? [])
            .map((e) => Beneficiary.fromJson(e))
            .toList(),
        agent = Agent.fromJson(json);
}
