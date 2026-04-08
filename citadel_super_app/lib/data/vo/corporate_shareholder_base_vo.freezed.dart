// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_shareholder_base_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateShareholderBaseVo _$CorporateShareholderBaseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateShareholderBaseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateShareholderBaseVo {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  double? get percentageOfShareholdings => throw _privateConstructorUsedError;
  set percentageOfShareholdings(double? value) =>
      throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  set status(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateShareholderBaseVoCopyWith<CorporateShareholderBaseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateShareholderBaseVoCopyWith<$Res> {
  factory $CorporateShareholderBaseVoCopyWith(CorporateShareholderBaseVo value,
          $Res Function(CorporateShareholderBaseVo) then) =
      _$CorporateShareholderBaseVoCopyWithImpl<$Res,
          CorporateShareholderBaseVo>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      double? percentageOfShareholdings,
      String? status});
}

/// @nodoc
class _$CorporateShareholderBaseVoCopyWithImpl<$Res,
        $Val extends CorporateShareholderBaseVo>
    implements $CorporateShareholderBaseVoCopyWith<$Res> {
  _$CorporateShareholderBaseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? percentageOfShareholdings = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      percentageOfShareholdings: freezed == percentageOfShareholdings
          ? _value.percentageOfShareholdings
          : percentageOfShareholdings // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateShareholderBaseVoImplCopyWith<$Res>
    implements $CorporateShareholderBaseVoCopyWith<$Res> {
  factory _$$CorporateShareholderBaseVoImplCopyWith(
          _$CorporateShareholderBaseVoImpl value,
          $Res Function(_$CorporateShareholderBaseVoImpl) then) =
      __$$CorporateShareholderBaseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      double? percentageOfShareholdings,
      String? status});
}

/// @nodoc
class __$$CorporateShareholderBaseVoImplCopyWithImpl<$Res>
    extends _$CorporateShareholderBaseVoCopyWithImpl<$Res,
        _$CorporateShareholderBaseVoImpl>
    implements _$$CorporateShareholderBaseVoImplCopyWith<$Res> {
  __$$CorporateShareholderBaseVoImplCopyWithImpl(
      _$CorporateShareholderBaseVoImpl _value,
      $Res Function(_$CorporateShareholderBaseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? percentageOfShareholdings = freezed,
    Object? status = freezed,
  }) {
    return _then(_$CorporateShareholderBaseVoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      percentageOfShareholdings: freezed == percentageOfShareholdings
          ? _value.percentageOfShareholdings
          : percentageOfShareholdings // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateShareholderBaseVoImpl extends _CorporateShareholderBaseVo {
  _$CorporateShareholderBaseVoImpl(
      {this.id, this.name, this.percentageOfShareholdings, this.status})
      : super._();

  factory _$CorporateShareholderBaseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateShareholderBaseVoImplFromJson(json);

  @override
  int? id;
  @override
  String? name;
  @override
  double? percentageOfShareholdings;
  @override
  String? status;

  @override
  String toString() {
    return 'CorporateShareholderBaseVo(id: $id, name: $name, percentageOfShareholdings: $percentageOfShareholdings, status: $status)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateShareholderBaseVoImplCopyWith<_$CorporateShareholderBaseVoImpl>
      get copyWith => __$$CorporateShareholderBaseVoImplCopyWithImpl<
          _$CorporateShareholderBaseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateShareholderBaseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateShareholderBaseVo extends CorporateShareholderBaseVo {
  factory _CorporateShareholderBaseVo(
      {int? id,
      String? name,
      double? percentageOfShareholdings,
      String? status}) = _$CorporateShareholderBaseVoImpl;
  _CorporateShareholderBaseVo._() : super._();

  factory _CorporateShareholderBaseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateShareholderBaseVoImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String? get name;
  set name(String? value);
  @override
  double? get percentageOfShareholdings;
  set percentageOfShareholdings(double? value);
  @override
  String? get status;
  set status(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateShareholderBaseVoImplCopyWith<_$CorporateShareholderBaseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
