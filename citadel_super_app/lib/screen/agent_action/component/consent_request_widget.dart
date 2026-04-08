import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/vo/agent_secure_tag_vo.dart';
import 'package:citadel_super_app/extension/agent_secure_tag_vo_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/screen/agent_action/consent_request_page.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../project_widget/button/primary_button.dart';

enum ConsentStatus {
  rejected(
    title: 'Consent Rejected',
    button: 'Dismiss',
  ),
  pending(
    title: 'Pending consent approval',
    button: 'Dismiss',
  ),
  approved(
      title: 'Consent approved!',
      button: 'Proceed',
      color: AppColor.brightBlue),
  expired(title: 'Consent expired', button: 'OK', color: AppColor.errorRed);

  final String title;
  final String button;
  final Color? color;

  Widget desc(AgentSecureTagVo? agent) {
    String client = agent?.clientName ?? '-';
    String clientId = '(${agent?.clientId ?? '-'})';

    switch (this) {
      case ConsentStatus.pending:
        return Text.rich(
          TextSpan(children: [
            TextSpan(
                text: 'Pending consent approval from your client ',
                style: AppTextStyle.bodyText),
            TextSpan(text: client, style: AppTextStyle.header3),
            TextSpan(text: clientId, style: AppTextStyle.bodyText),
          ]),
          textAlign: TextAlign.center,
        );

      case ConsentStatus.approved:
        return Text.rich(
          TextSpan(children: [
            TextSpan(text: 'Your client ', style: AppTextStyle.bodyText),
            TextSpan(text: client, style: AppTextStyle.header3),
            TextSpan(
                text: ' $clientId has successfully approved',
                style: AppTextStyle.bodyText)
          ]),
          textAlign: TextAlign.center,
        );

      case ConsentStatus.expired:
        return Text(
          'Your consent request was expired. Please try again.',
          style: AppTextStyle.bodyText,
          textAlign: TextAlign.center,
        );
      case ConsentStatus.rejected:
        return Text(
          'Your consent request was rejected.',
          style: AppTextStyle.bodyText,
          textAlign: TextAlign.center,
        );
    }
  }

  String image() {
    switch (this) {
      case ConsentStatus.pending:
        return Assets.images.icons.pendingConsent.path;
      case ConsentStatus.approved:
        return Assets.images.icons.consentApproved.path;
      case ConsentStatus.expired:
      case ConsentStatus.rejected:
        return Assets.images.icons.consentExpired.path;
    }
  }

  Widget getButton(
      BuildContext context, AgentSecureTagVo agent, String clientId) {
    switch (this) {
      case ConsentStatus.pending:
        return SecondaryButton(
          title: button,
          onTap: () {
            final AgentRepository agentRepository = AgentRepository();
            EasyLoadingHelper.show();
            agentRepository
                .cancelAgentSecureTag(agent.clientId!)
                .baseThen(context, onResponseSuccess: (_) {})
                .whenComplete(() {
              Navigator.pop(getAppContext() ?? context);
              EasyLoadingHelper.dismiss();
            });
          },
        );
      case ConsentStatus.rejected:
      case ConsentStatus.expired:
        return PrimaryButton(
          title: button,
          onTap: () {
            Navigator.pop(context);
          },
        );

      case ConsentStatus.approved:
        return PrimaryButton(
          title: button,
          onTap: () {
            Navigator.pop(context);

            Navigator.pushNamed(context, CustomRouter.trustFund,
                arguments: TrustFundPage(
                  clientId: clientId,
                  purchaseByAgent: true,
                ));
          },
        );
    }
  }

  const ConsentStatus({required this.title, required this.button, this.color});
}

class ConsentRequest extends ConsumerWidget {
  final String clientId;
  final bool expired;

  const ConsentRequest(this.clientId, this.expired, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consentStatus = ref.watch(consentStatusProvider(clientId));

    return consentStatus.maybeWhen(
      data: (data) {
        final status = expired && (data.consentStatus == ConsentStatus.pending)
            ? ConsentStatus.expired
            : data.consentStatus;

        if (status == null) return const SizedBox();

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (status == ConsentStatus.pending) ...[
                  Image.asset(
                    status.image(),
                    width: 96.w,
                    height: 96.h,
                  ),
                  SizedBox(
                      width: 160.w,
                      height: 160.h,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(0.0),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return AppColor.loadingGradient
                                .createShader(bounds);
                          },
                          child: ClipOval(
                            child: Container(
                              width: 160.w,
                              height: 160.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 8.0.w, color: Colors.transparent),
                              ),
                              child: CircularProgressIndicator(
                                strokeWidth: 8.0.w,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )),
                ] else ...[
                  Image.asset(
                    status.image(),
                    width: 160.w,
                    height: 160.h,
                  ),
                ]
              ],
            ),
            gapHeight32,
            Text(
              status.title,
              style: AppTextStyle.header1,
            ),
            gapHeight16,
            status.desc(data),
          ],
        );
      },
      orElse: () => const SizedBox(),
    );
  }
}
