// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_pin_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientPinRequestVo _$ClientPinRequestVoFromJson(Map<String, dynamic> json) {
  return _ClientPinRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ClientPinRequestVo {
  String? get newPin => throw _privateConstructorUsedError;
  set newPin(String? value) => throw _privateConstructorUsedError;
  String? get oldPin => throw _privateConstructorUsedError;
  set oldPin(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientPinRequestVoCopyWith<ClientPinRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientPinRequestVoCopyWith<$Res> {
  factory $ClientPinRequestVoCopyWith(
          ClientPinRequestVo value, $Res Function(ClientPinRequestVo) then) =
      _$ClientPinRequestVoCopyWithImpl<$Res, ClientPinRequestVo>;
  @useResult
  $Res call({String? newPin, String? oldPin});
}

/// @nodoc
class _$ClientPinRequestVoCopyWithImpl<$Res, $Val extends ClientPinRequestVo>
    implements $ClientPinRequestVoCopyWith<$Res> {
  _$ClientPinRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPin = freezed,
    Object? oldPin = freezed,
  }) {
    return _then(_value.copyWith(
      newPin: freezed == newPin
          ? _value.newPin
          : newPin // ignore: cast_nullable_to_non_nullable
              as String?,
      oldPin: freezed == oldPin
          ? _value.oldPin
          : oldPin // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientPinRequestVoImplCopyWith<$Res>
    implements $ClientPinRequestVoCopyWith<$Res> {
  factory _$$ClientPinRequestVoImplCopyWith(_$ClientPinRequestVoImpl value,
          $Res Function(_$ClientPinRequestVoImpl) then) =
      __$$ClientPinRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? newPin, String? oldPin});
}

/// @nodoc
class __$$ClientPinRequestVoImplCopyWithImpl<$Res>
    extends _$ClientPinRequestVoCopyWithImpl<$Res, _$ClientPinRequestVoImpl>
    implements _$$ClientPinRequestVoImplCopyWith<$Res> {
  __$$ClientPinRequestVoImplCopyWithImpl(_$ClientPinRequestVoImpl _value,
      $Res Function(_$ClientPinRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPin = freezed,
    Object? oldPin = freezed,
  }) {
    return _then(_$ClientPinRequestVoImpl(
      newPin: freezed == newPin
          ? _value.newPin
          : newPin // ignore: cast_nullable_to_non_nullable
              as String?,
      oldPin: freezed == oldPin
          ? _value.oldPin
          : oldPin // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientPinRequestVoImpl extends _ClientPinRequestVo {
  _$ClientPinRequestVoImpl({this.newPin, this.oldPin}) : super._();

  factory _$ClientPinRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientPinRequestVoImplFromJson(json);

  @override
  String? newPin;
  @override
  String? oldPin;

  @override
  String toString() {
    return 'ClientPinRequestVo(newPin: $newPin, oldPin: $oldPin)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientPinRequestVoImplCopyWith<_$ClientPinRequestVoImpl> get copyWith =>
      __$$ClientPinRequestVoImplCopyWithImpl<_$ClientPinRequestVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientPinRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ClientPinRequestVo extends ClientPinRequestVo {
  factory _ClientPinRequestVo({String? newPin, String? oldPin}) =
      _$ClientPinRequestVoImpl;
  _ClientPinRequestVo._() : super._();

  factory _ClientPinRequestVo.fromJson(Map<String, dynamic> json) =
      _$ClientPinRequestVoImpl.fromJson;

  @override
  String? get newPin;
  set newPin(String? value);
  @override
  String? get oldPin;
  set oldPin(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientPinRequestVoImplCopyWith<_$ClientPinRequestVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
