import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/web_screen/web_e_sign_agreement_page.dart';
import 'package:citadel_super_app/web_screen/web_finish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:package_info_plus/package_info_plus.dart';

class WebAgreementPage extends HookWidget {
  final String? identifier;
  final String? environment;
  const WebAgreementPage({super.key, this.identifier, this.environment});
  @override
  Widget build(BuildContext context) {
    final appVersion = useState<String?>(null);

    Future<void> fetchAppVersion() async {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = 'V${packageInfo.version}-${packageInfo.buildNumber}';
    }

    useEffect(() {
      fetchAppVersion();
      return null;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange,
        bottomNavigationBar: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, bottom: 16.h),
              child: Text(
                appVersion.value ?? '',
                style: AppTextStyle.caption,
              ),
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapHeight32,
              Image.asset(
                Assets.images.citadelLogo.path,
                width: 200.w,
                height: 64.h,
              ),
              Image.asset(
                Assets.images.icons.citadelRejected.path,
                width: 343.w,
                height: 343.h,
              ),
              gapHeight32,
              Text(
                'Hey there, ',
                style: AppTextStyle.header1,
                textAlign: TextAlign.center,
              ),
              gapHeight16,
              Text(
                'Please review and sign this agreement.',
                style: AppTextStyle.bodyText.copyWith(color: AppColor.offWhite),
                textAlign: TextAlign.center,
              ),
              gapHeight100,
              PrimaryButton(
                  title: 'View agreement',
                  onTap: () async {
                    if (environment != null && environment == 'dev') {
                      await AppUrl.setEnvironment(AppConstant.kDev);
                    } else {
                      await AppUrl.setEnvironment(AppConstant.kProd);
                    }

                    AgreementRepository repo = AgreementRepository();
                    await repo
                        .getSecondSigneeAgreement(identifier ?? '')
                        .baseThen(context, onResponseSuccess: (link) {
                      if (link != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebESignAgreementPage(
                                pdfUrl:
                                    link, // Use URL directly instead of file path
                                requiredIdentity: true,
                                requiredCompanyRole: true,
                                onSubmit: (signature,
                                    [name, userId, role]) async {
                                  await repo
                                      .submitSecondSigneeAgreement(
                                          identifier ?? '', signature,
                                          fullName: name,
                                          userId: userId,
                                          role: role)
                                      .baseThen(
                                    getAppContext() ?? context,
                                    onResponseSuccess: (_) async {
                                      Navigator.pushReplacementNamed(
                                          context, CustomRouter.webFinish,
                                          arguments: const WebFinishPage(
                                            message:
                                                'The trust deed has been signed. You can now close this tab. Thank you!',
                                          ));
                                    },
                                    onResponseError: (e, s) {
                                      showDialog(
                                          context: getAppContext() ?? context,
                                          builder: (ctx) {
                                            return AppDialog(
                                                title: 'Unable to proceed',
                                                message: e.message,
                                                isRounded: true,
                                                positiveOnTap: () {
                                                  Navigator.pop(ctx);
                                                },
                                                showNegativeButton: false,
                                                positiveText: 'Retry');
                                          });
                                    },
                                  ).whenComplete(() {
                                    EasyLoadingHelper.dismiss();
                                  });
                                }),
                          ),
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                            context, CustomRouter.webFinish,
                            arguments: const WebFinishPage(
                              message:
                                  'Agreement not found, please seek for assistance',
                            ));
                      }
                    }, onResponseError: (e, s) {
                      if ('Invalid unique identifier' == e.message) {
                        Navigator.pushReplacementNamed(
                            context, CustomRouter.webFinish,
                            arguments: const WebFinishPage(
                              message: 'Link has been expired',
                            ));
                      } else {
                        Navigator.pushReplacementNamed(
                            context, CustomRouter.webFinish,
                            arguments: const WebFinishPage(
                              message:
                                  'Agreement not found, please seek for assistance',
                            ));
                      }
                    });
                  }),
            ],
          ),
        ));
  }
}
