// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_holdings_validation_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShareHoldingsValidationRequestVo _$ShareHoldingsValidationRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ShareHoldingsValidationRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ShareHoldingsValidationRequestVo {
  List<int>? get shareHolderIds => throw _privateConstructorUsedError;
  set shareHolderIds(List<int>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShareHoldingsValidationRequestVoCopyWith<ShareHoldingsValidationRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareHoldingsValidationRequestVoCopyWith<$Res> {
  factory $ShareHoldingsValidationRequestVoCopyWith(
          ShareHoldingsValidationRequestVo value,
          $Res Function(ShareHoldingsValidationRequestVo) then) =
      _$ShareHoldingsValidationRequestVoCopyWithImpl<$Res,
          ShareHoldingsValidationRequestVo>;
  @useResult
  $Res call({List<int>? shareHolderIds});
}

/// @nodoc
class _$ShareHoldingsValidationRequestVoCopyWithImpl<$Res,
        $Val extends ShareHoldingsValidationRequestVo>
    implements $ShareHoldingsValidationRequestVoCopyWith<$Res> {
  _$ShareHoldingsValidationRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareHolderIds = freezed,
  }) {
    return _then(_value.copyWith(
      shareHolderIds: freezed == shareHolderIds
          ? _value.shareHolderIds
          : shareHolderIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareHoldingsValidationRequestVoImplCopyWith<$Res>
    implements $ShareHoldingsValidationRequestVoCopyWith<$Res> {
  factory _$$ShareHoldingsValidationRequestVoImplCopyWith(
          _$ShareHoldingsValidationRequestVoImpl value,
          $Res Function(_$ShareHoldingsValidationRequestVoImpl) then) =
      __$$ShareHoldingsValidationRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? shareHolderIds});
}

/// @nodoc
class __$$ShareHoldingsValidationRequestVoImplCopyWithImpl<$Res>
    extends _$ShareHoldingsValidationRequestVoCopyWithImpl<$Res,
        _$ShareHoldingsValidationRequestVoImpl>
    implements _$$ShareHoldingsValidationRequestVoImplCopyWith<$Res> {
  __$$ShareHoldingsValidationRequestVoImplCopyWithImpl(
      _$ShareHoldingsValidationRequestVoImpl _value,
      $Res Function(_$ShareHoldingsValidationRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareHolderIds = freezed,
  }) {
    return _then(_$ShareHoldingsValidationRequestVoImpl(
      shareHolderIds: freezed == shareHolderIds
          ? _value.shareHolderIds
          : shareHolderIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareHoldingsValidationRequestVoImpl
    extends _ShareHoldingsValidationRequestVo {
  _$ShareHoldingsValidationRequestVoImpl({this.shareHolderIds}) : super._();

  factory _$ShareHoldingsValidationRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ShareHoldingsValidationRequestVoImplFromJson(json);

  @override
  List<int>? shareHolderIds;

  @override
  String toString() {
    return 'ShareHoldingsValidationRequestVo(shareHolderIds: $shareHolderIds)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareHoldingsValidationRequestVoImplCopyWith<
          _$ShareHoldingsValidationRequestVoImpl>
      get copyWith => __$$ShareHoldingsValidationRequestVoImplCopyWithImpl<
          _$ShareHoldingsValidationRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareHoldingsValidationRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ShareHoldingsValidationRequestVo
    extends ShareHoldingsValidationRequestVo {
  factory _ShareHoldingsValidationRequestVo({List<int>? shareHolderIds}) =
      _$ShareHoldingsValidationRequestVoImpl;
  _ShareHoldingsValidationRequestVo._() : super._();

  factory _ShareHoldingsValidationRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$ShareHoldingsValidationRequestVoImpl.fromJson;

  @override
  List<int>? get shareHolderIds;
  set shareHolderIds(List<int>? value);
  @override
  @JsonKey(ignore: true)
  _$$ShareHoldingsValidationRequestVoImplCopyWith<
          _$ShareHoldingsValidationRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
