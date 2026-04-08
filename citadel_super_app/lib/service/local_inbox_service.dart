import 'dart:convert';
import 'dart:io';

import 'package:citadel_super_app/data/model/inbox_notification.dart';
import 'package:citadel_super_app/data/repository/notification_repository.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:citadel_super_app/service/native_bridge_service.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../data/request/sync_notification_request.dart';

class LocalInboxService {
  static const inboxMethodChannel =
      '${NativeBridgeService.methodChannel}.inbox';
  static MethodChannel inboxChannel = const MethodChannel(inboxMethodChannel);
  static const getPublicInboxNotificationKey = 'getPublicInboxNotification';
  static const deletePublicInboxNotificationKey =
      'deletePublicInboxNotification';

  static Future<bool> syncInbox() async {
    final NotificationRepository repository = NotificationRepository();
    final notifications = await getPublicInboxNotifications();

    if (notifications.isEmpty) {
      return false;
    }

    SyncNotificationRequest req = SyncNotificationRequest();
    req.notifications =
        notifications.map((e) => e.toSyncNotificationVo()).toList();
    await repository.syncNotification(req);
    await deletePublicInboxNotifications();
    await OneSignal.Notifications.clearAll();
    return true;
  }

  static Future<List<InboxNotification>> getPublicInboxNotifications() async {
    dynamic result = await inboxChannel
        .invokeMethod(getPublicInboxNotificationKey)
        .catchError((e) {
      appDebugPrint(e);
      recordError('[getInboxList] ${e.toString()}', null);
    });

    if (result is List) {
      if (result.isNotEmpty) {
        result = jsonEncode(result);
      }
    }

    List<InboxNotification> list = [];
    if (result != null && result.isNotEmpty) {
      final decodedValue = jsonDecode(result);
      if (decodedValue is List && decodedValue.isNotEmpty) {
        list = List<InboxNotification>.from(
          decodedValue.map(
            (model) => InboxNotification.fromLocalPromotionInbox(model),
          ),
        );
      }
      list.sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));
    }
    return list;
  }

  static Future<void> deletePublicInboxNotifications() async {
    await inboxChannel.invokeMethod(deletePublicInboxNotificationKey);
  }

  static void startInboxListener() {
    if (Platform.isIOS) {
      OneSignal.Notifications.addForegroundWillDisplayListener(
          _startListenInbox);
    } else {
      inboxChannel.setMethodCallHandler((methodChannel) async {
        if (methodChannel.method == getPublicInboxNotificationKey) {
          _startListenInbox(null);
        }

        return null;
      });
    }
  }

  static void removeInboxListener() {
    if (Platform.isIOS) {
      OneSignal.Notifications.removeForegroundWillDisplayListener(
          _startListenInbox);
    } else {
      inboxChannel.setMethodCallHandler(null);
    }
  }

  static void _startListenInbox(
      OSNotificationWillDisplayEvent? listener) async {
    final isSuccess = await syncInbox();

    if (isSuccess) {
      globalRef.invalidate(inboxProvider);
      globalRef.invalidate(promotionInboxProvider);
      globalRef.invalidate(messageInboxProvider);
    }
  }
}
