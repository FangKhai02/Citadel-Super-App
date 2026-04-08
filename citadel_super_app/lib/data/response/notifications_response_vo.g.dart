// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationsResponseVoImpl _$$NotificationsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      promotions: (json['promotions'] as List<dynamic>?)
          ?.map((e) => NotificationVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => NotificationVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NotificationsResponseVoImplToJson(
        _$NotificationsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'promotions': instance.promotions,
      'messages': instance.messages,
    };
