// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incremental_amount_list_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IncrementalAmountListResponseVo _$IncrementalAmountListResponseVoFromJson(
    Map<String, dynamic> json) {
  return _IncrementalAmountListResponseVo.fromJson(json);
}

/// @nodoc
mixin _$IncrementalAmountListResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<double>? get amountList => throw _privateConstructorUsedError;
  set amountList(List<double>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncrementalAmountListResponseVoCopyWith<IncrementalAmountListResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncrementalAmountListResponseVoCopyWith<$Res> {
  factory $IncrementalAmountListResponseVoCopyWith(
          IncrementalAmountListResponseVo value,
          $Res Function(IncrementalAmountListResponseVo) then) =
      _$IncrementalAmountListResponseVoCopyWithImpl<$Res,
          IncrementalAmountListResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<double>? amountList});
}

/// @nodoc
class _$IncrementalAmountListResponseVoCopyWithImpl<$Res,
        $Val extends IncrementalAmountListResponseVo>
    implements $IncrementalAmountListResponseVoCopyWith<$Res> {
  _$IncrementalAmountListResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? amountList = freezed,
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
      amountList: freezed == amountList
          ? _value.amountList
          : amountList // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncrementalAmountListResponseVoImplCopyWith<$Res>
    implements $IncrementalAmountListResponseVoCopyWith<$Res> {
  factory _$$IncrementalAmountListResponseVoImplCopyWith(
          _$IncrementalAmountListResponseVoImpl value,
          $Res Function(_$IncrementalAmountListResponseVoImpl) then) =
      __$$IncrementalAmountListResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<double>? amountList});
}

/// @nodoc
class __$$IncrementalAmountListResponseVoImplCopyWithImpl<$Res>
    extends _$IncrementalAmountListResponseVoCopyWithImpl<$Res,
        _$IncrementalAmountListResponseVoImpl>
    implements _$$IncrementalAmountListResponseVoImplCopyWith<$Res> {
  __$$IncrementalAmountListResponseVoImplCopyWithImpl(
      _$IncrementalAmountListResponseVoImpl _value,
      $Res Function(_$IncrementalAmountListResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? amountList = freezed,
  }) {
    return _then(_$IncrementalAmountListResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      amountList: freezed == amountList
          ? _value.amountList
          : amountList // ignore: cast_nullable_to_non_nullable
              as List<double>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncrementalAmountListResponseVoImpl
    extends _IncrementalAmountListResponseVo {
  _$IncrementalAmountListResponseVoImpl(
      {this.code, this.message, this.amountList})
      : super._();

  factory _$IncrementalAmountListResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$IncrementalAmountListResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<double>? amountList;

  @override
  String toString() {
    return 'IncrementalAmountListResponseVo(code: $code, message: $message, amountList: $amountList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncrementalAmountListResponseVoImplCopyWith<
          _$IncrementalAmountListResponseVoImpl>
      get copyWith => __$$IncrementalAmountListResponseVoImplCopyWithImpl<
          _$IncrementalAmountListResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncrementalAmountListResponseVoImplToJson(
      this,
    );
  }
}

abstract class _IncrementalAmountListResponseVo
    extends IncrementalAmountListResponseVo {
  factory _IncrementalAmountListResponseVo(
      {String? code,
      String? message,
      List<double>? amountList}) = _$IncrementalAmountListResponseVoImpl;
  _IncrementalAmountListResponseVo._() : super._();

  factory _IncrementalAmountListResponseVo.fromJson(Map<String, dynamic> json) =
      _$IncrementalAmountListResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<double>? get amountList;
  set amountList(List<double>? value);
  @override
  @JsonKey(ignore: true)
  _$$IncrementalAmountListResponseVoImplCopyWith<
          _$IncrementalAmountListResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
