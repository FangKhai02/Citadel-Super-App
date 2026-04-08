import 'package:citadel_super_app/app_folder/app_enum.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/vo/client_secure_tag_vo.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecureTagPage extends ConsumerWidget {
  final ClientRepository clientRepository = ClientRepository();
  final ClientSecureTagVo secureTag;

  SecureTagPage(this.secureTag, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String client = secureTag.agentName ?? '-';
    final String clientId = secureTag.agentId ?? '-';

    return PopScope(
      canPop: false,
      child: CitadelBackground(
        backgroundType: BackgroundType.brightToDark2,
        showAppBar: false,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 22.h),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  title: 'Reject',
                  onTap: () {
                    EasyLoadingHelper.show();
                    clientRepository
                        .performActionSecureTag(SecureTagAction.reject)
                        .baseThen(
                      context,
                      onResponseSuccess: (_) {
                        Navigator.pop(context);
                      },
                      onResponseError: (e, s) {
                        if (e.message == 'api.invalid.request') {
                          context.showWarningSnackBar(
                              'This request has been cancelled');
                          Navigator.pop(context);
                        } else {
                          context.showErrorSnackBar(e.message);
                        }
                      },
                    ).whenComplete(() => EasyLoadingHelper.dismiss());
                  },
                ),
              ),
              gapWidth16,
              Expanded(
                child: PrimaryButton(
                  title: 'Approve',
                  onTap: () async {
                    EasyLoadingHelper.show();
                    await clientRepository
                        .performActionSecureTag(SecureTagAction.approve)
                        .baseThen(
                      context,
                      onResponseSuccess: (_) {
                        Navigator.pop(context);
                      },
                      onResponseError: (e, s) {
                        if (e.message == 'api.invalid.request') {
                          context.showWarningSnackBar(
                              'This request has been cancelled');
                          Navigator.pop(context);
                        } else {
                          context.showErrorSnackBar(e.message);
                        }
                      },
                    ).whenComplete(() => EasyLoadingHelper.dismiss());
                  },
                ),
              )
            ],
          ),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.icons.secureTagConsent.path,
              ),
              gapHeight32,
              Text(
                'We need your consent',
                style: AppTextStyle.header1,
                textAlign: TextAlign.center,
              ),
              gapHeight16,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Agent ',
                      style: AppTextStyle.bodyText,
                    ),
                    TextSpan(
                      text: client,
                      style: AppTextStyle.header3,
                    ),
                    TextSpan(
                      text:
                          ' $clientId is requesting your approval to purchase a trust product on your behalf. Please click "Approve" to confirm or "Reject" to decline the request.',
                      style: AppTextStyle.bodyText,
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
