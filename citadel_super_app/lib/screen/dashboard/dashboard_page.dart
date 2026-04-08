import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/dashboard/agent/agent_home_page.dart';
import 'package:citadel_super_app/screen/dashboard/client/client_home_page.dart';
import 'package:citadel_super_app/screen/dashboard/client/secure_tag.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_home_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_dashboard_page.dart';
import 'package:citadel_super_app/screen/dashboard/guest/guest_home_page.dart';
import 'package:citadel_super_app/screen/dashboard/niu/niu_home_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/other_page.dart';
import 'package:citadel_super_app/service/local_inbox_service.dart';
import 'package:citadel_super_app/service/one_signal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../service/deeplink_service.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(bottomNavigationProvider);
    final pageController = usePageController(initialPage: 0);
    final corporateState = ref.watch(corporateProfileProvider(null));
    final agentPendingAgreement =
        ref.watch(agentPendingAgreementPortfoliosFutureProvider);
    final appLifeCycleState = useAppLifecycleState();

    useEffect(() {
      LocalInboxService.startInboxListener();

      return () => LocalInboxService.removeInboxListener();
    }, []);

    useEffect(() {
      if (appLifeCycleState == AppLifecycleState.resumed) {
        LocalInboxService.syncInbox().then((isSuccess) {
          if (isSuccess) {
            ref.invalidate(inboxProvider);
            ref.invalidate(promotionInboxProvider);
            ref.invalidate(messageInboxProvider);
          }
        });
        if (ref.read(bottomNavigationProvider).isLoginAsClient) {
          checkSecureTag(context);
        }
        if (ref.read(bottomNavigationProvider).isLoginAsAgent) {
          ref.refresh(agentPendingAgreementPortfoliosFutureProvider.future);
        }
      }

      return null;
    }, [appLifeCycleState]);

    useEffect(() {
      OneSignalService.instance.addSecureTagListener(() async {
        // ignore: unused_result
        await ref.refresh(inboxProvider.future);
        if (ref.read(bottomNavigationProvider).isLoginAsClient) {
          checkSecureTag(getAppContext() ?? context);
        }
        if (ref.read(bottomNavigationProvider).isLoginAsAgent) {
          ref.refresh(agentPendingAgreementPortfoliosFutureProvider.future);
        }
      });

      return () => OneSignalService.instance.removeSecureTagListener();
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ref.read(bottomNavigationProvider).isLoginAsClient) {
          checkSecureTag(context);
        }
      });
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pageController.jumpToPage(navState.selectedIndex ?? 0);
      });

      return null;
    }, [navState]);

    getHomePage() {
      if (navState.isLoginAsClient) {
        return ClientHomePage();
      } else if (navState.isLoginAsAgent) {
        return const AgentHomePage();
      } else {
        return const GuestHomePage();
      }
    }

    Widget getCorporatePage() {
      return corporateState.when(
          data: (data) {
            if (navState.isLoginAsClient) {
              if (data.corporateClient != null &&
                  data.corporateClient?.status == 'APPROVED') {
                return CorporateDashboardPage(
                  corporateClientId:
                      data.corporateClient?.corporateClientId ?? '',
                );
              }
              return const CorporateHomePage();
            }

            return const CorporateHomePage();
          },
          error: (e, s) {
            return CitadelBackground(
                backgroundType: BackgroundType.blueToOrange2,
                bottomNavigationBar: const CitadelBottomNav(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Something Went Wrong',
                      style: AppTextStyle.caption,
                    ),
                    gapHeight16,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: PrimaryButton(
                        title: 'Retry',
                        onTap: () {
                          ref.invalidate(corporateProfileProvider);
                        },
                      ),
                    )
                  ],
                ));
          },
          loading: () {
            return const CitadelBackground(
              backgroundType: BackgroundType.blueToOrange2,
              bottomNavigationBar: CitadelBottomNav(),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          skipLoadingOnRefresh: false);
    }

    useEffect(() {
      final subscription = DeeplinkService.instance.startListen(context);

      return () => subscription.cancel();
    }, []);

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (pageIndex) {
        if (pageIndex == 1) {
          ref.invalidate(corporateProfileProvider);
        }
      },
      children: [
        getHomePage(),
        if (navState.isLoginAsClient && !navState.isLoginAsGuest)
          getCorporatePage()
        else
          const SizedBox.shrink(),
        const NiuHomePage(),
        const OtherPage(),
      ],
    );
  }

  void checkSecureTag(BuildContext context) async {
    ClientRepository clientRepository = ClientRepository();
    final secureTag = await clientRepository.getSecureTag();

    if (context.mounted && secureTag != null) {
      bool containsSecureTag = false;
      Navigator.popUntil(context, (route) {
        containsSecureTag = route.settings.name == CustomRouter.secureTag;
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
}
