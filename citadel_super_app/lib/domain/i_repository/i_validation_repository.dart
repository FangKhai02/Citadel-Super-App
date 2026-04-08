import 'package:citadel_super_app/data/response/corporate_director_response_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_details_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_client_validate_two_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_request_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_client_user_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/employment_details_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';

abstract class IValidationRepository {
  Future<void> pepValidation(PepDeclarationVo req);
  Future<void> employmentDetailsValidation(EmploymentDetailsVo req);
  Future<void> bankDetailsValidation(BankDetailsRequestVo req);
  Future<void> userDetailsValidation(CorporateClientUserDetailsRequestVo req);
  Future<void> corporateDetailsValidation(CorporateDetailsRequestVo req);
  Future<void> shareholderDetailsValidation(CorporateShareholderRequestVo req);
  Future<void> shareholderPercentageValidation(List<int> shareholderIds);
  Future<void> corporateDocValidation(CorporateClientValidateTwoRequestVo req);
  Future<CorporateDirectorResponseVo> corporateDirectorIdentityValidation(
      String identityCardNumber);
  Future<void> editCorporateDetailsValidation(CorporateDetailsRequestVo req);
  Future<void> recruitmentManagerValidation(
      String agencyId, String recruitmentManagerCode);
}
