// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_profile_image_add_edit_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateProfileImageAddEditRequestVo
    _$CorporateProfileImageAddEditRequestVoFromJson(Map<String, dynamic> json) {
  return _CorporateProfileImageAddEditRequestVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateProfileImageAddEditRequestVo {
  String? get profilePicture => throw _privateConstructorUsedError;
  set profilePicture(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateProfileImageAddEditRequestVoCopyWith<
          CorporateProfileImageAddEditRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateProfileImageAddEditRequestVoCopyWith<$Res> {
  factory $CorporateProfileImageAddEditRequestVoCopyWith(
          CorporateProfileImageAddEditRequestVo value,
          $Res Function(CorporateProfileImageAddEditRequestVo) then) =
      _$CorporateProfileImageAddEditRequestVoCopyWithImpl<$Res,
          CorporateProfileImageAddEditRequestVo>;
  @useResult
  $Res call({String? profilePicture});
}

/// @nodoc
class _$CorporateProfileImageAddEditRequestVoCopyWithImpl<$Res,
        $Val extends CorporateProfileImageAddEditRequestVo>
    implements $CorporateProfileImageAddEditRequestVoCopyWith<$Res> {
  _$CorporateProfileImageAddEditRequestVoCopyWithImpl(this._value, this._then);

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
abstract class _$$CorporateProfileImageAddEditRequestVoImplCopyWith<$Res>
    implements $CorporateProfileImageAddEditRequestVoCopyWith<$Res> {
  factory _$$CorporateProfileImageAddEditRequestVoImplCopyWith(
          _$CorporateProfileImageAddEditRequestVoImpl value,
          $Res Function(_$CorporateProfileImageAddEditRequestVoImpl) then) =
      __$$CorporateProfileImageAddEditRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? profilePicture});
}

/// @nodoc
class __$$CorporateProfileImageAddEditRequestVoImplCopyWithImpl<$Res>
    extends _$CorporateProfileImageAddEditRequestVoCopyWithImpl<$Res,
        _$CorporateProfileImageAddEditRequestVoImpl>
    implements _$$CorporateProfileImageAddEditRequestVoImplCopyWith<$Res> {
  __$$CorporateProfileImageAddEditRequestVoImplCopyWithImpl(
      _$CorporateProfileImageAddEditRequestVoImpl _value,
      $Res Function(_$CorporateProfileImageAddEditRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
  }) {
    return _then(_$CorporateProfileImageAddEditRequestVoImpl(
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateProfileImageAddEditRequestVoImpl
    extends _CorporateProfileImageAddEditRequestVo {
  _$CorporateProfileImageAddEditRequestVoImpl({this.profilePicture})
      : super._();

  factory _$CorporateProfileImageAddEditRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateProfileImageAddEditRequestVoImplFromJson(json);

  @override
  String? profilePicture;

  @override
  String toString() {
    return 'CorporateProfileImageAddEditRequestVo(profilePicture: $profilePicture)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateProfileImageAddEditRequestVoImplCopyWith<
          _$CorporateProfileImageAddEditRequestVoImpl>
      get copyWith => __$$CorporateProfileImageAddEditRequestVoImplCopyWithImpl<
          _$CorporateProfileImageAddEditRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateProfileImageAddEditRequestVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateProfileImageAddEditRequestVo
    extends CorporateProfileImageAddEditRequestVo {
  factory _CorporateProfileImageAddEditRequestVo({String? profilePicture}) =
      _$CorporateProfileImageAddEditRequestVoImpl;
  _CorporateProfileImageAddEditRequestVo._() : super._();

  factory _CorporateProfileImageAddEditRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$CorporateProfileImageAddEditRequestVoImpl.fromJson;

  @override
  String? get profilePicture;
  set profilePicture(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateProfileImageAddEditRequestVoImplCopyWith<
          _$CorporateProfileImageAddEditRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
