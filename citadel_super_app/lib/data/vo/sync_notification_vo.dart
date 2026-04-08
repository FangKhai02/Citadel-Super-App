// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'sync_notification_vo.freezed.dart';
part 'sync_notification_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SyncNotificationVo with _$SyncNotificationVo {
  SyncNotificationVo._();

  factory SyncNotificationVo({
     String? oneSignalNotificationId, 
     String? type, 
     String? title, 
     String? message, 
     List<String>? imageUrls, 
     String? launchUrl, 
     bool? isRead, 
     int? createdAt, 
    
  }) = _SyncNotificationVo;
  
  factory SyncNotificationVo.fromJson(Map<String, dynamic> json) => _$SyncNotificationVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "oneSignalNotificationId" : 'string',
  //   "type" : 'string',
  //   "title" : 'string',
  //   "message" : 'string',
  //   "imageUrls" : 'string',
  //   "launchUrl" : 'string',
  //   "isRead" : false,
  //   "createdAt" : 0,
  //   
  // };
}