// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'niu_get_document_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NiuGetDocumentVo _$NiuGetDocumentVoFromJson(Map<String, dynamic> json) {
  return _NiuGetDocumentVo.fromJson(json);
}

/// @nodoc
mixin _$NiuGetDocumentVo {
  String? get filename => throw _privateConstructorUsedError;
  set filename(String? value) => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  set url(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NiuGetDocumentVoCopyWith<NiuGetDocumentVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NiuGetDocumentVoCopyWith<$Res> {
  factory $NiuGetDocumentVoCopyWith(
          NiuGetDocumentVo value, $Res Function(NiuGetDocumentVo) then) =
      _$NiuGetDocumentVoCopyWithImpl<$Res, NiuGetDocumentVo>;
  @useResult
  $Res call({String? filename, String? url});
}

/// @nodoc
class _$NiuGetDocumentVoCopyWithImpl<$Res, $Val extends NiuGetDocumentVo>
    implements $NiuGetDocumentVoCopyWith<$Res> {
  _$NiuGetDocumentVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NiuGetDocumentVoImplCopyWith<$Res>
    implements $NiuGetDocumentVoCopyWith<$Res> {
  factory _$$NiuGetDocumentVoImplCopyWith(_$NiuGetDocumentVoImpl value,
          $Res Function(_$NiuGetDocumentVoImpl) then) =
      __$$NiuGetDocumentVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? filename, String? url});
}

/// @nodoc
class __$$NiuGetDocumentVoImplCopyWithImpl<$Res>
    extends _$NiuGetDocumentVoCopyWithImpl<$Res, _$NiuGetDocumentVoImpl>
    implements _$$NiuGetDocumentVoImplCopyWith<$Res> {
  __$$NiuGetDocumentVoImplCopyWithImpl(_$NiuGetDocumentVoImpl _value,
      $Res Function(_$NiuGetDocumentVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = freezed,
    Object? url = freezed,
  }) {
    return _then(_$NiuGetDocumentVoImpl(
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NiuGetDocumentVoImpl extends _NiuGetDocumentVo {
  _$NiuGetDocumentVoImpl({this.filename, this.url}) : super._();

  factory _$NiuGetDocumentVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NiuGetDocumentVoImplFromJson(json);

  @override
  String? filename;
  @override
  String? url;

  @override
  String toString() {
    return 'NiuGetDocumentVo(filename: $filename, url: $url)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NiuGetDocumentVoImplCopyWith<_$NiuGetDocumentVoImpl> get copyWith =>
      __$$NiuGetDocumentVoImplCopyWithImpl<_$NiuGetDocumentVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NiuGetDocumentVoImplToJson(
      this,
    );
  }
}

abstract class _NiuGetDocumentVo extends NiuGetDocumentVo {
  factory _NiuGetDocumentVo({String? filename, String? url}) =
      _$NiuGetDocumentVoImpl;
  _NiuGetDocumentVo._() : super._();

  factory _NiuGetDocumentVo.fromJson(Map<String, dynamic> json) =
      _$NiuGetDocumentVoImpl.fromJson;

  @override
  String? get filename;
  set filename(String? value);
  @override
  String? get url;
  set url(String? value);
  @override
  @JsonKey(ignore: true)
  _$$NiuGetDocumentVoImplCopyWith<_$NiuGetDocumentVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
