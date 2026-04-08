// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/notification_vo.dart';
import '../vo/notification_vo.dart';


part 'notifications_response_vo.freezed.dart';
part 'notifications_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NotificationsResponseVo with _$NotificationsResponseVo {
  NotificationsResponseVo._();

  factory NotificationsResponseVo({
     String? code,
     String? message,
     List<NotificationVo>? promotions,
     List<NotificationVo>? messages,
    
  }) = _NotificationsResponseVo;
  
  factory NotificationsResponseVo.fromJson(Map<String, dynamic> json) => _$NotificationsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "promotions" : NotificationVo.toExampleApiJson(),
  //   "messages" : NotificationVo.toExampleApiJson(),
  //   
  // };
}