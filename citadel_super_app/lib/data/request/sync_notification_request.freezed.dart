// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_notification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SyncNotificationRequest _$SyncNotificationRequestFromJson(
    Map<String, dynamic> json) {
  return _SyncNotificationRequest.fromJson(json);
}

/// @nodoc
mixin _$SyncNotificationRequest {
  List<SyncNotificationVo>? get notifications =>
      throw _privateConstructorUsedError;
  set notifications(List<SyncNotificationVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SyncNotificationRequestCopyWith<SyncNotificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncNotificationRequestCopyWith<$Res> {
  factory $SyncNotificationRequestCopyWith(SyncNotificationRequest value,
          $Res Function(SyncNotificationRequest) then) =
      _$SyncNotificationRequestCopyWithImpl<$Res, SyncNotificationRequest>;
  @useResult
  $Res call({List<SyncNotificationVo>? notifications});
}

/// @nodoc
class _$SyncNotificationRequestCopyWithImpl<$Res,
        $Val extends SyncNotificationRequest>
    implements $SyncNotificationRequestCopyWith<$Res> {
  _$SyncNotificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = freezed,
  }) {
    return _then(_value.copyWith(
      notifications: freezed == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<SyncNotificationVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncNotificationRequestImplCopyWith<$Res>
    implements $SyncNotificationRequestCopyWith<$Res> {
  factory _$$SyncNotificationRequestImplCopyWith(
          _$SyncNotificationRequestImpl value,
          $Res Function(_$SyncNotificationRequestImpl) then) =
      __$$SyncNotificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SyncNotificationVo>? notifications});
}

/// @nodoc
class __$$SyncNotificationRequestImplCopyWithImpl<$Res>
    extends _$SyncNotificationRequestCopyWithImpl<$Res,
        _$SyncNotificationRequestImpl>
    implements _$$SyncNotificationRequestImplCopyWith<$Res> {
  __$$SyncNotificationRequestImplCopyWithImpl(
      _$SyncNotificationRequestImpl _value,
      $Res Function(_$SyncNotificationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = freezed,
  }) {
    return _then(_$SyncNotificationRequestImpl(
      notifications: freezed == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<SyncNotificationVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncNotificationRequestImpl extends _SyncNotificationRequest {
  _$SyncNotificationRequestImpl({this.notifications}) : super._();

  factory _$SyncNotificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncNotificationRequestImplFromJson(json);

  @override
  List<SyncNotificationVo>? notifications;

  @override
  String toString() {
    return 'SyncNotificationRequest(notifications: $notifications)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncNotificationRequestImplCopyWith<_$SyncNotificationRequestImpl>
      get copyWith => __$$SyncNotificationRequestImplCopyWithImpl<
          _$SyncNotificationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncNotificationRequestImplToJson(
      this,
    );
  }
}

abstract class _SyncNotificationRequest extends SyncNotificationRequest {
  factory _SyncNotificationRequest({List<SyncNotificationVo>? notifications}) =
      _$SyncNotificationRequestImpl;
  _SyncNotificationRequest._() : super._();

  factory _SyncNotificationRequest.fromJson(Map<String, dynamic> json) =
      _$SyncNotificationRequestImpl.fromJson;

  @override
  List<SyncNotificationVo>? get notifications;
  set notifications(List<SyncNotificationVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$SyncNotificationRequestImplCopyWith<_$SyncNotificationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
