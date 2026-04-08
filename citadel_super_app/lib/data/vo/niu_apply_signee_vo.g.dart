// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niu_apply_signee_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NiuApplySigneeVoImpl _$$NiuApplySigneeVoImplFromJson(
        Map<String, dynamic> json) =>
    _$NiuApplySigneeVoImpl(
      fullName: json['fullName'] as String?,
      nric: json['nric'] as String?,
      signedDate: (json['signedDate'] as num?)?.toInt(),
      signature: json['signature'] as String?,
    );

Map<String, dynamic> _$$NiuApplySigneeVoImplToJson(
        _$NiuApplySigneeVoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'nric': instance.nric,
      'signedDate': instance.signedDate,
      'signature': instance.signature,
    };
