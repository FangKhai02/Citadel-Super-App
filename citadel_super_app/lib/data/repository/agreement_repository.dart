import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/client_two_signature_request_vo.dart';
import 'package:citadel_super_app/data/request/onboarding_agreement_request_vo.dart';
import 'package:citadel_super_app/data/request/trust_fund_agreement_request_vo.dart';
import 'package:citadel_super_app/data/request/withdrawal_agreement_request_vo.dart';
import 'package:citadel_super_app/data/response/agreement_response_vo.dart';
import 'package:citadel_super_app/data/response/base_response.dart';
import 'package:citadel_super_app/domain/i_repository/i_agreement_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class AgreementRepository extends BaseWebService
    implements IAgreementRepository {
  @override
  Future<String?> onboardingAgreement(
      String agreementType, OnboardingAgreementRequestVo request) async {
    //agreementType constant : AGENT, CLIENT, GUEST, ADMIN, CORPORATE_CLIENT, MAIN_BENEFICIARY, SUB_BENEFICIARY

    final json = await post(
        url: AppUrl.onboardingAgreement(agreementType),
        parameter: request.toJson());
    return AgreementResponseVo.fromJson(json).link;
  }

  @override
  Future<String?> purchaseAgreement(String referenceNumber) async {
    final json = await get(
      url: AppUrl.purchaseAgreement(referenceNumber),
    );
    return AgreementResponseVo.fromJson(json).link;
  }

  @override
  Future<void> updatePurchaseAgreement(
      String referenceNumber, String digitalSignature,
      {String? fullName, String? userId, String? role}) async {
    await post(
        url: AppUrl.purchaseAgreement(referenceNumber),
        parameter: TrustFundAgreementRequestVo(
                digitalSignature: digitalSignature,
                fullName: fullName,
                identityCardNumber: userId,
                role: role)
            .toJson());
  }

  @override
  Future<String?> earlyRedemptionAgreement(String referenceNumber) async {
    final json = await get(
      url: AppUrl.earlyRedemptionAgreement(referenceNumber),
    );
    return AgreementResponseVo.fromJson(json).link;
  }

  @override
  Future<void> submitEarlyRedemptionAgreement(
      String referenceNumber, String digitalSignature,
      {String? fullName, String? userId}) async {
    await post(
        url: AppUrl.earlyRedemptionAgreement(referenceNumber),
        parameter: WithdrawalAgreementRequestVo(
                digitalSignature: digitalSignature,
                fullName: fullName,
                identityCardNumber: userId)
            .toJson());
  }

  @override
  Future<void> verifyAgreementWitness(
      String referenceNumber, String digitalSignature,
      {String? fullName, String? userId}) async {
    await post(
        url: AppUrl.verifyAgreementWitness(referenceNumber),
        parameter: TrustFundAgreementRequestVo(
                digitalSignature: digitalSignature,
                fullName: fullName,
                identityCardNumber: userId)
            .toJson());
  }

  @override
  Future<String?> getSecondSigneeAgreementLink(String referenceNumber) async {
    final json = await get(
      url: AppUrl.getSecondSigneeAgreementLink(referenceNumber),
    );
    return AgreementResponseVo.fromJson(json).link;
  }

  @override
  Future<String?> getSecondSigneeAgreement(String identificationNumber) async {
    final json = await get(
      url: AppUrl.secondSigneeAgreement(
          identificationNumber: identificationNumber),
    );
    return AgreementResponseVo.fromJson(json).link;
  }

  @override
  Future<void> submitSecondSigneeAgreement(
      String identificationNumber, String digitalSignature,
      {String? fullName, String? userId, String? role}) async {
    await post(
        url: AppUrl.secondSigneeAgreement(),
        parameter: ClientTwoSignatureRequestVo(
                uniqueIdentifier: identificationNumber,
                signatureImage: digitalSignature,
                name: fullName,
                idNumber: userId,
                role: role)
            .toJson());
  }
}
