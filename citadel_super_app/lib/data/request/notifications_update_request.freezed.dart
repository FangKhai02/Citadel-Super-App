// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationsUpdateRequest _$NotificationsUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return _NotificationsUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$NotificationsUpdateRequest {
  List<int>? get promotionIds => throw _privateConstructorUsedError;
  set promotionIds(List<int>? value) => throw _privateConstructorUsedError;
  List<int>? get messagesIds => throw _privateConstructorUsedError;
  set messagesIds(List<int>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsUpdateRequestCopyWith<NotificationsUpdateRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsUpdateRequestCopyWith<$Res> {
  factory $NotificationsUpdateRequestCopyWith(NotificationsUpdateRequest value,
          $Res Function(NotificationsUpdateRequest) then) =
      _$NotificationsUpdateRequestCopyWithImpl<$Res,
          NotificationsUpdateRequest>;
  @useResult
  $Res call({List<int>? promotionIds, List<int>? messagesIds});
}

/// @nodoc
class _$NotificationsUpdateRequestCopyWithImpl<$Res,
        $Val extends NotificationsUpdateRequest>
    implements $NotificationsUpdateRequestCopyWith<$Res> {
  _$NotificationsUpdateRequestCopyWithImpl(this._value, this._then);

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
abstract class _$$NotificationsUpdateRequestImplCopyWith<$Res>
    implements $NotificationsUpdateRequestCopyWith<$Res> {
  factory _$$NotificationsUpdateRequestImplCopyWith(
          _$NotificationsUpdateRequestImpl value,
          $Res Function(_$NotificationsUpdateRequestImpl) then) =
      __$$NotificationsUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? promotionIds, List<int>? messagesIds});
}

/// @nodoc
class __$$NotificationsUpdateRequestImplCopyWithImpl<$Res>
    extends _$NotificationsUpdateRequestCopyWithImpl<$Res,
        _$NotificationsUpdateRequestImpl>
    implements _$$NotificationsUpdateRequestImplCopyWith<$Res> {
  __$$NotificationsUpdateRequestImplCopyWithImpl(
      _$NotificationsUpdateRequestImpl _value,
      $Res Function(_$NotificationsUpdateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promotionIds = freezed,
    Object? messagesIds = freezed,
  }) {
    return _then(_$NotificationsUpdateRequestImpl(
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
class _$NotificationsUpdateRequestImpl extends _NotificationsUpdateRequest {
  _$NotificationsUpdateRequestImpl({this.promotionIds, this.messagesIds})
      : super._();

  factory _$NotificationsUpdateRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationsUpdateRequestImplFromJson(json);

  @override
  List<int>? promotionIds;
  @override
  List<int>? messagesIds;

  @override
  String toString() {
    return 'NotificationsUpdateRequest(promotionIds: $promotionIds, messagesIds: $messagesIds)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsUpdateRequestImplCopyWith<_$NotificationsUpdateRequestImpl>
      get copyWith => __$$NotificationsUpdateRequestImplCopyWithImpl<
          _$NotificationsUpdateRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _NotificationsUpdateRequest extends NotificationsUpdateRequest {
  factory _NotificationsUpdateRequest(
      {List<int>? promotionIds,
      List<int>? messagesIds}) = _$NotificationsUpdateRequestImpl;
  _NotificationsUpdateRequest._() : super._();

  factory _NotificationsUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$NotificationsUpdateRequestImpl.fromJson;

  @override
  List<int>? get promotionIds;
  set promotionIds(List<int>? value);
  @override
  List<int>? get messagesIds;
  set messagesIds(List<int>? value);
  @override
  @JsonKey(ignore: true)
  _$$NotificationsUpdateRequestImplCopyWith<_$NotificationsUpdateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
