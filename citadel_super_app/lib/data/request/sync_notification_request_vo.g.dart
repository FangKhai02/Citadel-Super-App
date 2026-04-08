// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_notification_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncNotificationRequestVoImpl _$$SyncNotificationRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$SyncNotificationRequestVoImpl(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => SyncNotificationVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SyncNotificationRequestVoImplToJson(
        _$SyncNotificationRequestVoImpl instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };
