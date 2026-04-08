import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bottom_navigation.dart';
import 'package:citadel_super_app/data/repository/login_repository.dart';
import 'package:citadel_super_app/data/response/login_response_vo.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/app_version_environment_switcher.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_password_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/service/one_signal_service.dart';
import 'package:citadel_super_app/service/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../service/deeplink_service.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final formKey = GlobalKey<AppFormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Animation controllers for entrance effects
    final logoAnimation = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final contentAnimation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    useEffect(() {
      logoAnimation.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        contentAnimation.forward();
      });
      final subscription = DeeplinkService.instance.startListen(context);
      return () => subscription.cancel();
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppForm(
                key: formKey,
                child: Column(
                  children: [
                    // Logo with fade + scale animation
                    FadeTransition(
                      opacity: logoAnimation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(
                            parent: logoAnimation,
                            curve: Curves.easeOutBack,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white.withOpacity(0.05),
                            border: Border.all(
                              color: AppColor.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            Assets.images.citadelLogo.path,
                            width: 80.w,
                            height: 80.w,
                          ),
                        ),
                      ),
                    ),
                    gapHeight24,

                    // Welcome text with slide animation
                    FadeTransition(
                      opacity: contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: contentAnimation,
                          curve: Curves.easeOut,
                        )),
                        child: Column(
                          children: [
                            Text(
                              'Welcome Back',
                              style: AppTextStyle.header1.copyWith(
                                fontSize: 28.spMin,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            ),
                            gapHeight8,
                            Text(
                              'Sign in to continue to Citadel',
                              style: AppTextStyle.description.copyWith(
                                color: AppColor.white.withOpacity(0.6),
                                fontSize: 14.spMin,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapHeight48,

                    // Form fields container with glassmorphism
                    FadeTransition(
                      opacity: contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: contentAnimation,
                          curve: Curves.easeOut,
                        )),
                        child: Container(
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: AppColor.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(
                              color: AppColor.white.withOpacity(0.08),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              AppTextFormField(
                                label: 'Email',
                                fieldKey: AppFormFieldKey.emailKey,
                                keyboardType: TextInputType.emailAddress,
                                textStyle: AppTextStyle.bodyText,
                              ),
                              gapHeight16,
                              AppPasswordFormField(
                                formKey: GlobalKey<AppFormState>(),
                              ),
                              gapHeight8,
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      getAppContext() ?? context,
                                      CustomRouter.forgotPassword,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    child: Text(
                                      'Forgot password?',
                                      style: AppTextStyle.action.copyWith(
                                        color: AppColor.brightBlue,
                                        fontSize: 13.spMin,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              gapHeight24,
                              PrimaryButton(
                                title: 'Sign In',
                                onTap: () async {
                                  await formKey.currentState!.validate(
                                    onSuccess: (formData) async {
                                      LoginRepository repo = LoginRepository();

                                      EasyLoadingHelper.show();
                                      await repo
                                          .login(ParameterHelper()
                                              .loginParam(formData))
                                          .baseThen(
                                        context,
                                        onResponseSuccess: (resp) async {
                                          await OneSignalService.instance
                                              .subscribe();
                                          LoginResponseVo loginUser =
                                              LoginResponseVo.fromJson(resp);
                                          final String apiKey =
                                              loginUser.apiKey ?? '';
                                          final bool hasPin =
                                              loginUser.hasPin ?? true;
                                          final String userType =
                                              loginUser.userType ?? '';

                                          await SessionService.setSession(
                                              apiKey);
                                          ref
                                              .read(
                                                  bottomNavigationProvider.notifier)
                                              .setLoginAs(userType == 'AGENT'
                                                  ? LoginAs.agent
                                                  : LoginAs.client);
                                          if (hasPin) {
                                            Navigator.pushNamedAndRemoveUntil(
                                                getAppContext() ?? context,
                                                CustomRouter.dashboard,
                                                (route) => false);
                                          } else {
                                            Navigator.pushNamed(
                                                getAppContext() ?? context,
                                                CustomRouter.createPin);
                                          }
                                        },
                                        onResponseError: (e, s) {
                                          if (e.message.equalsIgnoreCase(
                                              'api.user.not.found')) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Email Address Is Not Registered.'),
                                                backgroundColor:
                                                    AppColor.errorRed,
                                              ),
                                            );
                                          } else if (e.message
                                              .equalsIgnoreCase(
                                                  'api.wrong.password')) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Wrong Registered Password.'),
                                                backgroundColor:
                                                    AppColor.errorRed,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(e.message),
                                                backgroundColor:
                                                    AppColor.errorRed,
                                              ),
                                            );
                                          }
                                        },
                                      ).whenComplete(
                                          () => EasyLoadingHelper.dismiss());
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    gapHeight32,

                    // Secondary actions
                    FadeTransition(
                      opacity: contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: contentAnimation,
                          curve: Curves.easeOut,
                        )),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(bottomNavigationProvider.notifier)
                                    .setLoginAs(LoginAs.guest);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    CustomRouter.dashboard, (route) => false);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColor.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  color: AppColor.white.withOpacity(0.05),
                                ),
                                child: Center(
                                  child: Text(
                                    'Continue as Guest',
                                    style: AppTextStyle.action.copyWith(
                                      color: AppColor.white.withOpacity(0.8),
                                      fontSize: 14.spMin,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            gapHeight16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style:
                                      AppTextStyle.description.copyWith(
                                    color: AppColor.white.withOpacity(0.5),
                                    fontSize: 13.spMin,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CustomRouter.signUp);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.h),
                                    child: Text(
                                      'Sign Up',
                                      style: AppTextStyle.action.copyWith(
                                        color: AppColor.brightBlue,
                                        fontSize: 13.spMin,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    gapHeight48,
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: AppVersionEnvironmentSwitcher(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
