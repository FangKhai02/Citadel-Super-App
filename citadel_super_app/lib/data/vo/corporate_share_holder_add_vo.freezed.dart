// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_share_holder_add_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateShareHolderAddVo _$CorporateShareHolderAddVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateShareHolderAddVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateShareHolderAddVo {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  double? get percentageOfShareholdings => throw _privateConstructorUsedError;
  set percentageOfShareholdings(double? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateShareHolderAddVoCopyWith<CorporateShareHolderAddVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateShareHolderAddVoCopyWith<$Res> {
  factory $CorporateShareHolderAddVoCopyWith(CorporateShareHolderAddVo value,
          $Res Function(CorporateShareHolderAddVo) then) =
      _$CorporateShareHolderAddVoCopyWithImpl<$Res, CorporateShareHolderAddVo>;
  @useResult
  $Res call({int? id, double? percentageOfShareholdings});
}

/// @nodoc
class _$CorporateShareHolderAddVoCopyWithImpl<$Res,
        $Val extends CorporateShareHolderAddVo>
    implements $CorporateShareHolderAddVoCopyWith<$Res> {
  _$CorporateShareHolderAddVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? percentageOfShareholdings = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      percentageOfShareholdings: freezed == percentageOfShareholdings
          ? _value.percentageOfShareholdings
          : percentageOfShareholdings // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateShareHolderAddVoImplCopyWith<$Res>
    implements $CorporateShareHolderAddVoCopyWith<$Res> {
  factory _$$CorporateShareHolderAddVoImplCopyWith(
          _$CorporateShareHolderAddVoImpl value,
          $Res Function(_$CorporateShareHolderAddVoImpl) then) =
      __$$CorporateShareHolderAddVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, double? percentageOfShareholdings});
}

/// @nodoc
class __$$CorporateShareHolderAddVoImplCopyWithImpl<$Res>
    extends _$CorporateShareHolderAddVoCopyWithImpl<$Res,
        _$CorporateShareHolderAddVoImpl>
    implements _$$CorporateShareHolderAddVoImplCopyWith<$Res> {
  __$$CorporateShareHolderAddVoImplCopyWithImpl(
      _$CorporateShareHolderAddVoImpl _value,
      $Res Function(_$CorporateShareHolderAddVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? percentageOfShareholdings = freezed,
  }) {
    return _then(_$CorporateShareHolderAddVoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      percentageOfShareholdings: freezed == percentageOfShareholdings
          ? _value.percentageOfShareholdings
          : percentageOfShareholdings // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateShareHolderAddVoImpl extends _CorporateShareHolderAddVo {
  _$CorporateShareHolderAddVoImpl({this.id, this.percentageOfShareholdings})
      : super._();

  factory _$CorporateShareHolderAddVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporateShareHolderAddVoImplFromJson(json);

  @override
  int? id;
  @override
  double? percentageOfShareholdings;

  @override
  String toString() {
    return 'CorporateShareHolderAddVo(id: $id, percentageOfShareholdings: $percentageOfShareholdings)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateShareHolderAddVoImplCopyWith<_$CorporateShareHolderAddVoImpl>
      get copyWith => __$$CorporateShareHolderAddVoImplCopyWithImpl<
          _$CorporateShareHolderAddVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateShareHolderAddVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateShareHolderAddVo extends CorporateShareHolderAddVo {
  factory _CorporateShareHolderAddVo(
      {int? id,
      double? percentageOfShareholdings}) = _$CorporateShareHolderAddVoImpl;
  _CorporateShareHolderAddVo._() : super._();

  factory _CorporateShareHolderAddVo.fromJson(Map<String, dynamic> json) =
      _$CorporateShareHolderAddVoImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  double? get percentageOfShareholdings;
  set percentageOfShareholdings(double? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateShareHolderAddVoImplCopyWith<_$CorporateShareHolderAddVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
