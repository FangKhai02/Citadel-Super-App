// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'notifications_update_request_vo.freezed.dart';
part 'notifications_update_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NotificationsUpdateRequestVo with _$NotificationsUpdateRequestVo {
  NotificationsUpdateRequestVo._();

  factory NotificationsUpdateRequestVo({
     List<int>? promotionIds,
     List<int>? messagesIds,
    
  }) = _NotificationsUpdateRequestVo;
  
  factory NotificationsUpdateRequestVo.fromJson(Map<String, dynamic> json) => _$NotificationsUpdateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'promotionIds' : int.toExampleApiJson(),
  //   'messagesIds' : int.toExampleApiJson(),
  //   
  // };
}