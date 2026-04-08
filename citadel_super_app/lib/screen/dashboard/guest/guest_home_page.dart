import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/screen/fund/component/trust_fund_list.dart';

class GuestHomePage extends HookConsumerWidget {
  const GuestHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        bottomNavigationBar: const CitadelBottomNav(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: kToolbarHeight)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, CustomRouter.login, (route) => false);
                    },
                    child: Row(
                      children: [
                        Container(
                            width: 64.w,
                            decoration: BoxDecoration(
                              color: AppColor.brightBlue,
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                            child: Image.asset(
                              Assets.images.icons.profile.path,
                              width: 40.r,
                              scale: 1.5,
                            )),
                        gapWidth16,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello guest,',
                                style: AppTextStyle.description,
                              ),
                              gapHeight8,
                              Text(
                                'Login/Sign up now',
                                style: AppTextStyle.action,
                              ),
                            ],
                          ),
                        ),
                        gapWidth16,
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: AppColor.mainBlack,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.asset(
                                    Assets.images.icons.notification.path,
                                    width: 24.w,
                                    height: 24.w,
                                  ),
                                  Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.errorRed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  gapHeight32,
                  Text('Trust Product available', style: AppTextStyle.header2),
                  gapHeight16,
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: const TrustFundList(),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
