// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationsUpdateRequestImpl _$$NotificationsUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsUpdateRequestImpl(
      promotionIds: (json['promotionIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      messagesIds: (json['messagesIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$NotificationsUpdateRequestImplToJson(
        _$NotificationsUpdateRequestImpl instance) =>
    <String, dynamic>{
      'promotionIds': instance.promotionIds,
      'messagesIds': instance.messagesIds,
    };
