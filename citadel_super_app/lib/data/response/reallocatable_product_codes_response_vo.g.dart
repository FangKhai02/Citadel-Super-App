// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reallocatable_product_codes_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReallocatableProductCodesResponseVoImpl
    _$$ReallocatableProductCodesResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ReallocatableProductCodesResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          productCodes: (json['productCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
        );

Map<String, dynamic> _$$ReallocatableProductCodesResponseVoImplToJson(
        _$ReallocatableProductCodesResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'productCodes': instance.productCodes,
    };
