// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reallocatable_product_codes_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReallocatableProductCodesResponseVo
    _$ReallocatableProductCodesResponseVoFromJson(Map<String, dynamic> json) {
  return _ReallocatableProductCodesResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ReallocatableProductCodesResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<String>? get productCodes => throw _privateConstructorUsedError;
  set productCodes(List<String>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReallocatableProductCodesResponseVoCopyWith<
          ReallocatableProductCodesResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReallocatableProductCodesResponseVoCopyWith<$Res> {
  factory $ReallocatableProductCodesResponseVoCopyWith(
          ReallocatableProductCodesResponseVo value,
          $Res Function(ReallocatableProductCodesResponseVo) then) =
      _$ReallocatableProductCodesResponseVoCopyWithImpl<$Res,
          ReallocatableProductCodesResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<String>? productCodes});
}

/// @nodoc
class _$ReallocatableProductCodesResponseVoCopyWithImpl<$Res,
        $Val extends ReallocatableProductCodesResponseVo>
    implements $ReallocatableProductCodesResponseVoCopyWith<$Res> {
  _$ReallocatableProductCodesResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productCodes = freezed,
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
      productCodes: freezed == productCodes
          ? _value.productCodes
          : productCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReallocatableProductCodesResponseVoImplCopyWith<$Res>
    implements $ReallocatableProductCodesResponseVoCopyWith<$Res> {
  factory _$$ReallocatableProductCodesResponseVoImplCopyWith(
          _$ReallocatableProductCodesResponseVoImpl value,
          $Res Function(_$ReallocatableProductCodesResponseVoImpl) then) =
      __$$ReallocatableProductCodesResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<String>? productCodes});
}

/// @nodoc
class __$$ReallocatableProductCodesResponseVoImplCopyWithImpl<$Res>
    extends _$ReallocatableProductCodesResponseVoCopyWithImpl<$Res,
        _$ReallocatableProductCodesResponseVoImpl>
    implements _$$ReallocatableProductCodesResponseVoImplCopyWith<$Res> {
  __$$ReallocatableProductCodesResponseVoImplCopyWithImpl(
      _$ReallocatableProductCodesResponseVoImpl _value,
      $Res Function(_$ReallocatableProductCodesResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productCodes = freezed,
  }) {
    return _then(_$ReallocatableProductCodesResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      productCodes: freezed == productCodes
          ? _value.productCodes
          : productCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReallocatableProductCodesResponseVoImpl
    extends _ReallocatableProductCodesResponseVo {
  _$ReallocatableProductCodesResponseVoImpl(
      {this.code, this.message, this.productCodes})
      : super._();

  factory _$ReallocatableProductCodesResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReallocatableProductCodesResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<String>? productCodes;

  @override
  String toString() {
    return 'ReallocatableProductCodesResponseVo(code: $code, message: $message, productCodes: $productCodes)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReallocatableProductCodesResponseVoImplCopyWith<
          _$ReallocatableProductCodesResponseVoImpl>
      get copyWith => __$$ReallocatableProductCodesResponseVoImplCopyWithImpl<
          _$ReallocatableProductCodesResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReallocatableProductCodesResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ReallocatableProductCodesResponseVo
    extends ReallocatableProductCodesResponseVo {
  factory _ReallocatableProductCodesResponseVo(
      {String? code,
      String? message,
      List<String>? productCodes}) = _$ReallocatableProductCodesResponseVoImpl;
  _ReallocatableProductCodesResponseVo._() : super._();

  factory _ReallocatableProductCodesResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$ReallocatableProductCodesResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<String>? get productCodes;
  set productCodes(List<String>? value);
  @override
  @JsonKey(ignore: true)
  _$$ReallocatableProductCodesResponseVoImplCopyWith<
          _$ReallocatableProductCodesResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
