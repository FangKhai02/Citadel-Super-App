// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'niu_apply_document_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NiuApplyDocumentVo _$NiuApplyDocumentVoFromJson(Map<String, dynamic> json) {
  return _NiuApplyDocumentVo.fromJson(json);
}

/// @nodoc
mixin _$NiuApplyDocumentVo {
  String? get filename => throw _privateConstructorUsedError;
  set filename(String? value) => throw _privateConstructorUsedError;
  String? get signature => throw _privateConstructorUsedError;
  set signature(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NiuApplyDocumentVoCopyWith<NiuApplyDocumentVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NiuApplyDocumentVoCopyWith<$Res> {
  factory $NiuApplyDocumentVoCopyWith(
          NiuApplyDocumentVo value, $Res Function(NiuApplyDocumentVo) then) =
      _$NiuApplyDocumentVoCopyWithImpl<$Res, NiuApplyDocumentVo>;
  @useResult
  $Res call({String? filename, String? signature});
}

/// @nodoc
class _$NiuApplyDocumentVoCopyWithImpl<$Res, $Val extends NiuApplyDocumentVo>
    implements $NiuApplyDocumentVoCopyWith<$Res> {
  _$NiuApplyDocumentVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? signature = freezed,
  }) {
    return _then(_value.copyWith(
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NiuApplyDocumentVoImplCopyWith<$Res>
    implements $NiuApplyDocumentVoCopyWith<$Res> {
  factory _$$NiuApplyDocumentVoImplCopyWith(_$NiuApplyDocumentVoImpl value,
          $Res Function(_$NiuApplyDocumentVoImpl) then) =
      __$$NiuApplyDocumentVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? filename, String? signature});
}

/// @nodoc
class __$$NiuApplyDocumentVoImplCopyWithImpl<$Res>
    extends _$NiuApplyDocumentVoCopyWithImpl<$Res, _$NiuApplyDocumentVoImpl>
    implements _$$NiuApplyDocumentVoImplCopyWith<$Res> {
  __$$NiuApplyDocumentVoImplCopyWithImpl(_$NiuApplyDocumentVoImpl _value,
      $Res Function(_$NiuApplyDocumentVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? signature = freezed,
  }) {
    return _then(_$NiuApplyDocumentVoImpl(
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      signature: freezed == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NiuApplyDocumentVoImpl extends _NiuApplyDocumentVo {
  _$NiuApplyDocumentVoImpl({this.filename, this.signature}) : super._();

  factory _$NiuApplyDocumentVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NiuApplyDocumentVoImplFromJson(json);

  @override
  String? filename;
  @override
  String? signature;

  @override
  String toString() {
    return 'NiuApplyDocumentVo(filename: $filename, signature: $signature)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NiuApplyDocumentVoImplCopyWith<_$NiuApplyDocumentVoImpl> get copyWith =>
      __$$NiuApplyDocumentVoImplCopyWithImpl<_$NiuApplyDocumentVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NiuApplyDocumentVoImplToJson(
      this,
    );
  }
}

abstract class _NiuApplyDocumentVo extends NiuApplyDocumentVo {
  factory _NiuApplyDocumentVo({String? filename, String? signature}) =
      _$NiuApplyDocumentVoImpl;
  _NiuApplyDocumentVo._() : super._();

  factory _NiuApplyDocumentVo.fromJson(Map<String, dynamic> json) =
      _$NiuApplyDocumentVoImpl.fromJson;

  @override
  String? get filename;
  set filename(String? value);
  @override
  String? get signature;
  set signature(String? value);
  @override
  @JsonKey(ignore: true)
  _$$NiuApplyDocumentVoImplCopyWith<_$NiuApplyDocumentVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
