import 'package:citadel_super_app/data/response/existing_client_response_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final existingClientProvider =
    StateNotifierProvider<ExistingClientState, ExistingClientResponseVo?>(
        (ref) {
  return ExistingClientState();
});

class ExistingClientState extends StateNotifier<ExistingClientResponseVo?> {
  ExistingClientState() : super(null);

  void setExistingClient(ExistingClientResponseVo existingClientResponseVo) {
    state = existingClientResponseVo;
  }
}
