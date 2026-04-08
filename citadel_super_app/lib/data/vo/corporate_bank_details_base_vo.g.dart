// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_bank_details_base_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBankDetailsBaseVoImpl _$$CorporateBankDetailsBaseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateBankDetailsBaseVoImpl(
      id: (json['id'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      bankAccountHolderName: json['bankAccountHolderName'] as String?,
    );

Map<String, dynamic> _$$CorporateBankDetailsBaseVoImplToJson(
        _$CorporateBankDetailsBaseVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'bankAccountHolderName': instance.bankAccountHolderName,
    };
