import 'package:citadel_super_app/data/response/existing_agent_response_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final existingAgentProvider =
    StateNotifierProvider<ExistingAgentState, ExistingAgentResponseVo?>((ref) {
  return ExistingAgentState();
});

class ExistingAgentState extends StateNotifier<ExistingAgentResponseVo?> {
  ExistingAgentState() : super(null);

  void setExistingClient(ExistingAgentResponseVo existingClientResponseVo) {
    state = existingClientResponseVo;
  }
}
