import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/inbox_notification.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/repository/notification_repository.dart';
import 'package:citadel_super_app/data/request/notifications_update_request.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/screen/dashboard/client/secure_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/state/inbox_state.dart';
import '../../generated/assets.gen.dart';

class InboxDetailsPage extends HookConsumerWidget {
  final int? id;

  const InboxDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inbox = ref.watch(inboxProvider);

    return CitadelBackground(
      backgroundType: BackgroundType.blueToOrange2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CitadelAppBar(
            title: "Notification Details",
          ),
          inbox.when(data: (list) {
            final index = list.indexWhere((element) => element.id == id);

            if (index == -1) {
              return const Center(
                child: Text("Notification Not Found"),
              );
            }

            final notification = list[index];

            return HookBuilder(builder: (context) {
              useEffect(() {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (!(notification.hasRead ?? false)) {
                    readNotification(ref, notification);
                  }
                });
                return null;
              }, []);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? '-',
                      style: AppTextStyle.header1,
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 32)),
                    if ((notification.imageUrls ?? []).isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 229,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.cyan,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                notification.imageUrls![index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return gapHeight8;
                          },
                          itemCount: notification.imageUrls?.length ?? 0,
                        ),
                      ),
                    Text(
                      notification.message ?? '-',
                      style: AppTextStyle.bodyText,
                    ),
                    if ((notification.title ?? '')
                        .equalsIgnoreCase('Secure Tag Request')) ...[
                      gapHeight32,
                      PrimaryButton(
                        onTap: () {
                          checkSecureTag(context);
                        },
                        title: 'View Details',
                      )
                    ],
                    if ((notification.title ?? '')
                        .equalsIgnoreCase('Scheduled Maintenance')) ...[
                      gapHeight32,
                      PrimaryButton(
                        onTap: () async {
                          final Uri uri = Uri.parse(
                            'https://citadelgroup.com.my/',
                          );
                          await launchUrl(uri);
                        },
                        title: 'View More',
                      )
                    ]
                  ],
                ),
              );
            });
          }, error: (e, s) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          })
        ],
      ),
    );
  }

  void readNotification(WidgetRef ref, InboxNotification notification) async {
    NotificationRepository repository = NotificationRepository();
    await repository.readNotification(
      NotificationsUpdateRequest(
        promotionIds: notification.isPromotion ? [notification.id ?? 0] : null,
        messagesIds: notification.isMessage ? [notification.id ?? 0] : null,
      ),
    );

    ref.invalidate(inboxProvider);
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
    } else {
      showDialog(
          context: getAppContext() ?? context,
          builder: (ctx) {
            return AppDialog(
                title: 'Secure Tag Expired',
                message:
                    'This request has expired. Please get your agent to request the permission again.',
                isRounded: true,
                positiveOnTap: () {
                  Navigator.pop(context);
                },
                showNegativeButton: false,
                positiveText: 'Ok');
          });
    }
  }
}
