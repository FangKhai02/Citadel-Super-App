// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pep_declaration_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PepDeclarationVo _$PepDeclarationVoFromJson(Map<String, dynamic> json) {
  return _PepDeclarationVo.fromJson(json);
}

/// @nodoc
mixin _$PepDeclarationVo {
  bool? get isPep => throw _privateConstructorUsedError;
  set isPep(bool? value) => throw _privateConstructorUsedError;
  PepDeclarationOptionsVo? get pepDeclarationOptions =>
      throw _privateConstructorUsedError;
  set pepDeclarationOptions(PepDeclarationOptionsVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PepDeclarationVoCopyWith<PepDeclarationVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PepDeclarationVoCopyWith<$Res> {
  factory $PepDeclarationVoCopyWith(
          PepDeclarationVo value, $Res Function(PepDeclarationVo) then) =
      _$PepDeclarationVoCopyWithImpl<$Res, PepDeclarationVo>;
  @useResult
  $Res call({bool? isPep, PepDeclarationOptionsVo? pepDeclarationOptions});

  $PepDeclarationOptionsVoCopyWith<$Res>? get pepDeclarationOptions;
}

/// @nodoc
class _$PepDeclarationVoCopyWithImpl<$Res, $Val extends PepDeclarationVo>
    implements $PepDeclarationVoCopyWith<$Res> {
  _$PepDeclarationVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPep = freezed,
    Object? pepDeclarationOptions = freezed,
  }) {
    return _then(_value.copyWith(
      isPep: freezed == isPep
          ? _value.isPep
          : isPep // ignore: cast_nullable_to_non_nullable
              as bool?,
      pepDeclarationOptions: freezed == pepDeclarationOptions
          ? _value.pepDeclarationOptions
          : pepDeclarationOptions // ignore: cast_nullable_to_non_nullable
              as PepDeclarationOptionsVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PepDeclarationOptionsVoCopyWith<$Res>? get pepDeclarationOptions {
    if (_value.pepDeclarationOptions == null) {
      return null;
    }

    return $PepDeclarationOptionsVoCopyWith<$Res>(_value.pepDeclarationOptions!,
        (value) {
      return _then(_value.copyWith(pepDeclarationOptions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PepDeclarationVoImplCopyWith<$Res>
    implements $PepDeclarationVoCopyWith<$Res> {
  factory _$$PepDeclarationVoImplCopyWith(_$PepDeclarationVoImpl value,
          $Res Function(_$PepDeclarationVoImpl) then) =
      __$$PepDeclarationVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? isPep, PepDeclarationOptionsVo? pepDeclarationOptions});

  @override
  $PepDeclarationOptionsVoCopyWith<$Res>? get pepDeclarationOptions;
}

/// @nodoc
class __$$PepDeclarationVoImplCopyWithImpl<$Res>
    extends _$PepDeclarationVoCopyWithImpl<$Res, _$PepDeclarationVoImpl>
    implements _$$PepDeclarationVoImplCopyWith<$Res> {
  __$$PepDeclarationVoImplCopyWithImpl(_$PepDeclarationVoImpl _value,
      $Res Function(_$PepDeclarationVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPep = freezed,
    Object? pepDeclarationOptions = freezed,
  }) {
    return _then(_$PepDeclarationVoImpl(
      isPep: freezed == isPep
          ? _value.isPep
          : isPep // ignore: cast_nullable_to_non_nullable
              as bool?,
      pepDeclarationOptions: freezed == pepDeclarationOptions
          ? _value.pepDeclarationOptions
          : pepDeclarationOptions // ignore: cast_nullable_to_non_nullable
              as PepDeclarationOptionsVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PepDeclarationVoImpl extends _PepDeclarationVo {
  _$PepDeclarationVoImpl({this.isPep, this.pepDeclarationOptions}) : super._();

  factory _$PepDeclarationVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PepDeclarationVoImplFromJson(json);

  @override
  bool? isPep;
  @override
  PepDeclarationOptionsVo? pepDeclarationOptions;

  @override
  String toString() {
    return 'PepDeclarationVo(isPep: $isPep, pepDeclarationOptions: $pepDeclarationOptions)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PepDeclarationVoImplCopyWith<_$PepDeclarationVoImpl> get copyWith =>
      __$$PepDeclarationVoImplCopyWithImpl<_$PepDeclarationVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PepDeclarationVoImplToJson(
      this,
    );
  }
}

abstract class _PepDeclarationVo extends PepDeclarationVo {
  factory _PepDeclarationVo(
      {bool? isPep,
      PepDeclarationOptionsVo? pepDeclarationOptions}) = _$PepDeclarationVoImpl;
  _PepDeclarationVo._() : super._();

  factory _PepDeclarationVo.fromJson(Map<String, dynamic> json) =
      _$PepDeclarationVoImpl.fromJson;

  @override
  bool? get isPep;
  set isPep(bool? value);
  @override
  PepDeclarationOptionsVo? get pepDeclarationOptions;
  set pepDeclarationOptions(PepDeclarationOptionsVo? value);
  @override
  @JsonKey(ignore: true)
  _$$PepDeclarationVoImplCopyWith<_$PepDeclarationVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
