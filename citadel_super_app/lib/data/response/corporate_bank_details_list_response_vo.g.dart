// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_bank_details_list_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBankDetailsListResponseVoImpl
    _$$CorporateBankDetailsListResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateBankDetailsListResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          corporateBankDetails: (json['corporateBankDetails'] as List<dynamic>?)
              ?.map((e) => BankDetailsVo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$CorporateBankDetailsListResponseVoImplToJson(
        _$CorporateBankDetailsListResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateBankDetails': instance.corporateBankDetails,
    };
