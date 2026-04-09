import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/component/environment_switch_password_widget.dart';
import 'package:citadel_super_app/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppVersionEnvironmentSwitcher extends HookWidget {
  const AppVersionEnvironmentSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final appVersion = useState<String?>(null);
    final environment = useState<String?>(null);

    Future<void> fetchAppVersion() async {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final currentEnv = await SharedPreferenceHelper()
          .getSelectedEnvironment(key: AppConstant.kServer);
      environment.value = currentEnv;
      appVersion.value = 'V${packageInfo.version}-${packageInfo.buildNumber}';
    }

    useEffect(() {
      fetchAppVersion();
      return null;
    }, []);

    void resetData() async {
      Navigator.pop(context);
      await SessionService.removeSession();
      Navigator.pushNamedAndRemoveUntil(
          getAppContext() ?? context, CustomRouter.splash, (route) => false);
    }

    return appVersion.value != null
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: () async {
              final String selectedEnvironment = await SharedPreferenceHelper()
                  .getSelectedEnvironment(key: AppConstant.kServer);

              showDialog(
                  context: getAppContext() ?? context,
                  builder: (ctx) {
                    return Dialog(
                      backgroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300.w),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 32.h),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Environment',
                                    style: AppTextStyle.header1
                                        .copyWith(color: AppColor.mainBlack)),
                                gapHeight16,
                                Text(
                                    'Current environment: $selectedEnvironment',
                                    style: AppTextStyle.bodyText
                                        .copyWith(color: AppColor.mainBlack)),
                                gapHeight32,
                                PrimaryButton(
                                    height: 48.h,
                                    title: 'Production',
                                    onTap: () async {
                                      final result =
                                          await showPasswordDialog(context);
                                      if (result) {
                                        await AppUrl.setEnvironment(
                                            AppConstant.kProd);
                                        resetData();
                                      }
                                    }),
                                gapHeight8,
                                PrimaryButton(
                                    height: 48.h,
                                    title: 'Development',
                                    onTap: () async {
                                      final result =
                                          await showPasswordDialog(context);
                                      if (result) {
                                        await AppUrl.setEnvironment(
                                            AppConstant.kDev);
                                        resetData();
                                      }
                                    }),
                                gapHeight8,
                                PrimaryButton(
                                    height: 48.h,
                                    title: 'Local (88.88.1.18)',
                                    onTap: () async {
                                      final result =
                                          await showPasswordDialog(context);
                                      if (result) {
                                        await AppUrl.setEnvironment(
                                            AppConstant.kLocal);
                                        resetData();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Text(
              appVersion.value ?? '',
              style: AppTextStyle.caption,
            ),
          )
        : const SizedBox.shrink();
  }
}

class SharedPreferenceHelper {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Set app environment, key : [kProd / kDev / kUAT]
  Future<void> setSelectedEnvironment(String mode, {String? key}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key ?? AppConstant.kServer, mode);
  }

  /// Get app environment, key : [kProd / kDev / kUAT]
  Future<String> getSelectedEnvironment({String? key}) async {
    final SharedPreferences prefs = await _prefs;
    final currentEnvironment =
        prefs.getString(key ?? AppConstant.kServer) ?? AppConstant.kProd;
    return currentEnvironment;
  }
}
