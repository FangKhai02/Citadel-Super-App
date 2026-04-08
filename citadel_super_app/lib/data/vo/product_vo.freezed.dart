// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductVo _$ProductVoFromJson(Map<String, dynamic> json) {
  return _ProductVo.fromJson(json);
}

/// @nodoc
mixin _$ProductVo {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String? get productDescription => throw _privateConstructorUsedError;
  set productDescription(String? value) => throw _privateConstructorUsedError;
  String? get productCatalogueUrl => throw _privateConstructorUsedError;
  set productCatalogueUrl(String? value) => throw _privateConstructorUsedError;
  String? get imageOfProductUrl => throw _privateConstructorUsedError;
  set imageOfProductUrl(String? value) => throw _privateConstructorUsedError;
  bool? get isSoldOut => throw _privateConstructorUsedError;
  set isSoldOut(bool? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductVoCopyWith<ProductVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVoCopyWith<$Res> {
  factory $ProductVoCopyWith(ProductVo value, $Res Function(ProductVo) then) =
      _$ProductVoCopyWithImpl<$Res, ProductVo>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? productDescription,
      String? productCatalogueUrl,
      String? imageOfProductUrl,
      bool? isSoldOut});
}

/// @nodoc
class _$ProductVoCopyWithImpl<$Res, $Val extends ProductVo>
    implements $ProductVoCopyWith<$Res> {
  _$ProductVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? productDescription = freezed,
    Object? productCatalogueUrl = freezed,
    Object? imageOfProductUrl = freezed,
    Object? isSoldOut = freezed,
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
      productDescription: freezed == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      productCatalogueUrl: freezed == productCatalogueUrl
          ? _value.productCatalogueUrl
          : productCatalogueUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageOfProductUrl: freezed == imageOfProductUrl
          ? _value.imageOfProductUrl
          : imageOfProductUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isSoldOut: freezed == isSoldOut
          ? _value.isSoldOut
          : isSoldOut // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductVoImplCopyWith<$Res>
    implements $ProductVoCopyWith<$Res> {
  factory _$$ProductVoImplCopyWith(
          _$ProductVoImpl value, $Res Function(_$ProductVoImpl) then) =
      __$$ProductVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? productDescription,
      String? productCatalogueUrl,
      String? imageOfProductUrl,
      bool? isSoldOut});
}

/// @nodoc
class __$$ProductVoImplCopyWithImpl<$Res>
    extends _$ProductVoCopyWithImpl<$Res, _$ProductVoImpl>
    implements _$$ProductVoImplCopyWith<$Res> {
  __$$ProductVoImplCopyWithImpl(
      _$ProductVoImpl _value, $Res Function(_$ProductVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? productDescription = freezed,
    Object? productCatalogueUrl = freezed,
    Object? imageOfProductUrl = freezed,
    Object? isSoldOut = freezed,
  }) {
    return _then(_$ProductVoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      productDescription: freezed == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      productCatalogueUrl: freezed == productCatalogueUrl
          ? _value.productCatalogueUrl
          : productCatalogueUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageOfProductUrl: freezed == imageOfProductUrl
          ? _value.imageOfProductUrl
          : imageOfProductUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isSoldOut: freezed == isSoldOut
          ? _value.isSoldOut
          : isSoldOut // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVoImpl extends _ProductVo {
  _$ProductVoImpl(
      {this.id,
      this.name,
      this.productDescription,
      this.productCatalogueUrl,
      this.imageOfProductUrl,
      this.isSoldOut})
      : super._();

  factory _$ProductVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVoImplFromJson(json);

  @override
  int? id;
  @override
  String? name;
  @override
  String? productDescription;
  @override
  String? productCatalogueUrl;
  @override
  String? imageOfProductUrl;
  @override
  bool? isSoldOut;

  @override
  String toString() {
    return 'ProductVo(id: $id, name: $name, productDescription: $productDescription, productCatalogueUrl: $productCatalogueUrl, imageOfProductUrl: $imageOfProductUrl, isSoldOut: $isSoldOut)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVoImplCopyWith<_$ProductVoImpl> get copyWith =>
      __$$ProductVoImplCopyWithImpl<_$ProductVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVoImplToJson(
      this,
    );
  }
}

abstract class _ProductVo extends ProductVo {
  factory _ProductVo(
      {int? id,
      String? name,
      String? productDescription,
      String? productCatalogueUrl,
      String? imageOfProductUrl,
      bool? isSoldOut}) = _$ProductVoImpl;
  _ProductVo._() : super._();

  factory _ProductVo.fromJson(Map<String, dynamic> json) =
      _$ProductVoImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String? get name;
  set name(String? value);
  @override
  String? get productDescription;
  set productDescription(String? value);
  @override
  String? get productCatalogueUrl;
  set productCatalogueUrl(String? value);
  @override
  String? get imageOfProductUrl;
  set imageOfProductUrl(String? value);
  @override
  bool? get isSoldOut;
  set isSoldOut(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductVoImplCopyWith<_$ProductVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
