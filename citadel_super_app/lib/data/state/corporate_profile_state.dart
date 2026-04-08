import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/request/corporate_client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/response/corporate_profile_response_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
// ignore: unused_import
import 'package:citadel_super_app/data/vo/corporate_bank_details_base_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_documents_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_base_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final corporateProfileProvider = FutureProvider.autoDispose
    .family<CorporateProfileResponseVo, String?>(
        (ref, corporateClientId) async {
  final CorporateRepository corporateRepository = CorporateRepository();
  final result =
      await corporateRepository.getCorporateProfile(corporateClientId);

  // store reference number in state
  //if (result.corporateClient?.status != 'APPROVED') {
  final corporateRefNoti = ref.read(corporateRefProvider.notifier);
  corporateRefNoti.state = result.corporateClient?.referenceNumber ?? '';
  //}
  return result;
});

// Set ref key
final corporateRefProvider = StateProvider<String?>((ref) => null);

final corporateBankProvider = FutureProvider.autoDispose
    .family<List<BankDetailsVo>, String?>((ref, corporateClientId) async {
  final CorporateRepository corporateRepository = CorporateRepository();
  return corporateRepository.getCorporateBank(corporateClientId);
});

final corporateBeneficiaryProvider = FutureProvider.autoDispose
    .family<List<CorporateBeneficiaryBaseVo>, String?>(
        (ref, corporateClientId) async {
  final CorporateRepository corporateRepository = CorporateRepository();
  return corporateRepository.getCorporateBeneficiary(corporateClientId);
});

final shareholdersProvider =
    FutureProvider<List<CorporateShareholderBaseVo>>((ref) async {
  final CorporateRepository corporateRepository = CorporateRepository();
  final corporateRef = ref.read(corporateRefProvider);
  return corporateRepository.getShareholders(corporateRef!);
});

final corporateDocumentsProvider =
    FutureProvider<List<CorporateDocumentsVo>>((ref) {
  final CorporateRepository corporateRepository = CorporateRepository();
  final corporateRefState = ref.read(corporateRefProvider);
  return corporateRepository.getCorporateDocuments(corporateRefState ?? '');
});

final corporateSignUpProvider =
    StateProvider.autoDispose<CorporateClientSignUpRequestVo?>(
        (ref) => CorporateClientSignUpRequestVo());
