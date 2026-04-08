// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_update_request.freezed.dart';
part 'notifications_update_request.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class NotificationsUpdateRequest with _$NotificationsUpdateRequest {
  NotificationsUpdateRequest._();

  factory NotificationsUpdateRequest({
    List<int>? promotionIds,
    List<int>? messagesIds,
  }) = _NotificationsUpdateRequest;

  factory NotificationsUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationsUpdateRequestFromJson(json);

  // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //       'promotionIds': int.toExampleApiJson(),
  //       'messagesIds': int.toExampleApiJson(),
  //     };
}
