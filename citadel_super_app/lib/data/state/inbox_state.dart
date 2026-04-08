import 'package:citadel_super_app/data/repository/notification_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/inbox_notification.dart';

final inboxProvider =
    FutureProvider.autoDispose<List<InboxNotification>>((ref) async {
  final NotificationRepository repository = NotificationRepository();
  final resp = await repository.getNotification();
  final promotions = (resp.promotions ?? [])
      .map((element) => InboxNotification.fromNotificationVo(element))
      .toList();
  final messages = (resp.messages ?? [])
      .map((element) => InboxNotification.fromNotificationVo(element))
      .toList();
  final list = [...promotions, ...messages];
  list.sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));

  return list;
});

final promotionInboxProvider =
    FutureProvider.autoDispose<List<InboxNotification>>((ref) async {
  final notifications = await ref.read(inboxProvider.future);
  return notifications.where((e) => e.isPromotion).toList();
});

final messageInboxProvider =
    FutureProvider.autoDispose<List<InboxNotification>>((ref) async {
  final notifications = await ref.read(inboxProvider.future);
  return notifications.where((e) => e.isMessage).toList();
});

final hasUnReadNotificationProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  final notifications = await ref.watch(inboxProvider.future);

  return notifications.any((e) => !(e.hasRead ?? false));
});
