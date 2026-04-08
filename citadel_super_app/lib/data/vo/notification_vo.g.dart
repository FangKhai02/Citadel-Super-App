// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationVoImpl _$$NotificationVoImplFromJson(Map<String, dynamic> json) =>
    _$NotificationVoImpl(
      id: (json['id'] as num?)?.toInt(),
      oneSignalNotificationId: json['oneSignalNotificationId'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      launchUrl: json['launchUrl'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      hasRead: json['hasRead'] as bool?,
    );

Map<String, dynamic> _$$NotificationVoImplToJson(
        _$NotificationVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oneSignalNotificationId': instance.oneSignalNotificationId,
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'imageUrls': instance.imageUrls,
      'launchUrl': instance.launchUrl,
      'createdAt': instance.createdAt,
      'hasRead': instance.hasRead,
    };
