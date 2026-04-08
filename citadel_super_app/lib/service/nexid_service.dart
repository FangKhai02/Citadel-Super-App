// DEPRECATED: NexID is no longer used
// This stub is provided for backward compatibility during migration to FaceNet
// All NexID functionality has been replaced with FaceNet face comparison

import 'package:citadel_super_app/service/base_web_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NexFace {
  String image;
  double confidence;
  double score;

  NexFace({
    required this.image,
    required this.confidence,
    required this.score,
  });
}

class NexIdService {
  NexIdService._();

  static final shared = NexIdService._();

  // Stub - NexID is deprecated
  final dynamic nexId = null;
  final appId = "citadel_super_app";
  final String apiKey = '';

  Future<void> init() async {
    // Stub - NexID is deprecated
  }

  /// Exception [LocaleKey.fail_detect_face_in_document]
  ///[image] local document
  Future<NexFace?> startLiveness(String image) async {
    // Stub - NexID is deprecated, returns null
    return null;
  }

  Future<void> showNoFaceDetectDialog(BuildContext context,
      {required Function() onTap}) async {
    // TODO : show dialog
  }
}
