import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/notifications_update_request.dart';
import 'package:citadel_super_app/data/request/sync_notification_request.dart';
import 'package:citadel_super_app/data/response/notifications_response_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_notification_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class NotificationRepository extends BaseWebService
    implements INotificationRepository {
  @override
  Future<NotificationsResponseVo> getNotification() async {
    final json = await get(url: AppUrl.getNotification);
    return NotificationsResponseVo.fromJson(json);
  }

  @override
  Future<void> readNotification(NotificationsUpdateRequest req) async {
    await post(url: AppUrl.readNotification, parameter: req.toJson());
  }

  @override
  Future<void> syncNotification(SyncNotificationRequest req) async {
    await post(url: AppUrl.syncNotification, parameter: req.toJson());
  }

  @override
  Future<void> deleteAllNotification(
      List<int> messageIds, List<int> promotionIds) async {
    await post(url: AppUrl.deleteNotification, parameter: {
      "promotionIds": promotionIds,
      "messagesIds": messageIds,
    });
  }

  @override
  Future<void> deleteMessageNotification(List<int> ids) async {
    await post(url: AppUrl.deleteNotification, parameter: {"messagesIds": ids});
  }

  @override
  Future<void> deletePromotionNotification(List<int> ids) async {
    await post(
        url: AppUrl.deleteNotification, parameter: {"promotionIds": ids});
  }
}
