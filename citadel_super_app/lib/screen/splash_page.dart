import 'dart:io';

import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/app_repository.dart';
import 'package:citadel_super_app/data/response/agency_list_response_vo.dart';
import 'package:citadel_super_app/data/response/get_constants_response_vo.dart';
import 'package:citadel_super_app/data/response/get_maintenance_response_vo.dart';
import 'package:citadel_super_app/data/response/login_response_vo.dart';
import 'package:citadel_super_app/data/response/settings_response_vo.dart';
import 'package:citadel_super_app/data/state/bank_list_state.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/postcode_state.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/extension/login_response_vo_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/screen/maintenance/maintenance_page.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      AppUrl.init();

      Future.delayed(const Duration(seconds: 3), () async {
        try {
          // [DEBUG] Bypassing maintenance check for local development
          init(ref, context);

          AppRepository appRepository = AppRepository();
          final platform = Platform.operatingSystem;
          final PackageInfo packageInfo = await PackageInfo.fromPlatform();

          await appRepository
              .checkForceUpdate(packageInfo.version, platform)
              .baseThen(getAppContext() ?? context, onResponseSuccess: (resp) async {
            if ((resp.message ?? '')
                .equalsIgnoreCase('api.update.required')) {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AppDialog(
                      title: 'Update Required',
                      message:
                          'A latest version of the application has been released. Please update to the latest version for new feature.',
                      isRounded: true,
                      positiveOnTap: () async {
                        await launch(
                          resp.updateLink ?? '',
                          forceSafariVC: false,
                          forceWebView: false,
                        );
                        Navigator.pop(getAppContext() ?? context);
                      },
                      showNegativeButton: !(resp.updateRequired ?? false),
                      positiveText: 'Update',
                      negativeText: 'Cancel',
                      negativeOnTap: () async {
                        await initApi(ref, context);
                      },
                    );
                  });
            } else {
              await initApi(ref, context);
            }
            return;
          });
        } catch (e) {}
      });
      return null;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBrightSplash,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 55.w),
            child: Image.asset(
              Assets.images.citadelLogo.path,
              fit: BoxFit.fitWidth,
            ),
          ),
        ));
  }

  Future<void> init(WidgetRef ref, BuildContext context) async {
    await Future.wait([
      ref.read(postcodeProvider.notifier).initFromJson(context),
      ref.read(countryCodeProvider.notifier).initFromJson(context),
      ref.read(bankListProvider.notifier).initFromJson(context),
    ]);
  }

  Future<void> initApi(WidgetRef ref, BuildContext context) async {
    try {
      AppRepository appRepository = AppRepository();

      appRepository.getAgencies().baseThen(context, onResponseSuccess: (resp) {
        AgencyListResponseVo agencyListResponseVo =
            AgencyListResponseVo.fromJson(resp);

        if (agencyListResponseVo.code == '200') {
          ref
              .read(appProvider.notifier)
              .setAgencies(agencyListResponseVo.agencyList ?? []);
        }
      });

      appRepository.getSettings().baseThen(context, onResponseSuccess: (resp) {
        SettingsResponseVo settingsResponseVo =
            SettingsResponseVo.fromJson(resp);

        if (settingsResponseVo.code == '200') {
          ref
              .read(appProvider.notifier)
              .setAppSettings(settingsResponseVo.settings ?? []);
        }
      });

      appRepository.getConstants().baseThen(context, onResponseSuccess: (resp) {
        GetConstantsResponseVo getConstantsResponseVo =
            GetConstantsResponseVo.fromJson(resp);

        if (getConstantsResponseVo.code == '200') {
          ref
              .read(appProvider.notifier)
              .setConstants(getConstantsResponseVo.constants ?? []);

          SessionService.init().whenComplete(() {
            if (SessionService.isLogin) {
              AppRepository repo = AppRepository();
              repo.getAppUser(SessionService.apiKey ?? '').baseThen(getAppContext() ?? context,
                  onResponseSuccess: (resp) {
                LoginResponseVo loginUser = LoginResponseVo.fromJson(resp);

                ref
                    .read(bottomNavigationProvider.notifier)
                    .setLoginAs(loginUser.loginAs);

                if (loginUser.requiredPin) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    CustomRouter.createPin,
                    (route) => false,
                  );
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, CustomRouter.dashboard, (route) => false);
                }
              });
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  getAppContext() ?? context, CustomRouter.login, (route) => false);
            }
          });
        }
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}
