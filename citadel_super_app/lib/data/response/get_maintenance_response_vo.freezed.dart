// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_maintenance_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetMaintenanceResponseVo _$GetMaintenanceResponseVoFromJson(
    Map<String, dynamic> json) {
  return _GetMaintenanceResponseVo.fromJson(json);
}

/// @nodoc
mixin _$GetMaintenanceResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  String? get startDatetime => throw _privateConstructorUsedError;
  set startDatetime(String? value) => throw _privateConstructorUsedError;
  String? get endDatetime => throw _privateConstructorUsedError;
  set endDatetime(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetMaintenanceResponseVoCopyWith<GetMaintenanceResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetMaintenanceResponseVoCopyWith<$Res> {
  factory $GetMaintenanceResponseVoCopyWith(GetMaintenanceResponseVo value,
          $Res Function(GetMaintenanceResponseVo) then) =
      _$GetMaintenanceResponseVoCopyWithImpl<$Res, GetMaintenanceResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? startDatetime,
      String? endDatetime});
}

/// @nodoc
class _$GetMaintenanceResponseVoCopyWithImpl<$Res,
        $Val extends GetMaintenanceResponseVo>
    implements $GetMaintenanceResponseVoCopyWith<$Res> {
  _$GetMaintenanceResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? startDatetime = freezed,
    Object? endDatetime = freezed,
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
      startDatetime: freezed == startDatetime
          ? _value.startDatetime
          : startDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      endDatetime: freezed == endDatetime
          ? _value.endDatetime
          : endDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetMaintenanceResponseVoImplCopyWith<$Res>
    implements $GetMaintenanceResponseVoCopyWith<$Res> {
  factory _$$GetMaintenanceResponseVoImplCopyWith(
          _$GetMaintenanceResponseVoImpl value,
          $Res Function(_$GetMaintenanceResponseVoImpl) then) =
      __$$GetMaintenanceResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? startDatetime,
      String? endDatetime});
}

/// @nodoc
class __$$GetMaintenanceResponseVoImplCopyWithImpl<$Res>
    extends _$GetMaintenanceResponseVoCopyWithImpl<$Res,
        _$GetMaintenanceResponseVoImpl>
    implements _$$GetMaintenanceResponseVoImplCopyWith<$Res> {
  __$$GetMaintenanceResponseVoImplCopyWithImpl(
      _$GetMaintenanceResponseVoImpl _value,
      $Res Function(_$GetMaintenanceResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? startDatetime = freezed,
    Object? endDatetime = freezed,
  }) {
    return _then(_$GetMaintenanceResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      startDatetime: freezed == startDatetime
          ? _value.startDatetime
          : startDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
      endDatetime: freezed == endDatetime
          ? _value.endDatetime
          : endDatetime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetMaintenanceResponseVoImpl extends _GetMaintenanceResponseVo {
  _$GetMaintenanceResponseVoImpl(
      {this.code, this.message, this.startDatetime, this.endDatetime})
      : super._();

  factory _$GetMaintenanceResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetMaintenanceResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  String? startDatetime;
  @override
  String? endDatetime;

  @override
  String toString() {
    return 'GetMaintenanceResponseVo(code: $code, message: $message, startDatetime: $startDatetime, endDatetime: $endDatetime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetMaintenanceResponseVoImplCopyWith<_$GetMaintenanceResponseVoImpl>
      get copyWith => __$$GetMaintenanceResponseVoImplCopyWithImpl<
          _$GetMaintenanceResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetMaintenanceResponseVoImplToJson(
      this,
    );
  }
}

abstract class _GetMaintenanceResponseVo extends GetMaintenanceResponseVo {
  factory _GetMaintenanceResponseVo(
      {String? code,
      String? message,
      String? startDatetime,
      String? endDatetime}) = _$GetMaintenanceResponseVoImpl;
  _GetMaintenanceResponseVo._() : super._();

  factory _GetMaintenanceResponseVo.fromJson(Map<String, dynamic> json) =
      _$GetMaintenanceResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  String? get startDatetime;
  set startDatetime(String? value);
  @override
  String? get endDatetime;
  set endDatetime(String? value);
  @override
  @JsonKey(ignore: true)
  _$$GetMaintenanceResponseVoImplCopyWith<_$GetMaintenanceResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
