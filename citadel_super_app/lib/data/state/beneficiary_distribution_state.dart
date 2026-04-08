import 'package:citadel_super_app/data/model/fund/beneficiary_distribution.dart';
import 'package:citadel_super_app/data/model/fund/corporate_beneficiary_distribution.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final beneficiaryDistributionProvider = StateNotifierProvider.autoDispose<
    BeneficiaryDistributionState, BeneficiaryDistribution>((ref) {
  return BeneficiaryDistributionState();
});

class BeneficiaryDistributionState
    extends StateNotifier<BeneficiaryDistribution> {
  BeneficiaryDistributionState() : super(BeneficiaryDistribution());

  void setSelectedBeneficiaries(
      List<IndividualBeneficiaryVo> selectedBeneficiaries) {
    state = state.copyWith(beneficiary: selectedBeneficiaries);
  }

  void setSelectedDistribution(List<double> percentages) {
    state = state.copyWith(percentage: percentages);
  }

  void setSelectedSubBeneficiaries(
      List<IndividualBeneficiaryVo> selectedSubBeneficiaries) {
    state = state.copyWith(subBeneficiary: selectedSubBeneficiaries);
  }

  void setSelectedSubDistribution(List<double> subpercentages) {
    state = state.copyWith(subpercentage: subpercentages);
  }
}

final corporateBeneficiaryDistributionProvider =
    StateNotifierProvider.autoDispose<CorporateBeneficiaryDistributionState,
        CorporateBeneficiaryDistribution>((ref) {
  return CorporateBeneficiaryDistributionState();
});

class CorporateBeneficiaryDistributionState
    extends StateNotifier<CorporateBeneficiaryDistribution> {
  CorporateBeneficiaryDistributionState()
      : super(CorporateBeneficiaryDistribution());

  void setSelectedBeneficiaries(
      List<CorporateBeneficiaryBaseVo> selectedBeneficiaries) {
    state = state.copyWith(beneficiary: selectedBeneficiaries);
  }

  void setSelectedDistribution(List<double> percentages) {
    state = state.copyWith(percentage: percentages);
  }

  void setSelectedSubBeneficiaries(
      List<CorporateBeneficiaryBaseVo> selectedSubBeneficiaries) {
    state = state.copyWith(subBeneficiary: selectedSubBeneficiaries);
  }

  void setSelectedSubDistribution(List<double> subpercentages) {
    state = state.copyWith(subpercentage: subpercentages);
  }
}
