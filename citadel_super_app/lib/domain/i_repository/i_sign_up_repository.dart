import 'package:citadel_super_app/data/request/agent_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/response/existing_agent_response_vo.dart';
import 'package:citadel_super_app/data/response/existing_client_response_vo.dart';
import 'package:citadel_super_app/data/vo/client_identity_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_request_vo.dart';
import 'package:citadel_super_app/data/request/client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_contact_details_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_identity_details_vo.dart';

abstract class ISignUpRepository {
  Future<void> agentContactValidation(SignUpBaseContactDetailsVo req);
  Future<void> agentIdentityValidation(SignUpBaseIdentityDetailsVo req);
  Future<ExistingAgentResponseVo> checkExistingAgent(String idNumber);
  Future<void> agentSignUp(AgentSignUpRequestVo req);
  Future<void> clientIdentityValidation(ClientIdentityDetailsRequestVo req);
  Future<void> clientDetailsValidation(ClientPersonalDetailsRequestVo req);
  Future<void> clientSignUp(ClientSignUpRequestVo req);
  Future<ExistingClientResponseVo> checkExistingClient(String idNumber);
}
