import 'dart:async';

import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/data/vo/agent_secure_tag_vo.dart';
import 'package:citadel_super_app/extension/agent_secure_tag_vo_extension.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/agent_action/component/consent_request_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../service/one_signal_service.dart';

final consentStatusProvider = FutureProvider.autoDispose
    .family<AgentSecureTagVo?, String>((ref, clientId) async {
  final AgentRepository agentRepository = AgentRepository();
  return await agentRepository.getAgentSecureTagStatus(clientId);
});

class ConsentRequestPage extends HookConsumerWidget {
  final String clientId;

  const ConsentRequestPage(this.clientId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientSecureTag = ref.watch(consentStatusProvider(clientId));
    final timer = useState(30);
    final isExpired = timer.value == 0;

    //countdown
    useEffect(() {
      final t = Timer.periodic(const Duration(seconds: 1), (t) {
        timer.value--;
        if (timer.value <= 0) {
          t.cancel();
        }
      });
      return () {
        if (t.isActive) {
          t.cancel();
        }
      };
    }, []);

    useEffect(() {
      OneSignalService.instance.addSecureTagListener(() async {
        // ignore: unused_result
        await ref.refresh(inboxProvider.future);
        ref.invalidate(consentStatusProvider);
      });

      return () => OneSignalService.instance.removeSecureTagListener();
    }, []);

    return PopScope(
      canPop: false,
      child: CitadelBackground(
        backgroundType: BackgroundType.brightToDark2,
        showAppBar: false,
        bottomNavigationBar: clientSecureTag.maybeWhen(
          data: (data) {
            final consentStatus =
                isExpired && (data.consentStatus == ConsentStatus.pending)
                    ? ConsentStatus.expired
                    : data.consentStatus;

            if (consentStatus == null) {
              return const SizedBox();
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 22.h),
              child: consentStatus.getButton(context, data!, clientId),
            );
          },
          orElse: () => const SizedBox(),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: clientSecureTag.when(
            data: (data) {
              return ConsentRequest(clientId, isExpired);
            },
            error: (e, s) {
              return Center(
                child: Column(
                  children: [
                    const Text('Something Went Wrong'),
                    PrimaryButton(
                      title: 'Back',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
