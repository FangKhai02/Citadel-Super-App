import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';

class CorporateBeneficiaryDistribution {
  List<CorporateBeneficiaryBaseVo>? beneficiary;
  List<double>? percentage;
  List<CorporateBeneficiaryBaseVo>? subBeneficiary;
  List<double>? subpercentage;

  CorporateBeneficiaryDistribution(
      {this.beneficiary,
      this.percentage,
      this.subBeneficiary,
      this.subpercentage});

  CorporateBeneficiaryDistribution copyWith(
      {List<CorporateBeneficiaryBaseVo>? beneficiary,
      List<double>? percentage,
      List<CorporateBeneficiaryBaseVo>? subBeneficiary,
      List<double>? subpercentage}) {
    return CorporateBeneficiaryDistribution(
        beneficiary: beneficiary ?? this.beneficiary,
        percentage: percentage ?? this.percentage,
        subBeneficiary: subBeneficiary ?? this.subBeneficiary,
        subpercentage: subpercentage ?? this.subpercentage);
  }
}
