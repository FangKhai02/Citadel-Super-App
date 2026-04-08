// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/sync_notification_vo.dart';


part 'sync_notification_request_vo.freezed.dart';
part 'sync_notification_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SyncNotificationRequestVo with _$SyncNotificationRequestVo {
  SyncNotificationRequestVo._();

  factory SyncNotificationRequestVo({
     List<SyncNotificationVo>? notifications,
    
  }) = _SyncNotificationRequestVo;
  
  factory SyncNotificationRequestVo.fromJson(Map<String, dynamic> json) => _$SyncNotificationRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'notifications' : SyncNotificationVo.toExampleApiJson(),
  //   
  // };
}