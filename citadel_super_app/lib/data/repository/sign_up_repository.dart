import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/agent_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/response/existing_agent_response_vo.dart';
import 'package:citadel_super_app/data/response/existing_client_response_vo.dart';
import 'package:citadel_super_app/data/vo/client_identity_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_request_vo.dart';
import 'package:citadel_super_app/data/request/client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_contact_details_vo.dart';

import 'package:citadel_super_app/data/vo/sign_up_base_identity_details_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_sign_up_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class SignUpRepository extends BaseWebService implements ISignUpRepository {
  @override
  Future<void> agentContactValidation(SignUpBaseContactDetailsVo req) async {
    await post(url: AppUrl.agentContactValidation, parameter: req.toJson());
  }

  @override
  Future<void> agentIdentityValidation(SignUpBaseIdentityDetailsVo req) async {
    await post(url: AppUrl.agentIdentityValidation, parameter: req.toJson());
  }

  @override
  Future<ExistingAgentResponseVo> checkExistingAgent(String idNumber) async {
    final json = await get(url: AppUrl.agentSignUp(idNumber: idNumber));
    return ExistingAgentResponseVo.fromJson(json);
  }

  @override
  Future<void> agentSignUp(AgentSignUpRequestVo req) async {
    await post(url: AppUrl.agentSignUp(), parameter: req.toJson());
  }

  @override
  Future<void> clientDetailsValidation(
      ClientPersonalDetailsRequestVo req) async {
    await post(url: AppUrl.clientDetailsValidation, parameter: req.toJson());
  }

  @override
  Future<void> clientIdentityValidation(
      ClientIdentityDetailsRequestVo req) async {
    await post(url: AppUrl.clientIdentityValidation, parameter: req.toJson());
  }

  @override
  Future<void> clientSignUp(ClientSignUpRequestVo req) async {
    await post(url: AppUrl.clientSignUp, parameter: req.toJson());
  }

  @override
  Future<ExistingClientResponseVo> checkExistingClient(String idNumber) async {
    final json = await get(url: AppUrl.checkExistingClient(idNumber));
    return ExistingClientResponseVo.fromJson(json);
  }
}
