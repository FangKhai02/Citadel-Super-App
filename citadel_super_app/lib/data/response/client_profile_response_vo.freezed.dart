// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_profile_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientProfileResponseVo _$ClientProfileResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ClientProfileResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ClientProfileResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  set clientId(String? value) => throw _privateConstructorUsedError;
  ClientPersonalDetailsVo? get personalDetails =>
      throw _privateConstructorUsedError;
  set personalDetails(ClientPersonalDetailsVo? value) =>
      throw _privateConstructorUsedError;
  ClientEmploymentDetailsVo? get employmentDetails =>
      throw _privateConstructorUsedError;
  set employmentDetails(ClientEmploymentDetailsVo? value) =>
      throw _privateConstructorUsedError;
  ClientWealthSourceDetailsVo? get wealthSourceDetails =>
      throw _privateConstructorUsedError;
  set wealthSourceDetails(ClientWealthSourceDetailsVo? value) =>
      throw _privateConstructorUsedError;
  ClientAgentDetailsVo? get agentDetails => throw _privateConstructorUsedError;
  set agentDetails(ClientAgentDetailsVo? value) =>
      throw _privateConstructorUsedError;
  PepDeclarationVo? get pepDeclaration => throw _privateConstructorUsedError;
  set pepDeclaration(PepDeclarationVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientProfileResponseVoCopyWith<ClientProfileResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientProfileResponseVoCopyWith<$Res> {
  factory $ClientProfileResponseVoCopyWith(ClientProfileResponseVo value,
          $Res Function(ClientProfileResponseVo) then) =
      _$ClientProfileResponseVoCopyWithImpl<$Res, ClientProfileResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? clientId,
      ClientPersonalDetailsVo? personalDetails,
      ClientEmploymentDetailsVo? employmentDetails,
      ClientWealthSourceDetailsVo? wealthSourceDetails,
      ClientAgentDetailsVo? agentDetails,
      PepDeclarationVo? pepDeclaration});

  $ClientPersonalDetailsVoCopyWith<$Res>? get personalDetails;
  $ClientEmploymentDetailsVoCopyWith<$Res>? get employmentDetails;
  $ClientWealthSourceDetailsVoCopyWith<$Res>? get wealthSourceDetails;
  $ClientAgentDetailsVoCopyWith<$Res>? get agentDetails;
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration;
}

/// @nodoc
class _$ClientProfileResponseVoCopyWithImpl<$Res,
        $Val extends ClientProfileResponseVo>
    implements $ClientProfileResponseVoCopyWith<$Res> {
  _$ClientProfileResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? clientId = freezed,
    Object? personalDetails = freezed,
    Object? employmentDetails = freezed,
    Object? wealthSourceDetails = freezed,
    Object? agentDetails = freezed,
    Object? pepDeclaration = freezed,
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
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as ClientPersonalDetailsVo?,
      employmentDetails: freezed == employmentDetails
          ? _value.employmentDetails
          : employmentDetails // ignore: cast_nullable_to_non_nullable
              as ClientEmploymentDetailsVo?,
      wealthSourceDetails: freezed == wealthSourceDetails
          ? _value.wealthSourceDetails
          : wealthSourceDetails // ignore: cast_nullable_to_non_nullable
              as ClientWealthSourceDetailsVo?,
      agentDetails: freezed == agentDetails
          ? _value.agentDetails
          : agentDetails // ignore: cast_nullable_to_non_nullable
              as ClientAgentDetailsVo?,
      pepDeclaration: freezed == pepDeclaration
          ? _value.pepDeclaration
          : pepDeclaration // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientPersonalDetailsVoCopyWith<$Res>? get personalDetails {
    if (_value.personalDetails == null) {
      return null;
    }

    return $ClientPersonalDetailsVoCopyWith<$Res>(_value.personalDetails!,
        (value) {
      return _then(_value.copyWith(personalDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientEmploymentDetailsVoCopyWith<$Res>? get employmentDetails {
    if (_value.employmentDetails == null) {
      return null;
    }

    return $ClientEmploymentDetailsVoCopyWith<$Res>(_value.employmentDetails!,
        (value) {
      return _then(_value.copyWith(employmentDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientWealthSourceDetailsVoCopyWith<$Res>? get wealthSourceDetails {
    if (_value.wealthSourceDetails == null) {
      return null;
    }

    return $ClientWealthSourceDetailsVoCopyWith<$Res>(
        _value.wealthSourceDetails!, (value) {
      return _then(_value.copyWith(wealthSourceDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientAgentDetailsVoCopyWith<$Res>? get agentDetails {
    if (_value.agentDetails == null) {
      return null;
    }

    return $ClientAgentDetailsVoCopyWith<$Res>(_value.agentDetails!, (value) {
      return _then(_value.copyWith(agentDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration {
    if (_value.pepDeclaration == null) {
      return null;
    }

    return $PepDeclarationVoCopyWith<$Res>(_value.pepDeclaration!, (value) {
      return _then(_value.copyWith(pepDeclaration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientProfileResponseVoImplCopyWith<$Res>
    implements $ClientProfileResponseVoCopyWith<$Res> {
  factory _$$ClientProfileResponseVoImplCopyWith(
          _$ClientProfileResponseVoImpl value,
          $Res Function(_$ClientProfileResponseVoImpl) then) =
      __$$ClientProfileResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? clientId,
      ClientPersonalDetailsVo? personalDetails,
      ClientEmploymentDetailsVo? employmentDetails,
      ClientWealthSourceDetailsVo? wealthSourceDetails,
      ClientAgentDetailsVo? agentDetails,
      PepDeclarationVo? pepDeclaration});

  @override
  $ClientPersonalDetailsVoCopyWith<$Res>? get personalDetails;
  @override
  $ClientEmploymentDetailsVoCopyWith<$Res>? get employmentDetails;
  @override
  $ClientWealthSourceDetailsVoCopyWith<$Res>? get wealthSourceDetails;
  @override
  $ClientAgentDetailsVoCopyWith<$Res>? get agentDetails;
  @override
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration;
}

/// @nodoc
class __$$ClientProfileResponseVoImplCopyWithImpl<$Res>
    extends _$ClientProfileResponseVoCopyWithImpl<$Res,
        _$ClientProfileResponseVoImpl>
    implements _$$ClientProfileResponseVoImplCopyWith<$Res> {
  __$$ClientProfileResponseVoImplCopyWithImpl(
      _$ClientProfileResponseVoImpl _value,
      $Res Function(_$ClientProfileResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? clientId = freezed,
    Object? personalDetails = freezed,
    Object? employmentDetails = freezed,
    Object? wealthSourceDetails = freezed,
    Object? agentDetails = freezed,
    Object? pepDeclaration = freezed,
  }) {
    return _then(_$ClientProfileResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as ClientPersonalDetailsVo?,
      employmentDetails: freezed == employmentDetails
          ? _value.employmentDetails
          : employmentDetails // ignore: cast_nullable_to_non_nullable
              as ClientEmploymentDetailsVo?,
      wealthSourceDetails: freezed == wealthSourceDetails
          ? _value.wealthSourceDetails
          : wealthSourceDetails // ignore: cast_nullable_to_non_nullable
              as ClientWealthSourceDetailsVo?,
      agentDetails: freezed == agentDetails
          ? _value.agentDetails
          : agentDetails // ignore: cast_nullable_to_non_nullable
              as ClientAgentDetailsVo?,
      pepDeclaration: freezed == pepDeclaration
          ? _value.pepDeclaration
          : pepDeclaration // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientProfileResponseVoImpl extends _ClientProfileResponseVo {
  _$ClientProfileResponseVoImpl(
      {this.code,
      this.message,
      this.clientId,
      this.personalDetails,
      this.employmentDetails,
      this.wealthSourceDetails,
      this.agentDetails,
      this.pepDeclaration})
      : super._();

  factory _$ClientProfileResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientProfileResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  String? clientId;
  @override
  ClientPersonalDetailsVo? personalDetails;
  @override
  ClientEmploymentDetailsVo? employmentDetails;
  @override
  ClientWealthSourceDetailsVo? wealthSourceDetails;
  @override
  ClientAgentDetailsVo? agentDetails;
  @override
  PepDeclarationVo? pepDeclaration;

  @override
  String toString() {
    return 'ClientProfileResponseVo(code: $code, message: $message, clientId: $clientId, personalDetails: $personalDetails, employmentDetails: $employmentDetails, wealthSourceDetails: $wealthSourceDetails, agentDetails: $agentDetails, pepDeclaration: $pepDeclaration)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientProfileResponseVoImplCopyWith<_$ClientProfileResponseVoImpl>
      get copyWith => __$$ClientProfileResponseVoImplCopyWithImpl<
          _$ClientProfileResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientProfileResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ClientProfileResponseVo extends ClientProfileResponseVo {
  factory _ClientProfileResponseVo(
      {String? code,
      String? message,
      String? clientId,
      ClientPersonalDetailsVo? personalDetails,
      ClientEmploymentDetailsVo? employmentDetails,
      ClientWealthSourceDetailsVo? wealthSourceDetails,
      ClientAgentDetailsVo? agentDetails,
      PepDeclarationVo? pepDeclaration}) = _$ClientProfileResponseVoImpl;
  _ClientProfileResponseVo._() : super._();

  factory _ClientProfileResponseVo.fromJson(Map<String, dynamic> json) =
      _$ClientProfileResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  String? get clientId;
  set clientId(String? value);
  @override
  ClientPersonalDetailsVo? get personalDetails;
  set personalDetails(ClientPersonalDetailsVo? value);
  @override
  ClientEmploymentDetailsVo? get employmentDetails;
  set employmentDetails(ClientEmploymentDetailsVo? value);
  @override
  ClientWealthSourceDetailsVo? get wealthSourceDetails;
  set wealthSourceDetails(ClientWealthSourceDetailsVo? value);
  @override
  ClientAgentDetailsVo? get agentDetails;
  set agentDetails(ClientAgentDetailsVo? value);
  @override
  PepDeclarationVo? get pepDeclaration;
  set pepDeclaration(PepDeclarationVo? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientProfileResponseVoImplCopyWith<_$ClientProfileResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
