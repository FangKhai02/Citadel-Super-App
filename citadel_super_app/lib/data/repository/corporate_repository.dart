import 'package:citadel_super_app/app_folder/app_url.dart';
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
import 'package:citadel_super_app/data/response/client_portfolio_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_bank_details_list_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_bank_details_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_beneficiaries_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_beneficiary_create_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_beneficiary_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_documents_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_profile_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_share_holder_response_vo.dart';
import 'package:citadel_super_app/data/response/corporate_shareholders_response_vo.dart';
import 'package:citadel_super_app/data/response/product_order_summary_response_vo.dart';
import 'package:citadel_super_app/data/response/transaction_response_vo.dart';
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
import 'package:citadel_super_app/domain/i_repository/i_corporate_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class CorporateRepository extends BaseWebService
    implements ICorporateRepository {
  @override
  Future<CorporateShareholderVo> createShareholder(
      CorporateShareholderRequestVo req, String referenceNumber) async {
    final json = await post(
        url: AppUrl.createShareholder(referenceNumber),
        parameter: req.toJson());
    return CorporateShareHolderResponseVo.fromJson(json).corporateShareholder ??
        CorporateShareholderVo();
  }

  @override
  Future<CorporateShareholderVo> editShareholder(
      CorporateShareholderEditRequestVo req, String referenceNumber) async {
    final json = await post(
        url: AppUrl.editShareholder(referenceNumber), parameter: req.toJson());
    return CorporateShareHolderResponseVo.fromJson(json).corporateShareholder ??
        CorporateShareholderVo();
  }

  @override
  Future<void> deleteShareholder(int id, String referenceNumber) async {
    await post(url: AppUrl.deleteShareholder(id, referenceNumber));
  }

  @override
  Future<void> addShareholderToCoporate(
      CorporateShareholderAddRequestVo req, String referenceNumber) async {
    await post(
        url: AppUrl.addShareholderToCoporate(referenceNumber),
        parameter: req.toJson());
  }

  @override
  Future<List<CorporateShareholderBaseVo>> getShareholders(
      String referenceNumber) async {
    final json = await get(url: AppUrl.getShareholders(referenceNumber));
    final response = CorporateShareholdersResponseVo.fromJson(json);

    final List<CorporateShareholderBaseVo> combinedShareholders = [
      ...(response.mappedShareholders ?? []),
      ...(response.draftShareholders ?? []),
    ];

    return combinedShareholders;
  }

  @override
  Future<CorporateShareholderVo> getShareholderById(
      int id, String referenceNumber) async {
    final json = await get(
      url: AppUrl.getShareholderById(id, referenceNumber),
    );
    return CorporateShareHolderResponseVo.fromJson(json).corporateShareholder ??
        CorporateShareholderVo();
  }

  @override
  Future<CorporateProfileResponseVo> getCorporateProfile(
      String? corporateClientId) async {
    final json = await get(url: AppUrl.getCorporateProfile(corporateClientId));
    return CorporateProfileResponseVo.fromJson(json);
  }

  @override
  Future<List<BankDetailsVo>> getCorporateBank(
      String? corporateClientId) async {
    final json = await get(url: AppUrl.getCorporateBank(corporateClientId));
    return CorporateBankDetailsListResponseVo.fromJson(json)
            .corporateBankDetails ??
        [];
  }

  @override
  Future<BankDetailsVo> getCorporateBankById(int? id) async {
    final json = await get(
      url: AppUrl.getCorporateBankById(id),
    );
    return CorporateBankDetailsResponseVo.fromJson(json)
            .corporateBankDetailsVo ??
        BankDetailsVo();
  }

  @override
  Future<void> createCorporate(String? referenceNumber,
      CorporateClientSignUpRequestVo req, bool isDraft) async {
    await post(
        url: AppUrl.createCorporate(referenceNumber, isDraft),
        parameter: req.toJson());
  }

  @override
  Future<void> updateCorporateProfileImage(String? base64Image) async {
    await post(url: AppUrl.corporateProfileImageEdit, parameter: {
      "profilePicture": base64Image,
    });
  }

  @override
  Future<void> createCorporateBank(
      CorporateBankDetailsRequestVo req, String? corporateClientId) async {
    await post(
        url: AppUrl.createCorporateBank(corporateClientId),
        parameter: req.toJson());
  }

  @override
  Future<void> editCorporateBank(
      CorporateBankDetailsEditRequestVo req, String? corporateClientId) async {
    await post(
        url: AppUrl.editCorporateBank(corporateClientId),
        parameter: req.toJson());
  }

  @override
  Future<void> deleteCorporateBank(int? id, String? corporateClientId) async {
    await post(url: AppUrl.deleteCorporateBank(id, corporateClientId));
  }

  @override
  Future<List<CorporateBeneficiaryBaseVo>> getCorporateBeneficiary(
      String? corporateClientId) async {
    final json =
        await get(url: AppUrl.getCorporateBeneficiary(corporateClientId));
    return CorporateBeneficiariesResponseVo.fromJson(json)
            .corporateBeneficiaries ??
        [];
  }

  @override
  Future<CorporateBeneficiaryVo> getCorporateBeneficiaryById(int? id,
      {String? corporateClientId}) async {
    final json = await get(
      url: AppUrl.getCorporateBeneficiaryById(id, corporateClientId),
    );
    return CorporateBeneficiaryResponseVo.fromJson(json).corporateBeneficiary ??
        CorporateBeneficiaryVo();
  }

  @override
  Future<CorporateBeneficiaryCreateResponseVo> createCorporateBeneficiary(
      CorporateBeneficiaryCreationRequestVo req,
      String? corporateClientId) async {
    final json = await post(
        url: AppUrl.createCorporateBenficiary(corporateClientId),
        parameter: req.toJson());
    return CorporateBeneficiaryCreateResponseVo.fromJson(json);
  }

  @override
  Future<void> editCorporateBeneficiary(CorporateBeneficiaryUpdateRequestVo req,
      int? id, String? corporateClientId) async {
    await post(
        url: AppUrl.editCorporateBenficiary(id,
            corporateClientId: corporateClientId),
        parameter: req.toJson());
  }

  Future<void> editCorporateBeneficiaryRelationshipToGuardian(
      String relationship, int? id) async {
    await post(
        url: AppUrl.editCorporateBenficiary(id),
        parameter: {"relationshipToGuardian": relationship});
  }

  @override
  Future<void> deleteCorporateBeneficiary(
      int? id, String? corporateClientId) async {
    await post(url: AppUrl.deleteCorporateBenficiary(id, corporateClientId));
  }

  @override
  Future<void> createCorporateGuardian(
      CorporateGuardianCreationRequestVo req, String? corporateClientId) async {
    await post(
        url: AppUrl.createCorporateGuardian(corporateClientId),
        parameter: req.toJson());
  }

  @override
  Future<void> editCorporateGuardian(CorporateGuardianUpdateRequestVo req,
      int? id, String? corporateClientId) async {
    await post(
        url: AppUrl.editCorporateGuardian(id, corporateClientId),
        parameter: req.toJson());
  }

  @override
  Future<void> deleteCorporateGuardian(
      int? id, String? corporateClientId) async {
    await post(url: AppUrl.deleteCorporateGuardian(id, corporateClientId));
  }

  @override
  Future<void> editCorporateWealthSource(
      String annualIncome, String sourceOfIncome) async {
    await post(url: AppUrl.editCorporateWealthSource, parameter: {
      "annualIncomeDeclaration": annualIncome,
      "sourceOfIncome": sourceOfIncome
    });
  }

  @override
  Future<void> editCorporateDetail(CorporateDetailsRequestVo req) async {
    await post(url: AppUrl.editCorporateDetail, parameter: req.toJson());
  }

  @override
  Future<PepDeclarationVo> editCorporateShareholderPep(
      PepDeclarationVo req, int? id, String referenceNumber) async {
    final json = await post(
        url: AppUrl.editCorporateShareholderPep(id, referenceNumber),
        parameter: req.toJson());
    return PepDeclarationVo.fromJson(json);
  }

  @override
  Future<List<CorporateDocumentsVo>> getCorporateDocuments(
      String referenceNumber) async {
    final json = await get(url: AppUrl.corporateDocuments(referenceNumber));
    return CorporateDocumentsResponseVo.fromJson(json).corporateDocuments ?? [];
  }

  @override
  Future<void> uploadCorporateDocuments(
      String referenceNumber, CorporateDocumentsRequestVo req) async {
    await post(
        url: AppUrl.corporateDocuments(referenceNumber),
        parameter: req.toJson());
  }

  @override
  Future<List<TransactionVo>> getCorporateTransaction(
      String corporateClientId) async {
    final json =
        await get(url: AppUrl.getCorporateTransaction(corporateClientId));
    return TransactionResponseVo.fromJson(json).transactions ?? [];
  }

  @override
  Future<List<ClientPortfolioVo>> getPortfolio(String corporateClientId) async {
    final json = await get(url: AppUrl.corporatePortfolio(corporateClientId));
    return ClientPortfolioResponseVo.fromJson(json).portfolio ?? [];
  }

  @override
  Future<ClientPortfolioProductDetailsResponseVo> getPortfolioDetail(
      String corporateClientId, String orderReferenceNumber) async {
    final json = await get(
        url: AppUrl.corporatePortfolioDetail(
            corporateClientId, orderReferenceNumber));
    return ClientPortfolioProductDetailsResponseVo.fromJson(json);
  }

  @override
  Future<ProductOrderSummaryResponseVo> purchaseProduct(
      ProductPurchaseRequestVo req,
      {String? referenceNumber}) async {
    final json = await post(
        url: AppUrl.corporatePurchaseFund(referenceNumber),
        parameter: req.toJson());
    return ProductOrderSummaryResponseVo.fromJson(json);
  }
}
