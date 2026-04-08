// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_profile_image_add_edit_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentProfileImageAddEditRequestVo _$AgentProfileImageAddEditRequestVoFromJson(
    Map<String, dynamic> json) {
  return _AgentProfileImageAddEditRequestVo.fromJson(json);
}

/// @nodoc
mixin _$AgentProfileImageAddEditRequestVo {
  String? get profilePicture => throw _privateConstructorUsedError;
  set profilePicture(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentProfileImageAddEditRequestVoCopyWith<AgentProfileImageAddEditRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentProfileImageAddEditRequestVoCopyWith<$Res> {
  factory $AgentProfileImageAddEditRequestVoCopyWith(
          AgentProfileImageAddEditRequestVo value,
          $Res Function(AgentProfileImageAddEditRequestVo) then) =
      _$AgentProfileImageAddEditRequestVoCopyWithImpl<$Res,
          AgentProfileImageAddEditRequestVo>;
  @useResult
  $Res call({String? profilePicture});
}

/// @nodoc
class _$AgentProfileImageAddEditRequestVoCopyWithImpl<$Res,
        $Val extends AgentProfileImageAddEditRequestVo>
    implements $AgentProfileImageAddEditRequestVoCopyWith<$Res> {
  _$AgentProfileImageAddEditRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
  }) {
    return _then(_value.copyWith(
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentProfileImageAddEditRequestVoImplCopyWith<$Res>
    implements $AgentProfileImageAddEditRequestVoCopyWith<$Res> {
  factory _$$AgentProfileImageAddEditRequestVoImplCopyWith(
          _$AgentProfileImageAddEditRequestVoImpl value,
          $Res Function(_$AgentProfileImageAddEditRequestVoImpl) then) =
      __$$AgentProfileImageAddEditRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? profilePicture});
}

/// @nodoc
class __$$AgentProfileImageAddEditRequestVoImplCopyWithImpl<$Res>
    extends _$AgentProfileImageAddEditRequestVoCopyWithImpl<$Res,
        _$AgentProfileImageAddEditRequestVoImpl>
    implements _$$AgentProfileImageAddEditRequestVoImplCopyWith<$Res> {
  __$$AgentProfileImageAddEditRequestVoImplCopyWithImpl(
      _$AgentProfileImageAddEditRequestVoImpl _value,
      $Res Function(_$AgentProfileImageAddEditRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
  }) {
    return _then(_$AgentProfileImageAddEditRequestVoImpl(
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentProfileImageAddEditRequestVoImpl
    extends _AgentProfileImageAddEditRequestVo {
  _$AgentProfileImageAddEditRequestVoImpl({this.profilePicture}) : super._();

  factory _$AgentProfileImageAddEditRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentProfileImageAddEditRequestVoImplFromJson(json);

  @override
  String? profilePicture;

  @override
  String toString() {
    return 'AgentProfileImageAddEditRequestVo(profilePicture: $profilePicture)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentProfileImageAddEditRequestVoImplCopyWith<
          _$AgentProfileImageAddEditRequestVoImpl>
      get copyWith => __$$AgentProfileImageAddEditRequestVoImplCopyWithImpl<
          _$AgentProfileImageAddEditRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentProfileImageAddEditRequestVoImplToJson(
      this,
    );
  }
}

abstract class _AgentProfileImageAddEditRequestVo
    extends AgentProfileImageAddEditRequestVo {
  factory _AgentProfileImageAddEditRequestVo({String? profilePicture}) =
      _$AgentProfileImageAddEditRequestVoImpl;
  _AgentProfileImageAddEditRequestVo._() : super._();

  factory _AgentProfileImageAddEditRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$AgentProfileImageAddEditRequestVoImpl.fromJson;

  @override
  String? get profilePicture;
  set profilePicture(String? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentProfileImageAddEditRequestVoImplCopyWith<
          _$AgentProfileImageAddEditRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
