// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pep_declaration_options_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PepDeclarationOptionsVo _$PepDeclarationOptionsVoFromJson(
    Map<String, dynamic> json) {
  return _PepDeclarationOptionsVo.fromJson(json);
}

/// @nodoc
mixin _$PepDeclarationOptionsVo {
  String? get relationship => throw _privateConstructorUsedError;
  set relationship(String? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  set position(String? value) => throw _privateConstructorUsedError;
  String? get organization => throw _privateConstructorUsedError;
  set organization(String? value) => throw _privateConstructorUsedError;
  String? get supportingDocument => throw _privateConstructorUsedError;
  set supportingDocument(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PepDeclarationOptionsVoCopyWith<PepDeclarationOptionsVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PepDeclarationOptionsVoCopyWith<$Res> {
  factory $PepDeclarationOptionsVoCopyWith(PepDeclarationOptionsVo value,
          $Res Function(PepDeclarationOptionsVo) then) =
      _$PepDeclarationOptionsVoCopyWithImpl<$Res, PepDeclarationOptionsVo>;
  @useResult
  $Res call(
      {String? relationship,
      String? name,
      String? position,
      String? organization,
      String? supportingDocument});
}

/// @nodoc
class _$PepDeclarationOptionsVoCopyWithImpl<$Res,
        $Val extends PepDeclarationOptionsVo>
    implements $PepDeclarationOptionsVoCopyWith<$Res> {
  _$PepDeclarationOptionsVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relationship = freezed,
    Object? name = freezed,
    Object? position = freezed,
    Object? organization = freezed,
    Object? supportingDocument = freezed,
  }) {
    return _then(_value.copyWith(
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      supportingDocument: freezed == supportingDocument
          ? _value.supportingDocument
          : supportingDocument // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PepDeclarationOptionsVoImplCopyWith<$Res>
    implements $PepDeclarationOptionsVoCopyWith<$Res> {
  factory _$$PepDeclarationOptionsVoImplCopyWith(
          _$PepDeclarationOptionsVoImpl value,
          $Res Function(_$PepDeclarationOptionsVoImpl) then) =
      __$$PepDeclarationOptionsVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? relationship,
      String? name,
      String? position,
      String? organization,
      String? supportingDocument});
}

/// @nodoc
class __$$PepDeclarationOptionsVoImplCopyWithImpl<$Res>
    extends _$PepDeclarationOptionsVoCopyWithImpl<$Res,
        _$PepDeclarationOptionsVoImpl>
    implements _$$PepDeclarationOptionsVoImplCopyWith<$Res> {
  __$$PepDeclarationOptionsVoImplCopyWithImpl(
      _$PepDeclarationOptionsVoImpl _value,
      $Res Function(_$PepDeclarationOptionsVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relationship = freezed,
    Object? name = freezed,
    Object? position = freezed,
    Object? organization = freezed,
    Object? supportingDocument = freezed,
  }) {
    return _then(_$PepDeclarationOptionsVoImpl(
      relationship: freezed == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      supportingDocument: freezed == supportingDocument
          ? _value.supportingDocument
          : supportingDocument // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PepDeclarationOptionsVoImpl extends _PepDeclarationOptionsVo {
  _$PepDeclarationOptionsVoImpl(
      {this.relationship,
      this.name,
      this.position,
      this.organization,
      this.supportingDocument})
      : super._();

  factory _$PepDeclarationOptionsVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PepDeclarationOptionsVoImplFromJson(json);

  @override
  String? relationship;
  @override
  String? name;
  @override
  String? position;
  @override
  String? organization;
  @override
  String? supportingDocument;

  @override
  String toString() {
    return 'PepDeclarationOptionsVo(relationship: $relationship, name: $name, position: $position, organization: $organization, supportingDocument: $supportingDocument)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PepDeclarationOptionsVoImplCopyWith<_$PepDeclarationOptionsVoImpl>
      get copyWith => __$$PepDeclarationOptionsVoImplCopyWithImpl<
          _$PepDeclarationOptionsVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PepDeclarationOptionsVoImplToJson(
      this,
    );
  }
}

abstract class _PepDeclarationOptionsVo extends PepDeclarationOptionsVo {
  factory _PepDeclarationOptionsVo(
      {String? relationship,
      String? name,
      String? position,
      String? organization,
      String? supportingDocument}) = _$PepDeclarationOptionsVoImpl;
  _PepDeclarationOptionsVo._() : super._();

  factory _PepDeclarationOptionsVo.fromJson(Map<String, dynamic> json) =
      _$PepDeclarationOptionsVoImpl.fromJson;

  @override
  String? get relationship;
  set relationship(String? value);
  @override
  String? get name;
  set name(String? value);
  @override
  String? get position;
  set position(String? value);
  @override
  String? get organization;
  set organization(String? value);
  @override
  String? get supportingDocument;
  set supportingDocument(String? value);
  @override
  @JsonKey(ignore: true)
  _$$PepDeclarationOptionsVoImplCopyWith<_$PepDeclarationOptionsVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
