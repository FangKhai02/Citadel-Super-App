import 'package:citadel_super_app/data/vo/notification_vo.dart';
import 'package:citadel_super_app/data/vo/sync_notification_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';

import '../../generated/assets.gen.dart';

class InboxNotification implements NotificationVo {
  String get createdAtDisplay =>
      createdAt != null ? createdAt.toDDMMMYYYhhmm : '';

  bool get isPromotion => type?.toLowerCase() == 'promotion';

  bool get isMessage => type?.toLowerCase() == 'message';

  String get notificationIconImage => isMessage
      ? Assets.images.icons.notificationMessage.path
      : Assets.images.icons.notificationPromotion.path;

  @override
  int? createdAt;

  @override
  bool? hasRead;

  @override
  int? id;

  @override
  List<String>? imageUrls;

  @override
  String? launchUrl;

  @override
  String? message;

  @override
  String? oneSignalNotificationId;

  @override
  String? title;

  @override
  String? type;

  @override
  $NotificationVoCopyWith<NotificationVo> get copyWith =>
      throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  InboxNotification.fromLocalPromotionInbox(Map<String, dynamic> json) {
    createdAt = json['date'] as int?;
    hasRead = false;
    imageUrls = json['imageUrl'] != null ? [json['imageUrl']] : null;
    launchUrl = json['launchUrl'] ?? '';
    title = json['title'] ?? '';
    message = json['message'] ?? '';
    oneSignalNotificationId = json['notificationId'];
    type = 'promotion';
  }

  InboxNotification.fromNotificationVo(NotificationVo resp) {
    id = resp.id;
    createdAt = resp.createdAt;
    hasRead = resp.hasRead;
    imageUrls = resp.imageUrls;
    launchUrl = resp.launchUrl;
    title = resp.title;
    message = resp.message;
    oneSignalNotificationId = resp.oneSignalNotificationId;
    type = resp.type;
  }

  SyncNotificationVo toSyncNotificationVo() {
    return SyncNotificationVo(
      title: title,
      message: message,
      imageUrls: imageUrls,
      createdAt: createdAt,
      isRead: hasRead,
      launchUrl: launchUrl,
      type: type,
      oneSignalNotificationId: oneSignalNotificationId,
    );
  }
}
