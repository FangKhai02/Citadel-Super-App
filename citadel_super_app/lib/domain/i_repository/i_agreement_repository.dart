import 'package:citadel_super_app/data/request/onboarding_agreement_request_vo.dart';

abstract class IAgreementRepository {
  Future<String?> onboardingAgreement(
      String agreementType, OnboardingAgreementRequestVo request);

  Future<String?> purchaseAgreement(String referenceNumber);

  Future<void> updatePurchaseAgreement(
      String referenceNumber, String digitalSignature);

  Future<String?> earlyRedemptionAgreement(String referenceNumber);

  Future<void> submitEarlyRedemptionAgreement(
      String referenceNumbe, String digitalSignature);

  Future<void> verifyAgreementWitness(
      String referenceNumber, String digitalSignature,
      {String? fullName, String? userId});

  Future<String?> getSecondSigneeAgreementLink(String referenceNumber);

  Future<String?> getSecondSigneeAgreement(String identificationNumber);

  Future<void> submitSecondSigneeAgreement(
      String identificationNumber, String digitalSignature,
      {String? fullName, String? userId, String? role});
}
