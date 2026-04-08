import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/response/agent_profile_response_vo.dart';

final agentProfileFutureProvider =
    FutureProvider.autoDispose<AgentProfileResponseVo>((ref) async {
  final AgentRepository agentRepository = AgentRepository();
  return agentRepository.getAgentProfile();
});
