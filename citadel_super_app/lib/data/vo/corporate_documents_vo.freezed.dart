// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_documents_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateDocumentsVo _$CorporateDocumentsVoFromJson(Map<String, dynamic> json) {
  return _CorporateDocumentsVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateDocumentsVo {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  set fileName(String? value) => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  set file(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateDocumentsVoCopyWith<CorporateDocumentsVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateDocumentsVoCopyWith<$Res> {
  factory $CorporateDocumentsVoCopyWith(CorporateDocumentsVo value,
          $Res Function(CorporateDocumentsVo) then) =
      _$CorporateDocumentsVoCopyWithImpl<$Res, CorporateDocumentsVo>;
  @useResult
  $Res call({int? id, String? fileName, String? file});
}

/// @nodoc
class _$CorporateDocumentsVoCopyWithImpl<$Res,
        $Val extends CorporateDocumentsVo>
    implements $CorporateDocumentsVoCopyWith<$Res> {
  _$CorporateDocumentsVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = freezed,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateDocumentsVoImplCopyWith<$Res>
    implements $CorporateDocumentsVoCopyWith<$Res> {
  factory _$$CorporateDocumentsVoImplCopyWith(_$CorporateDocumentsVoImpl value,
          $Res Function(_$CorporateDocumentsVoImpl) then) =
      __$$CorporateDocumentsVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? fileName, String? file});
}

/// @nodoc
class __$$CorporateDocumentsVoImplCopyWithImpl<$Res>
    extends _$CorporateDocumentsVoCopyWithImpl<$Res, _$CorporateDocumentsVoImpl>
    implements _$$CorporateDocumentsVoImplCopyWith<$Res> {
  __$$CorporateDocumentsVoImplCopyWithImpl(_$CorporateDocumentsVoImpl _value,
      $Res Function(_$CorporateDocumentsVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = freezed,
    Object? file = freezed,
  }) {
    return _then(_$CorporateDocumentsVoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateDocumentsVoImpl extends _CorporateDocumentsVo {
  _$CorporateDocumentsVoImpl({this.id, this.fileName, this.file}) : super._();

  factory _$CorporateDocumentsVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporateDocumentsVoImplFromJson(json);

  @override
  int? id;
  @override
  String? fileName;
  @override
  String? file;

  @override
  String toString() {
    return 'CorporateDocumentsVo(id: $id, fileName: $fileName, file: $file)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateDocumentsVoImplCopyWith<_$CorporateDocumentsVoImpl>
      get copyWith =>
          __$$CorporateDocumentsVoImplCopyWithImpl<_$CorporateDocumentsVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateDocumentsVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateDocumentsVo extends CorporateDocumentsVo {
  factory _CorporateDocumentsVo({int? id, String? fileName, String? file}) =
      _$CorporateDocumentsVoImpl;
  _CorporateDocumentsVo._() : super._();

  factory _CorporateDocumentsVo.fromJson(Map<String, dynamic> json) =
      _$CorporateDocumentsVoImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String? get fileName;
  set fileName(String? value);
  @override
  String? get file;
  set file(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateDocumentsVoImplCopyWith<_$CorporateDocumentsVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
