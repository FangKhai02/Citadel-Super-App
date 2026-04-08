// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationsResponse _$NotificationsResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationsResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationsResponse {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<NotificationVo>? get promotions => throw _privateConstructorUsedError;
  set promotions(List<NotificationVo>? value) =>
      throw _privateConstructorUsedError;
  List<NotificationVo>? get messages => throw _privateConstructorUsedError;
  set messages(List<NotificationVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsResponseCopyWith<NotificationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsResponseCopyWith<$Res> {
  factory $NotificationsResponseCopyWith(NotificationsResponse value,
          $Res Function(NotificationsResponse) then) =
      _$NotificationsResponseCopyWithImpl<$Res, NotificationsResponse>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<NotificationVo>? promotions,
      List<NotificationVo>? messages});
}

/// @nodoc
class _$NotificationsResponseCopyWithImpl<$Res,
        $Val extends NotificationsResponse>
    implements $NotificationsResponseCopyWith<$Res> {
  _$NotificationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? promotions = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      promotions: freezed == promotions
          ? _value.promotions
          : promotions // ignore: cast_nullable_to_non_nullable
              as List<NotificationVo>?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<NotificationVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsResponseImplCopyWith<$Res>
    implements $NotificationsResponseCopyWith<$Res> {
  factory _$$NotificationsResponseImplCopyWith(
          _$NotificationsResponseImpl value,
          $Res Function(_$NotificationsResponseImpl) then) =
      __$$NotificationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<NotificationVo>? promotions,
      List<NotificationVo>? messages});
}

/// @nodoc
class __$$NotificationsResponseImplCopyWithImpl<$Res>
    extends _$NotificationsResponseCopyWithImpl<$Res,
        _$NotificationsResponseImpl>
    implements _$$NotificationsResponseImplCopyWith<$Res> {
  __$$NotificationsResponseImplCopyWithImpl(_$NotificationsResponseImpl _value,
      $Res Function(_$NotificationsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? promotions = freezed,
    Object? messages = freezed,
  }) {
    return _then(_$NotificationsResponseImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      promotions: freezed == promotions
          ? _value.promotions
          : promotions // ignore: cast_nullable_to_non_nullable
              as List<NotificationVo>?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<NotificationVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsResponseImpl extends _NotificationsResponse {
  _$NotificationsResponseImpl(
      {this.code, this.message, this.promotions, this.messages})
      : super._();

  factory _$NotificationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsResponseImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<NotificationVo>? promotions;
  @override
  List<NotificationVo>? messages;

  @override
  String toString() {
    return 'NotificationsResponse(code: $code, message: $message, promotions: $promotions, messages: $messages)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsResponseImplCopyWith<_$NotificationsResponseImpl>
      get copyWith => __$$NotificationsResponseImplCopyWithImpl<
          _$NotificationsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationsResponse extends NotificationsResponse {
  factory _NotificationsResponse(
      {String? code,
      String? message,
      List<NotificationVo>? promotions,
      List<NotificationVo>? messages}) = _$NotificationsResponseImpl;
  _NotificationsResponse._() : super._();

  factory _NotificationsResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationsResponseImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<NotificationVo>? get promotions;
  set promotions(List<NotificationVo>? value);
  @override
  List<NotificationVo>? get messages;
  set messages(List<NotificationVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$NotificationsResponseImplCopyWith<_$NotificationsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
