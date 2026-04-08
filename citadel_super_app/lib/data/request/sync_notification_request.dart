// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/sync_notification_vo.dart';

part 'sync_notification_request.freezed.dart';
part 'sync_notification_request.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class SyncNotificationRequest with _$SyncNotificationRequest {
  SyncNotificationRequest._();

  factory SyncNotificationRequest({
    List<SyncNotificationVo>? notifications,
  }) = _SyncNotificationRequest;

  factory SyncNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SyncNotificationRequestFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'notifications' : SyncNotificationVo.toExampleApiJson(),

  // };
}
