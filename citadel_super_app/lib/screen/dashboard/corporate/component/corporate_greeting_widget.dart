import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateGreetingWidget extends HookConsumerWidget {
  const CorporateGreetingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corporateProfile = ref.watch(corporateProfileProvider(null));

    return corporateProfile.when(data: (data) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CustomRouter.corporateProfile,
                  arguments: const CorporateProfilePage());
            },
            child: Image.network(
              data.corporateClient?.profilePicture ?? '',
              width: 64.w,
              height: 64.w,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(64.r),
                        child: child),
                  ],
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppColor.popupGray,
                    borderRadius: BorderRadius.circular(64.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 48.w,
                      color: AppColor.brightBlue,
                    ),
                  ),
                );
              },
            ),
          ),
          gapWidth16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi There',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  data.corporateDetails?.entityNameDisplay ?? '',
                  style: AppTextStyle.action,
                ),
              ],
            ),
          ),
          gapWidth16,
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CustomRouter.inbox);
            },
            child: Container(
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
                      Consumer(builder: (context, ref, child) {
                        final inbox = ref.watch(inboxProvider);
                        return inbox.whenOrNull(data: (list) {
                              final hasUnreadNotification = list.any(
                                  (element) => !(element.hasRead ?? false));

                              return Visibility(
                                visible: hasUnreadNotification,
                                child: Container(
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.errorRed,
                                  ),
                                ),
                              );
                            }) ??
                            const SizedBox.shrink();
                      })
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }, error: (error, stackTrace) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, CustomRouter.corporateProfile,
              arguments: const CorporateProfilePage());
        },
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColor.popupGray,
                borderRadius: BorderRadius.circular(64.r),
              ),
              child: Center(
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 24.w,
                  color: AppColor.brightBlue,
                ),
              ),
            ),
            gapWidth16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good day to you',
                    style: AppTextStyle.description,
                  ),
                  gapHeight8,
                  Text(
                    'Corporate',
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }, loading: () {
      return const SizedBox();
    });
  }
}
