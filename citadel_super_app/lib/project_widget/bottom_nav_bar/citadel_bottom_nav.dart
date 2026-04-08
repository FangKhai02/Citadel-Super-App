import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CitadelBottomNav extends HookConsumerWidget {
  final bool needPop;
  const CitadelBottomNav({super.key, this.needPop = false});

  Widget bottomNavItem(int index, String title,
      {required String selectedImage, required String unselectedImage}) {
    return Consumer(builder: (context, ref, child) {
      final isLoginAsGuest = ref.watch(bottomNavigationProvider).isLoginAsGuest;
      final selectedIndex = ref.watch(bottomNavigationProvider).selectedIndex;
      final bottomNavNotifier = ref.watch(bottomNavigationProvider.notifier);

      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (isLoginAsGuest) {
            Navigator.pushNamedAndRemoveUntil(
                context, CustomRouter.login, (route) => false);
          } else if (needPop) {
            bottomNavNotifier.setSelectedIndex(index);
            Navigator.pop(context);
          } else {
            bottomNavNotifier.setSelectedIndex(index);
            if (needPop) {
              Navigator.pop(context);
            }
          }
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          gapHeight8,
          Image.asset(
            selectedIndex == index ? selectedImage : unselectedImage,
            width: 24.w,
          ),
          gapHeight8,
          Text(
            title,
            textAlign: TextAlign.center,
            style: selectedIndex == index
                ? AppTextStyle.label
                    .copyWith(fontSize: 8, color: AppColor.brightBlue)
                : AppTextStyle.caption
                    .copyWith(fontSize: 8, color: AppColor.placeHolderBlack),
          ),
          gapHeight8
        ]),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoginAsAgent = ref.watch(bottomNavigationProvider).isLoginAsAgent;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
      child: Container(
        height: 66.h,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(32.r)),
        child: Row(
          children: [
            Expanded(
                child: bottomNavItem(0, 'Home',
                    selectedImage: Assets.images.icons.citadelSelected.path,
                    unselectedImage: Assets.images.icons.citadelUnselect.path)),
            if (!isLoginAsAgent)
              Expanded(
                  child: bottomNavItem(1, 'Corporate',
                      selectedImage: Assets.images.icons.corparateSelected.path,
                      unselectedImage:
                          Assets.images.icons.corporateUnselect.path)),
            Expanded(
                child: bottomNavItem(2, 'NIU',
                    selectedImage: Assets.images.icons.niuSelected.path,
                    unselectedImage: Assets.images.icons.niuUnselect.path)),
            Expanded(
                child: bottomNavItem(3, 'Others',
                    selectedImage: Assets.images.icons.otherSelected.path,
                    unselectedImage: Assets.images.icons.otherUnselect.path)),
          ],
        ),
      ),
    );
  }
}
