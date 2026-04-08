import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/vo/corporate_details_vo.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/company/company_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateHomePage extends HookConsumerWidget {
  const CorporateHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corporate = ref.watch(corporateProfileProvider(null));

    Widget corporateCreate(String title,
        {CorporateDetailsVo? corporateDetail}) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.icons.citadelTrustee.path,
              width: 166.w,
              height: 40.h,
            ),
            gapHeight16,
            Image.asset(
              Assets.images.icons.corporateTrusteeApplication.path,
              width: 343.w,
              height: 343.h,
            ),
            gapHeight16,
            Text(
              'Start now by creating your company profile',
              style: AppTextStyle.header1,
              textAlign: TextAlign.center,
            ),
            gapHeight16,
            Text(
              'Start your placement for your company and see the money grow',
              style: AppTextStyle.bodyText.copyWith(color: AppColor.offWhite),
              textAlign: TextAlign.center,
            ),
            gapHeight32,
            Consumer(builder: (context, ref, child) {
              final navState = ref.watch(bottomNavigationProvider);
              return PrimaryButton(
                title: title,
                onTap: navState.isLoginAsClient
                    ? () {
                        Navigator.pushNamed(
                            context, CustomRouter.companyDetails,
                            arguments: CompanyDetailsPage(
                              corporateDetail: corporateDetail,
                            ));
                      }
                    : null,
              );
            }),
          ],
        ),
      );
    }

    Widget corporateRejected(String remark,
        {CorporateDetailsVo? corporateDetail}) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.icons.citadelTrustee.path,
              width: 166.w,
              height: 40.h,
            ),
            gapHeight16,
            Image.asset(
              Assets.images.icons.citadelRejected.path,
              width: 343.w,
              height: 343.h,
            ),
            gapHeight32,
            Text(
              'Your company profile is rejected',
              style: AppTextStyle.header1.copyWith(color: AppColor.errorRed),
              textAlign: TextAlign.center,
            ),
            gapHeight16,
            Text(
              remark,
              style: AppTextStyle.bodyText.copyWith(color: AppColor.errorRed),
              textAlign: TextAlign.center,
            ),
            gapHeight32,
            Consumer(builder: (context, ref, child) {
              return PrimaryButton(
                title: 'Resubmit Now',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.companyDetails,
                      arguments: CompanyDetailsPage(
                        corporateDetail: corporateDetail,
                      ));
                },
              );
            }),
          ],
        ),
      );
    }

    Widget pendingCorporate() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.icons.citadelTrustee.path,
              width: 166.w,
              height: 40.h,
            ),
            gapHeight16,
            Image.asset(
              Assets.images.icons.corporateTrusteeApplication.path,
              width: 343.w,
              height: 343.h,
            ),
            gapHeight32,
            Text(
              'Your company profile creation is in progress',
              style: AppTextStyle.header1,
              textAlign: TextAlign.center,
            ),
            gapHeight16,
            Text(
              'We are reviewing your company registration. It will take less than 3 days',
              style: AppTextStyle.bodyText.copyWith(color: AppColor.offWhite),
              textAlign: TextAlign.center,
            ),
            gapHeight32,
          ],
        ),
      );
    }

    Widget corporateComingSoon() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.icons.citadelTrustee.path,
              width: 166.w,
              height: 40.h,
            ),
            gapHeight16,
            Image.asset(
              Assets.images.icons.corporateTrusteeApplication.path,
              width: 343.w,
              height: 343.h,
            ),
            gapHeight32,
            Text(
              'Start your placement for your company and see the money grow',
              style: AppTextStyle.bodyText.copyWith(color: AppColor.offWhite),
              textAlign: TextAlign.center,
            ),
            gapHeight32,
            const PrimaryButton(
              title: 'Coming Soon',
              onTap: null,
            )
          ],
        ),
      );
    }

    return CitadelBackground(
      backgroundType: BackgroundType.maintenance,
      bottomNavigationBar: const CitadelBottomNav(),
      child: corporate.when(
        data: (data) {
          if (data.corporateClient == null) {
            return corporateCreate('Create now');
          } else if (data.corporateClient?.status == "DRAFT") {
            return corporateCreate('Continue',
                corporateDetail: data.corporateDetails);
          } else if (data.corporateClient?.status == "IN_REVIEW") {
            return pendingCorporate();
          } else if (data.corporateClient?.status == "REJECTED") {
            return corporateRejected(data.corporateClient?.approvalRemark ?? '',
                corporateDetail: data.corporateDetails);
          } else {
            return corporateCreate('Create now');
          }
        },
        error: (error, stackTrace) {
          return corporateCreate('Create now');
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
