// GENERATED CODE - FaceNet-based face comparison response VO

import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_compare_response_vo.freezed.dart';
part 'face_compare_response_vo.g.dart';

@unfreezed
abstract class FaceCompareResponseVo with _$FaceCompareResponseVo {
  FaceCompareResponseVo._();

  factory FaceCompareResponseVo({
    bool? verified,     // true if face match passed (score <= 0.45)
    double? score,      // Euclidean distance (lower = more similar)
    String? message,    // Human-readable message
    bool? degraded,     // true if models were unavailable
  }) = _FaceCompareResponseVo;

  factory FaceCompareResponseVo.fromJson(Map<String, dynamic> json) =>
      _$FaceCompareResponseVoFromJson(json);
}
