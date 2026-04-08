// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_shareholder_add_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateShareholderAddRequestVo _$CorporateShareholderAddRequestVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateShareholderAddRequestVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateShareholderAddRequestVo {
  List<CorporateShareHolderAddVo>? get shareHolders =>
      throw _privateConstructorUsedError;
  set shareHolders(List<CorporateShareHolderAddVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateShareholderAddRequestVoCopyWith<CorporateShareholderAddRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateShareholderAddRequestVoCopyWith<$Res> {
  factory $CorporateShareholderAddRequestVoCopyWith(
          CorporateShareholderAddRequestVo value,
          $Res Function(CorporateShareholderAddRequestVo) then) =
      _$CorporateShareholderAddRequestVoCopyWithImpl<$Res,
          CorporateShareholderAddRequestVo>;
  @useResult
  $Res call({List<CorporateShareHolderAddVo>? shareHolders});
}

/// @nodoc
class _$CorporateShareholderAddRequestVoCopyWithImpl<$Res,
        $Val extends CorporateShareholderAddRequestVo>
    implements $CorporateShareholderAddRequestVoCopyWith<$Res> {
  _$CorporateShareholderAddRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareHolders = freezed,
  }) {
    return _then(_value.copyWith(
      shareHolders: freezed == shareHolders
          ? _value.shareHolders
          : shareHolders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareHolderAddVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateShareholderAddRequestVoImplCopyWith<$Res>
    implements $CorporateShareholderAddRequestVoCopyWith<$Res> {
  factory _$$CorporateShareholderAddRequestVoImplCopyWith(
          _$CorporateShareholderAddRequestVoImpl value,
          $Res Function(_$CorporateShareholderAddRequestVoImpl) then) =
      __$$CorporateShareholderAddRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CorporateShareHolderAddVo>? shareHolders});
}

/// @nodoc
class __$$CorporateShareholderAddRequestVoImplCopyWithImpl<$Res>
    extends _$CorporateShareholderAddRequestVoCopyWithImpl<$Res,
        _$CorporateShareholderAddRequestVoImpl>
    implements _$$CorporateShareholderAddRequestVoImplCopyWith<$Res> {
  __$$CorporateShareholderAddRequestVoImplCopyWithImpl(
      _$CorporateShareholderAddRequestVoImpl _value,
      $Res Function(_$CorporateShareholderAddRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareHolders = freezed,
  }) {
    return _then(_$CorporateShareholderAddRequestVoImpl(
      shareHolders: freezed == shareHolders
          ? _value.shareHolders
          : shareHolders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareHolderAddVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateShareholderAddRequestVoImpl
    extends _CorporateShareholderAddRequestVo {
  _$CorporateShareholderAddRequestVoImpl({this.shareHolders}) : super._();

  factory _$CorporateShareholderAddRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateShareholderAddRequestVoImplFromJson(json);

  @override
  List<CorporateShareHolderAddVo>? shareHolders;

  @override
  String toString() {
    return 'CorporateShareholderAddRequestVo(shareHolders: $shareHolders)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateShareholderAddRequestVoImplCopyWith<
          _$CorporateShareholderAddRequestVoImpl>
      get copyWith => __$$CorporateShareholderAddRequestVoImplCopyWithImpl<
          _$CorporateShareholderAddRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateShareholderAddRequestVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateShareholderAddRequestVo
    extends CorporateShareholderAddRequestVo {
  factory _CorporateShareholderAddRequestVo(
          {List<CorporateShareHolderAddVo>? shareHolders}) =
      _$CorporateShareholderAddRequestVoImpl;
  _CorporateShareholderAddRequestVo._() : super._();

  factory _CorporateShareholderAddRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$CorporateShareholderAddRequestVoImpl.fromJson;

  @override
  List<CorporateShareHolderAddVo>? get shareHolders;
  set shareHolders(List<CorporateShareHolderAddVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateShareholderAddRequestVoImplCopyWith<
          _$CorporateShareholderAddRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
