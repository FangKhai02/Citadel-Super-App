// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductListResponseVo _$ProductListResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ProductListResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ProductListResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<ProductVo>? get productList => throw _privateConstructorUsedError;
  set productList(List<ProductVo>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductListResponseVoCopyWith<ProductListResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListResponseVoCopyWith<$Res> {
  factory $ProductListResponseVoCopyWith(ProductListResponseVo value,
          $Res Function(ProductListResponseVo) then) =
      _$ProductListResponseVoCopyWithImpl<$Res, ProductListResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<ProductVo>? productList});
}

/// @nodoc
class _$ProductListResponseVoCopyWithImpl<$Res,
        $Val extends ProductListResponseVo>
    implements $ProductListResponseVoCopyWith<$Res> {
  _$ProductListResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productList = freezed,
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
      productList: freezed == productList
          ? _value.productList
          : productList // ignore: cast_nullable_to_non_nullable
              as List<ProductVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductListResponseVoImplCopyWith<$Res>
    implements $ProductListResponseVoCopyWith<$Res> {
  factory _$$ProductListResponseVoImplCopyWith(
          _$ProductListResponseVoImpl value,
          $Res Function(_$ProductListResponseVoImpl) then) =
      __$$ProductListResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<ProductVo>? productList});
}

/// @nodoc
class __$$ProductListResponseVoImplCopyWithImpl<$Res>
    extends _$ProductListResponseVoCopyWithImpl<$Res,
        _$ProductListResponseVoImpl>
    implements _$$ProductListResponseVoImplCopyWith<$Res> {
  __$$ProductListResponseVoImplCopyWithImpl(_$ProductListResponseVoImpl _value,
      $Res Function(_$ProductListResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productList = freezed,
  }) {
    return _then(_$ProductListResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      productList: freezed == productList
          ? _value.productList
          : productList // ignore: cast_nullable_to_non_nullable
              as List<ProductVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductListResponseVoImpl extends _ProductListResponseVo {
  _$ProductListResponseVoImpl({this.code, this.message, this.productList})
      : super._();

  factory _$ProductListResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductListResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<ProductVo>? productList;

  @override
  String toString() {
    return 'ProductListResponseVo(code: $code, message: $message, productList: $productList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListResponseVoImplCopyWith<_$ProductListResponseVoImpl>
      get copyWith => __$$ProductListResponseVoImplCopyWithImpl<
          _$ProductListResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductListResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ProductListResponseVo extends ProductListResponseVo {
  factory _ProductListResponseVo(
      {String? code,
      String? message,
      List<ProductVo>? productList}) = _$ProductListResponseVoImpl;
  _ProductListResponseVo._() : super._();

  factory _ProductListResponseVo.fromJson(Map<String, dynamic> json) =
      _$ProductListResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<ProductVo>? get productList;
  set productList(List<ProductVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductListResponseVoImplCopyWith<_$ProductListResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
