// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/notification_vo.dart';

part 'notifications_response.freezed.dart';
part 'notifications_response.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class NotificationsResponse with _$NotificationsResponse {
  NotificationsResponse._();

  factory NotificationsResponse({
    String? code,
    String? message,
    List<NotificationVo>? promotions,
    List<NotificationVo>? messages,
  }) = _NotificationsResponse;

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //       "code": 'string',
  //       "message": 'string',
  //       "promotions": NotificationVo.toExampleApiJson(),
  //       "messages": NotificationVo.toExampleApiJson(),
  //     };
}
