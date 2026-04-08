// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncNotificationVoImpl _$$SyncNotificationVoImplFromJson(
        Map<String, dynamic> json) =>
    _$SyncNotificationVoImpl(
      oneSignalNotificationId: json['oneSignalNotificationId'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      launchUrl: json['launchUrl'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SyncNotificationVoImplToJson(
        _$SyncNotificationVoImpl instance) =>
    <String, dynamic>{
      'oneSignalNotificationId': instance.oneSignalNotificationId,
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'imageUrls': instance.imageUrls,
      'launchUrl': instance.launchUrl,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt,
    };
