// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_compare_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceCompareRequestVoImpl _$$FaceCompareRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$FaceCompareRequestVoImpl(
      documentImage: json['documentImage'] as String?,
      selfieImage: json['selfieImage'] as String?,
      documentType: json['documentType'] as String?,
      fullName: json['fullName'] as String?,
      documentNumber: json['documentNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
    );

Map<String, dynamic> _$$FaceCompareRequestVoImplToJson(
        _$FaceCompareRequestVoImpl instance) =>
    <String, dynamic>{
      'documentImage': instance.documentImage,
      'selfieImage': instance.selfieImage,
      'documentType': instance.documentType,
      'fullName': instance.fullName,
      'documentNumber': instance.documentNumber,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'nationality': instance.nationality,
    };
