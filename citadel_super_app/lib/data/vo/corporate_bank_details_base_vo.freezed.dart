// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_bank_details_base_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateBankDetailsBaseVo _$CorporateBankDetailsBaseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateBankDetailsBaseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateBankDetailsBaseVo {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  set bankName(String? value) => throw _privateConstructorUsedError;
  String? get bankAccountHolderName => throw _privateConstructorUsedError;
  set bankAccountHolderName(String? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateBankDetailsBaseVoCopyWith<CorporateBankDetailsBaseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateBankDetailsBaseVoCopyWith<$Res> {
  factory $CorporateBankDetailsBaseVoCopyWith(CorporateBankDetailsBaseVo value,
          $Res Function(CorporateBankDetailsBaseVo) then) =
      _$CorporateBankDetailsBaseVoCopyWithImpl<$Res,
          CorporateBankDetailsBaseVo>;
  @useResult
  $Res call({int? id, String? bankName, String? bankAccountHolderName});
}

/// @nodoc
class _$CorporateBankDetailsBaseVoCopyWithImpl<$Res,
        $Val extends CorporateBankDetailsBaseVo>
    implements $CorporateBankDetailsBaseVoCopyWith<$Res> {
  _$CorporateBankDetailsBaseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? bankName = freezed,
    Object? bankAccountHolderName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountHolderName: freezed == bankAccountHolderName
          ? _value.bankAccountHolderName
          : bankAccountHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateBankDetailsBaseVoImplCopyWith<$Res>
    implements $CorporateBankDetailsBaseVoCopyWith<$Res> {
  factory _$$CorporateBankDetailsBaseVoImplCopyWith(
          _$CorporateBankDetailsBaseVoImpl value,
          $Res Function(_$CorporateBankDetailsBaseVoImpl) then) =
      __$$CorporateBankDetailsBaseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? bankName, String? bankAccountHolderName});
}

/// @nodoc
class __$$CorporateBankDetailsBaseVoImplCopyWithImpl<$Res>
    extends _$CorporateBankDetailsBaseVoCopyWithImpl<$Res,
        _$CorporateBankDetailsBaseVoImpl>
    implements _$$CorporateBankDetailsBaseVoImplCopyWith<$Res> {
  __$$CorporateBankDetailsBaseVoImplCopyWithImpl(
      _$CorporateBankDetailsBaseVoImpl _value,
      $Res Function(_$CorporateBankDetailsBaseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? bankName = freezed,
    Object? bankAccountHolderName = freezed,
  }) {
    return _then(_$CorporateBankDetailsBaseVoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountHolderName: freezed == bankAccountHolderName
          ? _value.bankAccountHolderName
          : bankAccountHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateBankDetailsBaseVoImpl extends _CorporateBankDetailsBaseVo {
  _$CorporateBankDetailsBaseVoImpl(
      {this.id, this.bankName, this.bankAccountHolderName})
      : super._();

  factory _$CorporateBankDetailsBaseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateBankDetailsBaseVoImplFromJson(json);

  @override
  int? id;
  @override
  String? bankName;
  @override
  String? bankAccountHolderName;

  @override
  String toString() {
    return 'CorporateBankDetailsBaseVo(id: $id, bankName: $bankName, bankAccountHolderName: $bankAccountHolderName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateBankDetailsBaseVoImplCopyWith<_$CorporateBankDetailsBaseVoImpl>
      get copyWith => __$$CorporateBankDetailsBaseVoImplCopyWithImpl<
          _$CorporateBankDetailsBaseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateBankDetailsBaseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateBankDetailsBaseVo extends CorporateBankDetailsBaseVo {
  factory _CorporateBankDetailsBaseVo(
      {int? id,
      String? bankName,
      String? bankAccountHolderName}) = _$CorporateBankDetailsBaseVoImpl;
  _CorporateBankDetailsBaseVo._() : super._();

  factory _CorporateBankDetailsBaseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateBankDetailsBaseVoImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String? get bankName;
  set bankName(String? value);
  @override
  String? get bankAccountHolderName;
  set bankAccountHolderName(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateBankDetailsBaseVoImplCopyWith<_$CorporateBankDetailsBaseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
