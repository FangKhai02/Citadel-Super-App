// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncNotificationRequestImpl _$$SyncNotificationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SyncNotificationRequestImpl(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => SyncNotificationVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SyncNotificationRequestImplToJson(
        _$SyncNotificationRequestImpl instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };
