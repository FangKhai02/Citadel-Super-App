// ignore_for_file: unused_result

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/inbox_notification.dart';
import 'package:citadel_super_app/data/repository/notification_repository.dart';
import 'package:citadel_super_app/extension/list_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/state/inbox_state.dart';
import '../../project_widget/appbar/citadel_app_bar.dart';
import '../../project_widget/container/app_info_container.dart';

class InboxPage extends StatefulHookConsumerWidget {
  const InboxPage({super.key});

  @override
  ConsumerState<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends ConsumerState<InboxPage> {
  final PageController controller = PageController(initialPage: 0);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final inbox = ref.watch(inboxProvider);
    final promotion = ref.watch(promotionInboxProvider);
    final message = ref.watch(messageInboxProvider);

    return CitadelBackground(
      backgroundType: BackgroundType.blueToOrange2,
      onRefresh: () async {
        EasyLoadingHelper.show();
        await ref.refresh(inboxProvider.future);
        await ref.refresh(promotionInboxProvider.future);
        await ref.refresh(messageInboxProvider.future);
        EasyLoadingHelper.dismiss();
      },
      child: Column(
        children: [
          CitadelAppBar(
            title: "Notifications",
            actions: [
              IconButton(
                onPressed: () async {
                  await showDialog(
                        context: getAppContext() ?? context,
                        builder: (context) {
                          return AppDialog(
                            title: selectedIndex == 0
                                ? 'Are you sure you want to delete all notifications?'
                                : selectedIndex == 1
                                    ? 'Are you sure you want to delete all promotions notifications?'
                                    : 'Are you sure you want to delete all messages notifications?',
                            positiveText: 'No',
                            positiveOnTap: () {
                              Navigator.pop(context);
                            },
                            isRounded: true,
                            negativeText: 'Yes, delete',
                            negativeOnTap: () async {
                              EasyLoadingHelper.show();
                              NotificationRepository notificationRepository =
                                  NotificationRepository();
                              if (selectedIndex == 0) {
                                try {
                                  await notificationRepository
                                      .deleteAllNotification([], []);

                                  Navigator.pop(getAppContext() ?? context);
                                  await ref.refresh(inboxProvider.future);
                                  await ref
                                      .refresh(promotionInboxProvider.future);
                                  await ref
                                      .refresh(messageInboxProvider.future);
                                } catch (e) {
                                  ScaffoldMessenger.of(
                                          getAppContext() ?? context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: AppColor.errorRed,
                                          content: Text(e.toString())));
                                }
                                EasyLoadingHelper.dismiss();
                              } else if (selectedIndex == 1) {
                                try {
                                  await notificationRepository
                                      .deletePromotionNotification([]);

                                  Navigator.pop(getAppContext() ?? context);
                                  await ref.refresh(inboxProvider.future);
                                  await ref
                                      .refresh(promotionInboxProvider.future);
                                  await ref
                                      .refresh(messageInboxProvider.future);
                                } catch (e) {
                                  ScaffoldMessenger.of(
                                          getAppContext() ?? context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: AppColor.errorRed,
                                          content: Text(e.toString())));
                                }
                                EasyLoadingHelper.dismiss();
                              } else {
                                try {
                                  await notificationRepository
                                      .deleteMessageNotification([]);

                                  Navigator.pop(getAppContext() ?? context);
                                  await ref.refresh(inboxProvider.future);
                                  await ref
                                      .refresh(promotionInboxProvider.future);
                                  await ref
                                      .refresh(messageInboxProvider.future);
                                } catch (e) {
                                  ScaffoldMessenger.of(
                                          getAppContext() ?? context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: AppColor.errorRed,
                                          content: Text(e.toString())));
                                }
                                EasyLoadingHelper.dismiss();
                              }
                            },
                          );
                        },
                      ) as bool? ??
                      false;
                },
                icon: Image.asset(
                  Assets.images.icons.delete.path,
                  width: 24.w,
                  height: 24.h,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  inbox.maybeWhen(
                    data: (data) {
                      final notRead = data
                          .where((element) => !(element.hasRead ?? false))
                          .length;

                      return tab("All", notRead, 0);
                    },
                    orElse: () {
                      return tab("All", 0, 0);
                    },
                  ),
                  promotion.maybeWhen(
                    data: (data) {
                      final notRead = data
                          .where((element) => !(element.hasRead ?? false))
                          .length;

                      return tab("Promotions", notRead, 1);
                    },
                    orElse: () {
                      return tab("Promotions", 0, 1);
                    },
                  ),
                  message.maybeWhen(
                    data: (data) {
                      final notRead = data
                          .where((element) => !(element.hasRead ?? false))
                          .length;

                      return tab("Messages", notRead, 2);
                    },
                    orElse: () {
                      return tab("Messages", 0, 2);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 0.77.sh,
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                inbox.when(
                  data: (list) {
                    return inboxAppInfoContainer(list);
                  },
                  error: (e, s) {
                    return Center(
                      child: Text(
                        "Something Went Wrong",
                        style: AppTextStyle.bodyText,
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                promotion.when(
                  data: (list) {
                    return inboxAppInfoContainer(list);
                  },
                  error: (e, s) {
                    return Center(
                      child: Text(
                        "Something Went Wrong",
                        style: AppTextStyle.bodyText,
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                message.when(
                  data: (list) {
                    return inboxAppInfoContainer(list);
                  },
                  error: (e, s) {
                    return Center(
                      child: Text(
                        "Something Went Wrong",
                        style: AppTextStyle.bodyText,
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tab(String title, int totalCount, int index) {
    final isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.mainBlack : Colors.transparent,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Center(
          child: Row(
            children: [
              Text(
                title,
                style: isSelected
                    ? AppTextStyle.action.copyWith(fontSize: 14.sp)
                    : AppTextStyle.description.copyWith(fontSize: 14.sp),
              ),
              if (totalCount > 0)
                Container(
                  margin: EdgeInsets.only(left: 8.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.0.h),
                  decoration: const BoxDecoration(
                      color: AppColor.errorRed, shape: BoxShape.circle),
                  child: Center(
                    child: Text(totalCount.toString(),
                        style: AppTextStyle.remark
                            .copyWith(color: AppColor.white, fontSize: 10.sp)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inboxAppInfoContainer(List<InboxNotification> list) {
    return AppInfoContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.all(16.r),
      color: AppColor.cyan.withOpacity(0.2),
      child: list.whenList(
        hasData: (data) {
          return Scrollbar(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                final notification = list[index];

                return Slidable(
                  key: ValueKey(notification.id),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () async {
                            final slidableController = Slidable.of(context);
                            await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AppDialog(
                                      title:
                                          'Are you sure you want to delete this notification?',
                                      positiveText: 'No',
                                      positiveOnTap: () {
                                        if (slidableController != null) {
                                          slidableController.close();
                                        }
                                        Navigator.pop(context, false);
                                      },
                                      isRounded: true,
                                      negativeText: 'Yes, delete',
                                      negativeOnTap: () async {
                                        EasyLoadingHelper.show();
                                        NotificationRepository
                                            notificationRepository =
                                            NotificationRepository();

                                        if (list[index].isPromotion) {
                                          try {
                                            await notificationRepository
                                                .deletePromotionNotification(
                                                    [list[index].id!]);

                                            Navigator.pop(
                                                getAppContext() ?? context);
                                            await ref
                                                .refresh(inboxProvider.future);
                                            await ref.refresh(
                                                promotionInboxProvider.future);
                                            await ref.refresh(
                                                messageInboxProvider.future);
                                          } catch (e) {
                                            ScaffoldMessenger.of(
                                                    getAppContext() ?? context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        AppColor.errorRed,
                                                    content:
                                                        Text(e.toString())));
                                          }
                                          EasyLoadingHelper.dismiss();
                                        } else {
                                          try {
                                            await notificationRepository
                                                .deleteMessageNotification(
                                                    [list[index].id!]);

                                            Navigator.pop(
                                                getAppContext() ?? context);
                                            await ref
                                                .refresh(inboxProvider.future);
                                            await ref.refresh(
                                                promotionInboxProvider.future);
                                            await ref.refresh(
                                                messageInboxProvider.future);
                                          } catch (e) {
                                            ScaffoldMessenger.of(
                                                    getAppContext() ?? context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        AppColor.errorRed,
                                                    content:
                                                        Text(e.toString())));
                                          }
                                          EasyLoadingHelper.dismiss();
                                        }
                                      },
                                    );
                                  },
                                ) as bool? ??
                                false;
                          },
                          child: Container(
                            width: 72,
                            height: 73,
                            color: AppColor.errorRed,
                            alignment: Alignment.center,
                            child: Image.asset(
                              Assets.images.icons.delete.path,
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context,
                          "${CustomRouter.inboxDetails}?id=${notification.id}");
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      constraints:
                          BoxConstraints(minHeight: 73.h, maxHeight: 93.h),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                notification.notificationIconImage,
                                width: 40.r,
                                height: 40.r,
                              ),
                              if (!(notification.hasRead ?? false))
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 8.r,
                                    width: 8.r,
                                    decoration: BoxDecoration(
                                      color: AppColor.errorRed,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(left: 16.w)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  notification.title ?? '-',
                                  style:
                                      AppTextStyle.bodyText.copyWith(height: 1),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                gapHeight8,
                                Text(
                                  notification.createdAtDisplay,
                                  style: AppTextStyle.caption,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppColor.white.withOpacity(0.2),
                );
              },
            ),
          );
        },
        noData: () {
          return Center(
            child: Text(
              'No Notifications for now',
              style: AppTextStyle.bodyText,
            ),
          );
        },
      ),
    );
  }
}
