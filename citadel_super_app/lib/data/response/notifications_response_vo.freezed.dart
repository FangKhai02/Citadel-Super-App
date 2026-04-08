// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationsResponseVo _$NotificationsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _NotificationsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$NotificationsResponseVo {
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
  $NotificationsResponseVoCopyWith<NotificationsResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsResponseVoCopyWith<$Res> {
  factory $NotificationsResponseVoCopyWith(NotificationsResponseVo value,
          $Res Function(NotificationsResponseVo) then) =
      _$NotificationsResponseVoCopyWithImpl<$Res, NotificationsResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<NotificationVo>? promotions,
      List<NotificationVo>? messages});
}

/// @nodoc
class _$NotificationsResponseVoCopyWithImpl<$Res,
        $Val extends NotificationsResponseVo>
    implements $NotificationsResponseVoCopyWith<$Res> {
  _$NotificationsResponseVoCopyWithImpl(this._value, this._then);

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
abstract class _$$NotificationsResponseVoImplCopyWith<$Res>
    implements $NotificationsResponseVoCopyWith<$Res> {
  factory _$$NotificationsResponseVoImplCopyWith(
          _$NotificationsResponseVoImpl value,
          $Res Function(_$NotificationsResponseVoImpl) then) =
      __$$NotificationsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<NotificationVo>? promotions,
      List<NotificationVo>? messages});
}

/// @nodoc
class __$$NotificationsResponseVoImplCopyWithImpl<$Res>
    extends _$NotificationsResponseVoCopyWithImpl<$Res,
        _$NotificationsResponseVoImpl>
    implements _$$NotificationsResponseVoImplCopyWith<$Res> {
  __$$NotificationsResponseVoImplCopyWithImpl(
      _$NotificationsResponseVoImpl _value,
      $Res Function(_$NotificationsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? promotions = freezed,
    Object? messages = freezed,
  }) {
    return _then(_$NotificationsResponseVoImpl(
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
class _$NotificationsResponseVoImpl extends _NotificationsResponseVo {
  _$NotificationsResponseVoImpl(
      {this.code, this.message, this.promotions, this.messages})
      : super._();

  factory _$NotificationsResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsResponseVoImplFromJson(json);

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
    return 'NotificationsResponseVo(code: $code, message: $message, promotions: $promotions, messages: $messages)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsResponseVoImplCopyWith<_$NotificationsResponseVoImpl>
      get copyWith => __$$NotificationsResponseVoImplCopyWithImpl<
          _$NotificationsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _NotificationsResponseVo extends NotificationsResponseVo {
  factory _NotificationsResponseVo(
      {String? code,
      String? message,
      List<NotificationVo>? promotions,
      List<NotificationVo>? messages}) = _$NotificationsResponseVoImpl;
  _NotificationsResponseVo._() : super._();

  factory _NotificationsResponseVo.fromJson(Map<String, dynamic> json) =
      _$NotificationsResponseVoImpl.fromJson;

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
  _$$NotificationsResponseVoImplCopyWith<_$NotificationsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
