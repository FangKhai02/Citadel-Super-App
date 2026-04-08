// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migration_sheet_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MigrationSheetRequest _$MigrationSheetRequestFromJson(
    Map<String, dynamic> json) {
  return _MigrationSheetRequest.fromJson(json);
}

/// @nodoc
mixin _$MigrationSheetRequest {
  List<int>? get sheetIndexList => throw _privateConstructorUsedError;
  set sheetIndexList(List<int>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MigrationSheetRequestCopyWith<MigrationSheetRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MigrationSheetRequestCopyWith<$Res> {
  factory $MigrationSheetRequestCopyWith(MigrationSheetRequest value,
          $Res Function(MigrationSheetRequest) then) =
      _$MigrationSheetRequestCopyWithImpl<$Res, MigrationSheetRequest>;
  @useResult
  $Res call({List<int>? sheetIndexList});
}

/// @nodoc
class _$MigrationSheetRequestCopyWithImpl<$Res,
        $Val extends MigrationSheetRequest>
    implements $MigrationSheetRequestCopyWith<$Res> {
  _$MigrationSheetRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sheetIndexList = freezed,
  }) {
    return _then(_value.copyWith(
      sheetIndexList: freezed == sheetIndexList
          ? _value.sheetIndexList
          : sheetIndexList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MigrationSheetRequestImplCopyWith<$Res>
    implements $MigrationSheetRequestCopyWith<$Res> {
  factory _$$MigrationSheetRequestImplCopyWith(
          _$MigrationSheetRequestImpl value,
          $Res Function(_$MigrationSheetRequestImpl) then) =
      __$$MigrationSheetRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? sheetIndexList});
}

/// @nodoc
class __$$MigrationSheetRequestImplCopyWithImpl<$Res>
    extends _$MigrationSheetRequestCopyWithImpl<$Res,
        _$MigrationSheetRequestImpl>
    implements _$$MigrationSheetRequestImplCopyWith<$Res> {
  __$$MigrationSheetRequestImplCopyWithImpl(_$MigrationSheetRequestImpl _value,
      $Res Function(_$MigrationSheetRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sheetIndexList = freezed,
  }) {
    return _then(_$MigrationSheetRequestImpl(
      sheetIndexList: freezed == sheetIndexList
          ? _value.sheetIndexList
          : sheetIndexList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MigrationSheetRequestImpl extends _MigrationSheetRequest {
  _$MigrationSheetRequestImpl({this.sheetIndexList}) : super._();

  factory _$MigrationSheetRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MigrationSheetRequestImplFromJson(json);

  @override
  List<int>? sheetIndexList;

  @override
  String toString() {
    return 'MigrationSheetRequest(sheetIndexList: $sheetIndexList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MigrationSheetRequestImplCopyWith<_$MigrationSheetRequestImpl>
      get copyWith => __$$MigrationSheetRequestImplCopyWithImpl<
          _$MigrationSheetRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MigrationSheetRequestImplToJson(
      this,
    );
  }
}

abstract class _MigrationSheetRequest extends MigrationSheetRequest {
  factory _MigrationSheetRequest({List<int>? sheetIndexList}) =
      _$MigrationSheetRequestImpl;
  _MigrationSheetRequest._() : super._();

  factory _MigrationSheetRequest.fromJson(Map<String, dynamic> json) =
      _$MigrationSheetRequestImpl.fromJson;

  @override
  List<int>? get sheetIndexList;
  set sheetIndexList(List<int>? value);
  @override
  @JsonKey(ignore: true)
  _$$MigrationSheetRequestImplCopyWith<_$MigrationSheetRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
