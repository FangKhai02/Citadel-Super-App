// GENERATED CODE - FaceNet-based face comparison request VO

import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_compare_request_vo.freezed.dart';
part 'face_compare_request_vo.g.dart';

@unfreezed
abstract class FaceCompareRequestVo with _$FaceCompareRequestVo {
  FaceCompareRequestVo._();

  factory FaceCompareRequestVo({
    String? documentImage,    // Base64 encoded ID document image
    String? selfieImage,      // Base64 encoded selfie image
    String? documentType,     // MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
    String? fullName,
    String? documentNumber,
    String? dateOfBirth,     // Format: yyyy-MM-dd
    String? gender,          // MALE, FEMALE, OTHER
    String? nationality,
  }) = _FaceCompareRequestVo;

  factory FaceCompareRequestVo.fromJson(Map<String, dynamic> json) =>
      _$FaceCompareRequestVoFromJson(json);
}
