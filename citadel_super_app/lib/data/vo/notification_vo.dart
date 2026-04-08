// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'notification_vo.freezed.dart';
part 'notification_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NotificationVo with _$NotificationVo {
  NotificationVo._();

  factory NotificationVo({
     int? id, 
     String? oneSignalNotificationId, 
     String? type, 
     String? title, 
     String? message, 
     List<String>? imageUrls, 
     String? launchUrl, 
     int? createdAt, 
     bool? hasRead, 
    
  }) = _NotificationVo;
  
  factory NotificationVo.fromJson(Map<String, dynamic> json) => _$NotificationVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "oneSignalNotificationId" : 'string',
  //   "type" : 'string',
  //   "title" : 'string',
  //   "message" : 'string',
  //   "imageUrls" : 'string',
  //   "launchUrl" : 'string',
  //   "createdAt" : 0,
  //   "hasRead" : false,
  //   
  // };
}