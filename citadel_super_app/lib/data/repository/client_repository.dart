import 'package:citadel_super_app/app_folder/app_enum.dart';
import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/beneficiary_guardian_relationship_update_request_vo.dart';
import 'package:citadel_super_app/data/request/client_pin_request_vo.dart';
import 'package:citadel_super_app/data/request/client_profile_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_beneficiary_create_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_beneficiary_update_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_guardian_create_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_guardian_update_request_vo.dart';
import 'package:citadel_super_app/data/response/client_beneficiary_guardian_response_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_response_vo.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/response/client_secure_tag_response_vo.dart';
import 'package:citadel_super_app/data/response/individual_beneficiary_response_vo.dart';
import 'package:citadel_super_app/data/response/transaction_response_vo.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/data/vo/client_secure_tag_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

import '../../domain/i_repository/i_client_repository.dart';
import '../vo/individual_beneficiary_vo.dart';

class ClientRepository extends BaseWebService implements IClientRepository {
  @override
  Future<ClientProfileResponseVo> getProfile({String? clientId}) async {
    final json = await get(url: AppUrl.clientProfile(clientId));
    return ClientProfileResponseVo.fromJson(json);
  }

  @override
  Future<List<IndividualBeneficiaryVo>> getBeneficiaries(
      String? clientId) async {
    final json = await get(url: AppUrl.clientBeneficiaries(clientId));
    return ClientBeneficiaryGuardianResponseVo.fromJson(json).beneficiaries ??
        [];
  }

  @override
  Future<void> deleteBeneficiary(int? id, {String? clientId}) async {
    await post(url: AppUrl.clientBeneficiaryDelete(id, clientId));
  }

  @override
  Future<void> updateBeneficiary(
      IndividualBeneficiaryUpdateRequestVo req, int? id,
      {String? clientId}) async {
    await post(
        url: AppUrl.clientBeneficiaryEdit(id, clientId),
        parameter: req.toJson());
  }

  @override
  Future<IndividualBeneficiaryResponseVo> createBeneficiary(
      IndividualBeneficiaryCreateRequestVo req,
      {String? clientId}) async {
    final json = await post(
        url: AppUrl.clientBeneficiaryCreate(clientId), parameter: req.toJson());
    return IndividualBeneficiaryResponseVo.fromJson(json);
  }

  @override
  Future<List<ClientPortfolioVo>> getPortfolio() async {
    final json = await get(url: AppUrl.clientPortfolio);
    return ClientPortfolioResponseVo.fromJson(json).portfolio ?? [];
  }

  @override
  Future<ClientPortfolioProductDetailsResponseVo> getPortfolioDetail(
      ClientPortfolioReference reference) async {
    final json = await get(url: AppUrl.clientPortfolioDetail(reference));
    return ClientPortfolioProductDetailsResponseVo.fromJson(json);
  }

  @override
  Future<void> createGuardian(
      IndividualGuardianCreateRequestVo req, String? clientId) async {
    await post(
        url: AppUrl.clientGuardianCreate(clientId), parameter: req.toJson());
  }

  @override
  Future<void> updateProfile(ClientProfileEditRequestVo req) async {
    await post(url: AppUrl.clientProfileEdit, parameter: req.toJson());
  }

  @override
  Future<void> updateProfileImage(String? base64Image) async {
    await post(url: AppUrl.clientProfileImageEdit, parameter: {
      "profilePicture": base64Image,
    });
  }

  @override
  Future<ClientSecureTagVo?> getSecureTag() async {
    final json = await get(url: AppUrl.clientSecureTag);
    return ClientSecureTagResponseVo.fromJson(json).secureTag;
  }

  @override
  Future<void> performActionSecureTag(SecureTagAction action) async {
    await get(url: AppUrl.clientSecureTagConsent(action));
  }

  @override
  Future<void> registerPin(ClientPinRequestVo clientPinRequestVo) async {
    await post(url: AppUrl.clientPin, parameter: clientPinRequestVo.toJson());
  }

  @override
  Future<void> updatePin(ClientPinRequestVo clientPinRequestVo) async {
    await post(url: AppUrl.clientPin, parameter: clientPinRequestVo.toJson());
  }

  @override
  Future<void> validatePin(ClientPinRequestVo clientPinRequestVo) async {
    await post(url: AppUrl.clientPin, parameter: clientPinRequestVo.toJson());
  }

  @override
  Future<void> editGuardian(
      int? id,
      IndividualGuardianUpdateRequestVo individualGuardianUpdateRequestVo,
      String? clientId) async {
    await post(
        url: AppUrl.clientGuardianEdit(id, clientId: clientId),
        parameter: individualGuardianUpdateRequestVo.toJson());
  }

  @override
  Future<void> deleteGuardian(int? id, String? clientId) async {
    await post(url: AppUrl.clientGuardianDelete(id, clientId: clientId));
  }

  @override
  Future<void> editProfile(
      ClientProfileEditRequestVo clientProfileEditRequestVo) async {
    await post(
        url: AppUrl.clientProfileEdit,
        parameter: clientProfileEditRequestVo.toJson());
  }

  @override
  Future<void> updateGuardianRelationship(
      BeneficiaryGuardianRelationshipUpdateRequestVo req) async {
    await post(
        url: AppUrl.clientGuardianRelationshipUpdate, parameter: req.toJson());
  }

  @override
  Future<void> editClientPep(PepDeclarationVo clientPepEditRequest) async {
    await post(
        url: AppUrl.clientPepEdit, parameter: clientPepEditRequest.toJson());
  }

  @override
  Future<List<TransactionVo>> getClientTransaction() async {
    final json = await get(url: AppUrl.getClientTransaction);
    return TransactionResponseVo.fromJson(json).transactions ?? [];
  }
}
