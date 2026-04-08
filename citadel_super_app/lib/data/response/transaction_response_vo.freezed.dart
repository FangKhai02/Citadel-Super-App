// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionResponseVo _$TransactionResponseVoFromJson(
    Map<String, dynamic> json) {
  return _TransactionResponseVo.fromJson(json);
}

/// @nodoc
mixin _$TransactionResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<TransactionVo>? get transactions => throw _privateConstructorUsedError;
  set transactions(List<TransactionVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionResponseVoCopyWith<TransactionResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionResponseVoCopyWith<$Res> {
  factory $TransactionResponseVoCopyWith(TransactionResponseVo value,
          $Res Function(TransactionResponseVo) then) =
      _$TransactionResponseVoCopyWithImpl<$Res, TransactionResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<TransactionVo>? transactions});
}

/// @nodoc
class _$TransactionResponseVoCopyWithImpl<$Res,
        $Val extends TransactionResponseVo>
    implements $TransactionResponseVoCopyWith<$Res> {
  _$TransactionResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? transactions = freezed,
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
      transactions: freezed == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionResponseVoImplCopyWith<$Res>
    implements $TransactionResponseVoCopyWith<$Res> {
  factory _$$TransactionResponseVoImplCopyWith(
          _$TransactionResponseVoImpl value,
          $Res Function(_$TransactionResponseVoImpl) then) =
      __$$TransactionResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<TransactionVo>? transactions});
}

/// @nodoc
class __$$TransactionResponseVoImplCopyWithImpl<$Res>
    extends _$TransactionResponseVoCopyWithImpl<$Res,
        _$TransactionResponseVoImpl>
    implements _$$TransactionResponseVoImplCopyWith<$Res> {
  __$$TransactionResponseVoImplCopyWithImpl(_$TransactionResponseVoImpl _value,
      $Res Function(_$TransactionResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? transactions = freezed,
  }) {
    return _then(_$TransactionResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      transactions: freezed == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionResponseVoImpl extends _TransactionResponseVo {
  _$TransactionResponseVoImpl({this.code, this.message, this.transactions})
      : super._();

  factory _$TransactionResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<TransactionVo>? transactions;

  @override
  String toString() {
    return 'TransactionResponseVo(code: $code, message: $message, transactions: $transactions)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionResponseVoImplCopyWith<_$TransactionResponseVoImpl>
      get copyWith => __$$TransactionResponseVoImplCopyWithImpl<
          _$TransactionResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionResponseVoImplToJson(
      this,
    );
  }
}

abstract class _TransactionResponseVo extends TransactionResponseVo {
  factory _TransactionResponseVo(
      {String? code,
      String? message,
      List<TransactionVo>? transactions}) = _$TransactionResponseVoImpl;
  _TransactionResponseVo._() : super._();

  factory _TransactionResponseVo.fromJson(Map<String, dynamic> json) =
      _$TransactionResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<TransactionVo>? get transactions;
  set transactions(List<TransactionVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$TransactionResponseVoImplCopyWith<_$TransactionResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
