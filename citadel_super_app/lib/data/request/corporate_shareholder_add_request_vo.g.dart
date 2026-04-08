// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_add_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderAddRequestVoImpl
    _$$CorporateShareholderAddRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateShareholderAddRequestVoImpl(
          shareHolders: (json['shareHolders'] as List<dynamic>?)
              ?.map((e) =>
                  CorporateShareHolderAddVo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$CorporateShareholderAddRequestVoImplToJson(
        _$CorporateShareholderAddRequestVoImpl instance) =>
    <String, dynamic>{
      'shareHolders': instance.shareHolders,
    };
