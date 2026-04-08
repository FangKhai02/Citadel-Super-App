// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_update_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationsUpdateRequestVoImpl _$$NotificationsUpdateRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsUpdateRequestVoImpl(
      promotionIds: (json['promotionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      messagesIds: (json['messagesIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$NotificationsUpdateRequestVoImplToJson(
        _$NotificationsUpdateRequestVoImpl instance) =>
    <String, dynamic>{
      'promotionIds': instance.promotionIds,
      'messagesIds': instance.messagesIds,
    };
