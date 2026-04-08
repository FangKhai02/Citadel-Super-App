import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_profile_state.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentGreetingWidget extends HookConsumerWidget {
  const AgentGreetingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(agentProfileFutureProvider);
    final navState = ref.watch(bottomNavigationProvider);

    return profile.when(data: (data) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, CustomRouter.agentProfile);
            },
            child: Image.network(
              data.personalDetails?.profilePicture ?? '',
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
                      size: 24.w,
                      color: AppColor.brightBlue,
                    ),
                  ),
                );
              },
            ),
          ),
          gapWidth16,
          if (navState.isAgentHomePage) ...[
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
                    data.personalDetails?.name ?? '',
                    style: AppTextStyle.header3,
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
                        Consumer(
                          builder: (context, ref, child) {
                            final hasUnreadNotification =
                                ref.watch(hasUnReadNotificationProvider);
                            return hasUnreadNotification.whenOrNull(
                                    data: (hasUnreadNotification) {
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
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
          if (navState.isAgentOtherPage) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.personalDetails?.name ?? '',
                  style: AppTextStyle.header3,
                ),
                gapHeight8,
                Row(
                  children: [
                    Text(
                      'Member ID: ${data.agentDetails?.agentId ?? '-'}',
                      style: AppTextStyle.label,
                    ),
                  ],
                ),
              ],
            )
          ]
        ],
      );
    }, error: (error, stackTrace) {
      return Row(
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
                  'Hi there!',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  'Agent',
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
      );
    }, loading: () {
      return const SizedBox();
    });
  }
}
