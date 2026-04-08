import 'package:citadel_super_app/data/request/corporate_bank_details_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_bank_details_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_beneficiary_creation_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_beneficiary_update_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_documents_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_guardian_creation_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_guardian_update_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_add_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_request_vo.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_beneficiary_create_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_profile_response_vo.dart';
import 'package:citadel_super_app/data/response/product_order_summary_response_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_documents_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_base_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';

abstract class ICorporateRepository {
  Future<CorporateShareholderVo> createShareholder(
      CorporateShareholderRequestVo req, String referenceNumber);

  Future<CorporateShareholderVo> editShareholder(
      CorporateShareholderEditRequestVo req, String referenceNumber);

  Future<void> deleteShareholder(int id, String referenceNumber);

  Future<void> addShareholderToCoporate(
      CorporateShareholderAddRequestVo req, String referenceNumber);

  Future<List<CorporateShareholderBaseVo>> getShareholders(
      String referenceNumber);

  Future<CorporateShareholderVo> getShareholderById(
      int id, String referenceNumber);

  Future<CorporateProfileResponseVo> getCorporateProfile(
      String? corporateClientId);

  Future<List<BankDetailsVo>> getCorporateBank(String? corporateClientId);

  Future<BankDetailsVo> getCorporateBankById(int id);

  Future<void> createCorporate(String? referenceNumber,
      CorporateClientSignUpRequestVo req, bool isDraft);

  Future<void> updateCorporateProfileImage(String? base64Image);

  Future<void> createCorporateBank(
      CorporateBankDetailsRequestVo req, String? corporateClientId);

  Future<void> editCorporateBank(
      CorporateBankDetailsEditRequestVo req, String? corporateClientId);

  Future<void> deleteCorporateBank(int? id, String? corporateClientId);

  Future<List<CorporateBeneficiaryBaseVo>> getCorporateBeneficiary(
      String? corporateClientId);

  Future<CorporateBeneficiaryVo> getCorporateBeneficiaryById(int? id,
      {String? corporateClientId});

  Future<CorporateBeneficiaryCreateResponseVo> createCorporateBeneficiary(
      CorporateBeneficiaryCreationRequestVo req, String? corporateClientId);

  Future<void> editCorporateBeneficiary(CorporateBeneficiaryUpdateRequestVo req,
      int? id, String? corporateClientId);

  Future<void> deleteCorporateBeneficiary(int? id, String? corporateClientId);

  Future<void> createCorporateGuardian(
      CorporateGuardianCreationRequestVo req, String? corporateClientId);

  Future<void> editCorporateGuardian(
      CorporateGuardianUpdateRequestVo req, int? id, String? corporateClientId);

  Future<void> deleteCorporateGuardian(int? id, String? corporateClientId);

  Future<void> editCorporateWealthSource(
      String annualIncome, String sourceOfIncome);

  Future<void> editCorporateDetail(CorporateDetailsRequestVo req);

  Future<PepDeclarationVo> editCorporateShareholderPep(
      PepDeclarationVo req, int? id, String referenceNumber);

  Future<List<CorporateDocumentsVo>> getCorporateDocuments(
      String referenceNumber);

  Future<void> uploadCorporateDocuments(
      String referenceNumber, CorporateDocumentsRequestVo req);

  Future<List<ClientPortfolioVo>> getPortfolio(String referenceNumber);

  Future<ClientPortfolioProductDetailsResponseVo> getPortfolioDetail(
      String reference, String orderReferenceNumber);

  Future<List<TransactionVo>> getCorporateTransaction(String referenceNumber);

  Future<ProductOrderSummaryResponseVo> purchaseProduct(
      ProductPurchaseRequestVo req,
      {String? referenceNumber});
}
