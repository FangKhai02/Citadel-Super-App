import 'package:citadel_super_app/data/request/notifications_update_request.dart';
import 'package:citadel_super_app/data/request/sync_notification_request.dart';
import 'package:citadel_super_app/data/response/notifications_response_vo.dart';

abstract class INotificationRepository {
  Future<void> syncNotification(SyncNotificationRequest req);

  Future<void> readNotification(NotificationsUpdateRequest req);

  Future<void> deleteAllNotification(
      List<int> messageIds, List<int> promotionIds);

  Future<void> deletePromotionNotification(List<int> ids);

  Future<void> deleteMessageNotification(List<int> ids);

  Future<NotificationsResponseVo> getNotification();
}
