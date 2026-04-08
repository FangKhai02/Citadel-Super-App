// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_update_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationsUpdateRequestVo _$NotificationsUpdateRequestVoFromJson(
    Map<String, dynamic> json) {
  return _NotificationsUpdateRequestVo.fromJson(json);
}

/// @nodoc
mixin _$NotificationsUpdateRequestVo {
  List<int>? get promotionIds => throw _privateConstructorUsedError;
  set promotionIds(List<int>? value) => throw _privateConstructorUsedError;
  List<int>? get messagesIds => throw _privateConstructorUsedError;
  set messagesIds(List<int>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsUpdateRequestVoCopyWith<NotificationsUpdateRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsUpdateRequestVoCopyWith<$Res> {
  factory $NotificationsUpdateRequestVoCopyWith(
          NotificationsUpdateRequestVo value,
          $Res Function(NotificationsUpdateRequestVo) then) =
      _$NotificationsUpdateRequestVoCopyWithImpl<$Res,
          NotificationsUpdateRequestVo>;
  @useResult
  $Res call({List<int>? promotionIds, List<int>? messagesIds});
}

/// @nodoc
class _$NotificationsUpdateRequestVoCopyWithImpl<$Res,
        $Val extends NotificationsUpdateRequestVo>
    implements $NotificationsUpdateRequestVoCopyWith<$Res> {
  _$NotificationsUpdateRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionIds = freezed,
    Object? messagesIds = freezed,
  }) {
    return _then(_value.copyWith(
      promotionIds: freezed == promotionIds
          ? _value.promotionIds
          : promotionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      messagesIds: freezed == messagesIds
          ? _value.messagesIds
          : messagesIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsUpdateRequestVoImplCopyWith<$Res>
    implements $NotificationsUpdateRequestVoCopyWith<$Res> {
  factory _$$NotificationsUpdateRequestVoImplCopyWith(
          _$NotificationsUpdateRequestVoImpl value,
          $Res Function(_$NotificationsUpdateRequestVoImpl) then) =
      __$$NotificationsUpdateRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? promotionIds, List<int>? messagesIds});
}

/// @nodoc
class __$$NotificationsUpdateRequestVoImplCopyWithImpl<$Res>
    extends _$NotificationsUpdateRequestVoCopyWithImpl<$Res,
        _$NotificationsUpdateRequestVoImpl>
    implements _$$NotificationsUpdateRequestVoImplCopyWith<$Res> {
  __$$NotificationsUpdateRequestVoImplCopyWithImpl(
      _$NotificationsUpdateRequestVoImpl _value,
      $Res Function(_$NotificationsUpdateRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionIds = freezed,
    Object? messagesIds = freezed,
  }) {
    return _then(_$NotificationsUpdateRequestVoImpl(
      promotionIds: freezed == promotionIds
          ? _value.promotionIds
          : promotionIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      messagesIds: freezed == messagesIds
          ? _value.messagesIds
          : messagesIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsUpdateRequestVoImpl extends _NotificationsUpdateRequestVo {
  _$NotificationsUpdateRequestVoImpl({this.promotionIds, this.messagesIds})
      : super._();

  factory _$NotificationsUpdateRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationsUpdateRequestVoImplFromJson(json);

  @override
  List<int>? promotionIds;
  @override
  List<int>? messagesIds;

  @override
  String toString() {
    return 'NotificationsUpdateRequestVo(promotionIds: $promotionIds, messagesIds: $messagesIds)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsUpdateRequestVoImplCopyWith<
          _$NotificationsUpdateRequestVoImpl>
      get copyWith => __$$NotificationsUpdateRequestVoImplCopyWithImpl<
          _$NotificationsUpdateRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsUpdateRequestVoImplToJson(
      this,
    );
  }
}

abstract class _NotificationsUpdateRequestVo
    extends NotificationsUpdateRequestVo {
  factory _NotificationsUpdateRequestVo(
      {List<int>? promotionIds,
      List<int>? messagesIds}) = _$NotificationsUpdateRequestVoImpl;
  _NotificationsUpdateRequestVo._() : super._();

  factory _NotificationsUpdateRequestVo.fromJson(Map<String, dynamic> json) =
      _$NotificationsUpdateRequestVoImpl.fromJson;

  @override
  List<int>? get promotionIds;
  set promotionIds(List<int>? value);
  @override
  List<int>? get messagesIds;
  set messagesIds(List<int>? value);
  @override
  @JsonKey(ignore: true)
  _$$NotificationsUpdateRequestVoImplCopyWith<
          _$NotificationsUpdateRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
