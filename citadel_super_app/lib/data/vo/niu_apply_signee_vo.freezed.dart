// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'niu_apply_signee_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NiuApplySigneeVo _$NiuApplySigneeVoFromJson(Map<String, dynamic> json) {
  return _NiuApplySigneeVo.fromJson(json);
}

/// @nodoc
mixin _$NiuApplySigneeVo {
  String? get fullName => throw _privateConstructorUsedError;
  set fullName(String? value) => throw _privateConstructorUsedError;
  String? get nric => throw _privateConstructorUsedError;
  set nric(String? value) => throw _privateConstructorUsedError;
  int? get signedDate => throw _privateConstructorUsedError;
  set signedDate(int? value) => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  set signature(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NiuApplySigneeVoCopyWith<NiuApplySigneeVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NiuApplySigneeVoCopyWith<$Res> {
  factory $NiuApplySigneeVoCopyWith(
          NiuApplySigneeVo value, $Res Function(NiuApplySigneeVo) then) =
      _$NiuApplySigneeVoCopyWithImpl<$Res, NiuApplySigneeVo>;
  @useResult
  $Res call(
      {String? fullName, String? nric, int? signedDate, String? signature});
}

/// @nodoc
class _$NiuApplySigneeVoCopyWithImpl<$Res, $Val extends NiuApplySigneeVo>
    implements $NiuApplySigneeVoCopyWith<$Res> {
  _$NiuApplySigneeVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? nric = freezed,
    Object? signedDate = freezed,
    Object? signature = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      nric: freezed == nric
          ? _value.nric
          : nric // ignore: cast_nullable_to_non_nullable
              as String?,
      signedDate: freezed == signedDate
          ? _value.signedDate
          : signedDate // ignore: cast_nullable_to_non_nullable
              as int?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NiuApplySigneeVoImplCopyWith<$Res>
    implements $NiuApplySigneeVoCopyWith<$Res> {
  factory _$$NiuApplySigneeVoImplCopyWith(_$NiuApplySigneeVoImpl value,
          $Res Function(_$NiuApplySigneeVoImpl) then) =
      __$$NiuApplySigneeVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? fullName, String? nric, int? signedDate, String? signature});
}

/// @nodoc
class __$$NiuApplySigneeVoImplCopyWithImpl<$Res>
    extends _$NiuApplySigneeVoCopyWithImpl<$Res, _$NiuApplySigneeVoImpl>
    implements _$$NiuApplySigneeVoImplCopyWith<$Res> {
  __$$NiuApplySigneeVoImplCopyWithImpl(_$NiuApplySigneeVoImpl _value,
      $Res Function(_$NiuApplySigneeVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = freezed,
    Object? nric = freezed,
    Object? signedDate = freezed,
    Object? signature = freezed,
  }) {
    return _then(_$NiuApplySigneeVoImpl(
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      nric: freezed == nric
          ? _value.nric
          : nric // ignore: cast_nullable_to_non_nullable
              as String?,
      signedDate: freezed == signedDate
          ? _value.signedDate
          : signedDate // ignore: cast_nullable_to_non_nullable
              as int?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NiuApplySigneeVoImpl extends _NiuApplySigneeVo {
  _$NiuApplySigneeVoImpl(
      {this.fullName, this.nric, this.signedDate, this.signature})
      : super._();

  factory _$NiuApplySigneeVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NiuApplySigneeVoImplFromJson(json);

  @override
  String? fullName;
  @override
  String? nric;
  @override
  int? signedDate;
  @override
  String? signature;

  @override
  String toString() {
    return 'NiuApplySigneeVo(fullName: $fullName, nric: $nric, signedDate: $signedDate, signature: $signature)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NiuApplySigneeVoImplCopyWith<_$NiuApplySigneeVoImpl> get copyWith =>
      __$$NiuApplySigneeVoImplCopyWithImpl<_$NiuApplySigneeVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NiuApplySigneeVoImplToJson(
      this,
    );
  }
}

abstract class _NiuApplySigneeVo extends NiuApplySigneeVo {
  factory _NiuApplySigneeVo(
      {String? fullName,
      String? nric,
      int? signedDate,
      String? signature}) = _$NiuApplySigneeVoImpl;
  _NiuApplySigneeVo._() : super._();

  factory _NiuApplySigneeVo.fromJson(Map<String, dynamic> json) =
      _$NiuApplySigneeVoImpl.fromJson;

  @override
  String? get fullName;
  set fullName(String? value);
  @override
  String? get nric;
  set nric(String? value);
  @override
  int? get signedDate;
  set signedDate(int? value);
  @override
  String? get signature;
  set signature(String? value);
  @override
  @JsonKey(ignore: true)
  _$$NiuApplySigneeVoImplCopyWith<_$NiuApplySigneeVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
