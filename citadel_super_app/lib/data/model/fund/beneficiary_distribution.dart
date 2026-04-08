import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';

class BeneficiaryDistribution {
  List<IndividualBeneficiaryVo>? beneficiary;
  List<double>? percentage;
  List<IndividualBeneficiaryVo>? subBeneficiary;
  List<double>? subpercentage;

  BeneficiaryDistribution(
      {this.beneficiary,
      this.percentage,
      this.subBeneficiary,
      this.subpercentage});

  BeneficiaryDistribution copyWith(
      {List<IndividualBeneficiaryVo>? beneficiary,
      List<double>? percentage,
      List<IndividualBeneficiaryVo>? subBeneficiary,
      List<double>? subpercentage}) {
    return BeneficiaryDistribution(
        beneficiary: beneficiary ?? this.beneficiary,
        percentage: percentage ?? this.percentage,
        subBeneficiary: subBeneficiary ?? this.subBeneficiary,
        subpercentage: subpercentage ?? this.subpercentage);
  }
}
