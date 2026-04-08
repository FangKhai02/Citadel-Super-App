import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/app_version_environment_switcher.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/agent_greeting_widget.dart';
import 'package:citadel_super_app/screen/dashboard/client/component/client_greeting_widget.dart';
import 'package:citadel_super_app/screen/dashboard/client/secure_tag.dart';
import 'package:citadel_super_app/screen/dashboard/other/component/class_option_tile.dart';
import 'package:citadel_super_app/screen/login/change_pin_page.dart';
import 'package:citadel_super_app/screen/login/pin_attempt_page.dart';
import 'package:citadel_super_app/service/one_signal_service.dart';
import 'package:citadel_super_app/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OtherPage extends HookConsumerWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(bottomNavigationProvider);
    final appVersion = useState<String?>(null);
    final isSwitched = useState(true);

    Future<void> fetchAppVersion() async {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = 'V${packageInfo.version} (${packageInfo.buildNumber})';
    }

    useEffect(() {
      fetchAppVersion();
      isSwitched.value = OneSignalService.instance.didSubscribed();

      return null;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.pureBlack,
        showAppBar: false,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (appVersion.value != null)
              Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: const AppVersionEnvironmentSwitcher(),
              ),
            gapHeight16,
            const CitadelBottomNav(),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 14.w, top: 64.h, right: 14.w, bottom: 200),
              child: Column(
                children: [
                  if (navState.isLoginAsClient)
                    const ClientGreetingWidget()
                  else
                    const AgentGreetingWidget(),
                  gapHeight32,
                  const Divider(),
                  gapHeight32,
                  OthersOptions(
                    image: Assets.images.icons.bellNotification.path,
                    title: 'Push Notification',
                    action: true,
                    isSwitched: isSwitched,
                    onTap: () async {
                      OneSignal.User.pushSubscription.addObserver((state) {
                        isSwitched.value = state.current.optedIn;
                      });

                      if (isSwitched.value) {
                        await OneSignalService.instance.unsubscribe();
                        OneSignalService.instance.removeSecureTagListener();
                      } else {
                        await OneSignalService.instance.subscribe();
                        OneSignalService.instance
                            .addSecureTagListener(() async {
                          // ignore: unused_result
                          await ref.refresh(inboxProvider.future);
                          if (ref
                              .read(bottomNavigationProvider)
                              .isLoginAsClient) {
                            ClientRepository clientRepository =
                                ClientRepository();
                            final secureTag =
                                await clientRepository.getSecureTag();

                            if (context.mounted && secureTag != null) {
                              bool containsSecureTag = false;
                              Navigator.popUntil(context, (route) {
                                containsSecureTag = route.settings.name ==
                                    CustomRouter.secureTag;
                                return true;
                              });

                              if (containsSecureTag) return;
                              Navigator.pushNamed(
                                context,
                                CustomRouter.secureTag,
                                arguments: SecureTagPage(secureTag),
                              );
                            }
                          }
                          if (ref
                              .read(bottomNavigationProvider)
                              .isLoginAsAgent) {
                            ref.refresh(
                                agentPendingAgreementPortfoliosFutureProvider
                                    .future);
                          }
                        });
                      }
                    },
                  ),
                  gapHeight16,
                  if (navState.isLoginAsClient) ...[
                    OthersOptions(
                      image: Assets.images.icons.citadelSelected.path,
                      title: 'Citadel Group',
                      onTap: () {
                        Navigator.pushNamed(context, CustomRouter.citadelGroup);
                      },
                    ),
                    gapHeight16,
                  ],
                  OthersOptions(
                    image: Assets.images.icons.changePassword.path,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.pushNamed(
                          context, CustomRouter.enterOldPassword);
                    },
                  ),
                  gapHeight16,
                  OthersOptions(
                    image: Assets.images.icons.changeSecurityPin.path,
                    title: 'Change Security Pin',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PinAttemptPage(
                            appBarTitle: 'Change Pin',
                            pageTitle: 'Enter your current Security Pin',
                            onConfirm: (oldPin) {
                              Navigator.pushNamed(
                                  context, CustomRouter.changePin,
                                  arguments:
                                      ChangePinPage(oldPin: oldPin ?? ''));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  gapHeight16,
                  OthersOptions(
                    image: Assets.images.icons.message.path,
                    title: 'Contact Us',
                    onTap: () {
                      Navigator.pushNamed(context, CustomRouter.contactUs);
                    },
                  ),
                  // gapHeight16,
                  // OthersOptions(
                  //   image: Assets.images.icons.terms.path,
                  //   title: 'Terms & Conditions',
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //         context, CustomRouter.termsConditions);
                  //   },
                  // ),
                  gapHeight16,
                  OthersOptions(
                    image: Assets.images.icons.privacy.path,
                    title: 'Privacy & Policy',
                    onTap: () {
                      Navigator.pushNamed(context, CustomRouter.privacyPolicy);
                    },
                  ),
                  gapHeight16,
                  OthersOptions(
                    image: Assets.images.icons.logout.path,
                    title: 'Log out',
                    onTap: () async {
                      await SessionService.removeSession();
                      Navigator.pushNamedAndRemoveUntil(
                          getAppContext() ?? context,
                          CustomRouter.login,
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
