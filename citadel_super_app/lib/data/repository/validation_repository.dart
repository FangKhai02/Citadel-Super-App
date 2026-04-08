import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/response/corporate_director_response_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_client_user_details_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_client_validate_two_request_vo.dart';
import 'package:citadel_super_app/data/vo/employment_details_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_validation_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class ValidationRepository extends BaseWebService
    implements IValidationRepository {
  @override
  Future<void> pepValidation(PepDeclarationVo req) async {
    await post(url: AppUrl.pepValidation, parameter: req.toJson());
  }

  @override
  Future<void> employmentDetailsValidation(EmploymentDetailsVo req) async {
    await post(url: AppUrl.employmentDetailValidation, parameter: req.toJson());
  }

  @override
  Future<void> bankDetailsValidation(BankDetailsRequestVo req) async {
    await post(url: AppUrl.bankDetailsValidation, parameter: req.toJson());
  }

  @override
  Future<void> userDetailsValidation(
      CorporateClientUserDetailsRequestVo req) async {
    await post(url: AppUrl.userDetailsValidation, parameter: req.toJson());
  }

  @override
  Future<void> corporateDetailsValidation(CorporateDetailsRequestVo req) async {
    await post(url: AppUrl.corporateDetailsValidation, parameter: req.toJson());
  }

  @override
  Future<void> shareholderDetailsValidation(
      CorporateShareholderRequestVo req) async {
    await post(
        url: AppUrl.shareholderDetailsValidation, parameter: req.toJson());
  }

  @override
  Future<void> shareholderPercentageValidation(List<int> shareholderIds) async {
    await post(
        url: AppUrl.shareholdersPercentageValidation,
        parameter: {"shareHolderIds": shareholderIds});
  }

  @override
  Future<void> corporateDocValidation(
      CorporateClientValidateTwoRequestVo req) async {
    await post(url: AppUrl.corporateDocValidation, parameter: req.toJson());
  }

  @override
  Future<CorporateDirectorResponseVo> corporateDirectorIdentityValidation(
      String identityCardNumber) async {
    final json = await post(
        url: AppUrl.corporateDirectorIdentityValidation(identityCardNumber));
    return CorporateDirectorResponseVo.fromJson(json);
  }

  @override
  Future<void> editCorporateDetailsValidation(
      CorporateDetailsRequestVo req) async {
    await post(
        url: AppUrl.editCorporateDetailsValidation, parameter: req.toJson());
  }

  @override
  Future<void> recruitmentManagerValidation(
      String agencyId, String recruitmentManagerCode) async {
    await post(
        url: AppUrl.recruitmentManagerValidation(
            agencyId, recruitmentManagerCode));
  }
}
