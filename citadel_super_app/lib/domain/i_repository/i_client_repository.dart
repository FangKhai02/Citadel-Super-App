import 'package:citadel_super_app/data/request/beneficiary_guardian_relationship_update_request_vo.dart';
import 'package:citadel_super_app/data/request/client_profile_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/client_pin_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_beneficiary_create_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_beneficiary_update_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_guardian_create_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_guardian_update_request_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import '../../app_folder/app_enum.dart';
import '../../data/response/client_profile_response_vo.dart';
import '../../data/vo/client_secure_tag_vo.dart';
import '../../data/vo/individual_beneficiary_vo.dart';

abstract class IClientRepository {
  Future<ClientProfileResponseVo> getProfile();

  Future<void> updateProfile(ClientProfileEditRequestVo req);

  Future<void> updateProfileImage(String base64Image);

  Future<List<IndividualBeneficiaryVo>> getBeneficiaries(String? clientId);

  Future<void> createBeneficiary(IndividualBeneficiaryCreateRequestVo req);

  Future<void> updateBeneficiary(
      IndividualBeneficiaryUpdateRequestVo req, int? id);

  Future<void> deleteBeneficiary(int id);

  Future<List<ClientPortfolioVo>> getPortfolio();

  Future<ClientPortfolioProductDetailsResponseVo> getPortfolioDetail(
      ClientPortfolioReference reference);

  Future<void> createGuardian(
      IndividualGuardianCreateRequestVo req, String? clientId);

  Future<ClientSecureTagVo?> getSecureTag();

  /// ACTION REJECT / APPROVE
  Future<void> performActionSecureTag(SecureTagAction action);

  Future<void> registerPin(ClientPinRequestVo req);

  Future<void> updatePin(ClientPinRequestVo req);

  Future<void> validatePin(ClientPinRequestVo req);

  Future<void> editGuardian(
      int? id,
      IndividualGuardianUpdateRequestVo individualGuardianUpdateRequestVo,
      String? clientId);

  Future<void> deleteGuardian(int? id, String? clientId);

  Future<void> editProfile(
      ClientProfileEditRequestVo clientProfileEditRequestVo);

  Future<void> updateGuardianRelationship(
      BeneficiaryGuardianRelationshipUpdateRequestVo req);

  Future<void> editClientPep(PepDeclarationVo clientPepEditRequest);

  Future<List<TransactionVo>> getClientTransaction();
}
