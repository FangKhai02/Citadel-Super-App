// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corresponding_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorrespondingAddressImpl _$$CorrespondingAddressImplFromJson(
        Map<String, dynamic> json) =>
    _$CorrespondingAddressImpl(
      isSameCorrespondingAddress: json['isSameCorrespondingAddress'] as bool?,
      correspondingAddress: json['correspondingAddress'] as String?,
      correspondingPostcode: json['correspondingPostcode'] as String?,
      correspondingCity: json['correspondingCity'] as String?,
      correspondingState: json['correspondingState'] as String?,
      correspondingCountry: json['correspondingCountry'] as String?,
      correspondingAddressProofKey:
          json['correspondingAddressProofKey'] as String?,
    );

Map<String, dynamic> _$$CorrespondingAddressImplToJson(
        _$CorrespondingAddressImpl instance) =>
    <String, dynamic>{
      'isSameCorrespondingAddress': instance.isSameCorrespondingAddress,
      'correspondingAddress': instance.correspondingAddress,
      'correspondingPostcode': instance.correspondingPostcode,
      'correspondingCity': instance.correspondingCity,
      'correspondingState': instance.correspondingState,
      'correspondingCountry': instance.correspondingCountry,
      'correspondingAddressProofKey': instance.correspondingAddressProofKey,
    };
