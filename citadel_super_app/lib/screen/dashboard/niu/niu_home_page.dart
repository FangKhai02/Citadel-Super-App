import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/niu_application_state.dart';
import 'package:citadel_super_app/data/state/niu_state.dart';
import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';
import 'package:citadel_super_app/extension/niu_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/niu/niu_application_details_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NiuHomePage extends HookConsumerWidget {
  const NiuHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncNiuApplication = ref.watch(niuApplicationDetailsFutureProvider);

    final hasNiuApplications = asyncNiuApplication.maybeWhen(
      data: (data) => data.isEmpty,
      orElse: () => true,
    );

    return CitadelBackground(
      backgroundType: hasNiuApplications
          ? BackgroundType.maintenance
          : BackgroundType.blueToOrange2,
      onRefresh: () async {
        try {
          // ignore: unused_result
          await ref.refresh(niuApplicationDetailsFutureProvider.future);
        } catch (e) {
          ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                  backgroundColor: AppColor.errorRed,
                  content: Text('Failed to refresh data. Please try again.')));
        }
      },
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(builder: (context, ref, child) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: PrimaryButton(
                  onTap: () {
                    ref.invalidate(niuApplicationProvider);
                    Navigator.pushNamed(context, CustomRouter.niuApplication);
                  },
                  title: 'Apply now',
                ));
          }),
          gapHeight32,
          const CitadelBottomNav(),
        ],
      ),
      child: asyncNiuApplication.when(
        data: (data) {
          if (data.isEmpty) {
            return _buildPlaceholderUI(context);
          } else {
            return _buildApplicationUI(data, context);
          }
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //       backgroundColor: AppColor.errorRed,
          //       content: Text('Failed to load data. Please try refreshing.')));
          // });
          return _buildPlaceholderUI(context);
        },
      ),
    );
  }

  Widget _buildPlaceholderUI(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.icons.niuGroup.path,
            width: 82.w,
            height: 40.h,
          ),
          gapHeight48,
          Image.asset(
            Assets.images.icons.niuApplication.path,
            width: 343.w,
            height: 252.h,
          ),
          gapHeight64,
          Text(
            'Your friend in finance',
            style: AppTextStyle.header1,
          ),
          gapHeight16,
          Text(
            'Simpler, smarter loans for a brighter future.',
            style: AppTextStyle.bodyText.copyWith(color: AppColor.offWhite),
          ),
          gapHeight32,
        ],
      ),
    );
  }

  Widget _buildApplicationUI(
      List<NiuGetApplicationDetailsVo> data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapHeight64,
          Text(
            'My NIU Application',
            style: AppTextStyle.header2,
          ),
          gapHeight32,
          ...data.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildAppInfoContainer(
                niuApplication: entry,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NiuApplicationDetailsPage(
                        niu: entry,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAppInfoContainer({
    required NiuGetApplicationDetailsVo niuApplication,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AppInfoContainer(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      niuApplication.isPersonal
                          ? Assets.images.icons.personal.path
                          : Assets.images.icons.company.path,
                      width: 24.w,
                      height: 24.h,
                    ),
                    gapWidth12,
                    Text(
                      niuApplication.isPersonal ? 'Personal' : 'Company',
                      style: AppTextStyle.header3,
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                gapHeight16,
                Text(niuApplication.amountDisplay, style: AppTextStyle.number),
                gapHeight8,
                Text('Requested on ${niuApplication.requestedDate}',
                    style: AppTextStyle.description),
              ],
            ),
            Image.asset(
              Assets.images.icons.right.path,
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
