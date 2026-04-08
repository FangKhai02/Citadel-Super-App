// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_documents_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateDocumentsRequestVo _$CorporateDocumentsRequestVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateDocumentsRequestVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateDocumentsRequestVo {
  List<CorporateDocumentsVo>? get corporateDocuments =>
      throw _privateConstructorUsedError;
  set corporateDocuments(List<CorporateDocumentsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateDocumentsRequestVoCopyWith<CorporateDocumentsRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateDocumentsRequestVoCopyWith<$Res> {
  factory $CorporateDocumentsRequestVoCopyWith(
          CorporateDocumentsRequestVo value,
          $Res Function(CorporateDocumentsRequestVo) then) =
      _$CorporateDocumentsRequestVoCopyWithImpl<$Res,
          CorporateDocumentsRequestVo>;
  @useResult
  $Res call({List<CorporateDocumentsVo>? corporateDocuments});
}

/// @nodoc
class _$CorporateDocumentsRequestVoCopyWithImpl<$Res,
        $Val extends CorporateDocumentsRequestVo>
    implements $CorporateDocumentsRequestVoCopyWith<$Res> {
  _$CorporateDocumentsRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateDocuments = freezed,
  }) {
    return _then(_value.copyWith(
      corporateDocuments: freezed == corporateDocuments
          ? _value.corporateDocuments
          : corporateDocuments // ignore: cast_nullable_to_non_nullable
              as List<CorporateDocumentsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateDocumentsRequestVoImplCopyWith<$Res>
    implements $CorporateDocumentsRequestVoCopyWith<$Res> {
  factory _$$CorporateDocumentsRequestVoImplCopyWith(
          _$CorporateDocumentsRequestVoImpl value,
          $Res Function(_$CorporateDocumentsRequestVoImpl) then) =
      __$$CorporateDocumentsRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CorporateDocumentsVo>? corporateDocuments});
}

/// @nodoc
class __$$CorporateDocumentsRequestVoImplCopyWithImpl<$Res>
    extends _$CorporateDocumentsRequestVoCopyWithImpl<$Res,
        _$CorporateDocumentsRequestVoImpl>
    implements _$$CorporateDocumentsRequestVoImplCopyWith<$Res> {
  __$$CorporateDocumentsRequestVoImplCopyWithImpl(
      _$CorporateDocumentsRequestVoImpl _value,
      $Res Function(_$CorporateDocumentsRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateDocuments = freezed,
  }) {
    return _then(_$CorporateDocumentsRequestVoImpl(
      corporateDocuments: freezed == corporateDocuments
          ? _value.corporateDocuments
          : corporateDocuments // ignore: cast_nullable_to_non_nullable
              as List<CorporateDocumentsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateDocumentsRequestVoImpl extends _CorporateDocumentsRequestVo {
  _$CorporateDocumentsRequestVoImpl({this.corporateDocuments}) : super._();

  factory _$CorporateDocumentsRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateDocumentsRequestVoImplFromJson(json);

  @override
  List<CorporateDocumentsVo>? corporateDocuments;

  @override
  String toString() {
    return 'CorporateDocumentsRequestVo(corporateDocuments: $corporateDocuments)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateDocumentsRequestVoImplCopyWith<_$CorporateDocumentsRequestVoImpl>
      get copyWith => __$$CorporateDocumentsRequestVoImplCopyWithImpl<
          _$CorporateDocumentsRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateDocumentsRequestVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateDocumentsRequestVo
    extends CorporateDocumentsRequestVo {
  factory _CorporateDocumentsRequestVo(
          {List<CorporateDocumentsVo>? corporateDocuments}) =
      _$CorporateDocumentsRequestVoImpl;
  _CorporateDocumentsRequestVo._() : super._();

  factory _CorporateDocumentsRequestVo.fromJson(Map<String, dynamic> json) =
      _$CorporateDocumentsRequestVoImpl.fromJson;

  @override
  List<CorporateDocumentsVo>? get corporateDocuments;
  set corporateDocuments(List<CorporateDocumentsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateDocumentsRequestVoImplCopyWith<_$CorporateDocumentsRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
