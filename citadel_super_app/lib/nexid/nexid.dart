// DEPRECATED STUB - NexID is no longer used
// This stub is provided for backward compatibility during migration to FaceNet

class NexID {
  Future<void> initSDK(String apiKey, String appId) async {}
  Future<NexIDLivenessResult> startLiveness(String mode, String image) async {
    return NexIDLivenessResult();
  }
}

class NexIDLivenessResult {
  NexIDLivenessData? livenessResult;
  NexIDMatchingData? matchingResult;
  bool? faceIsMatch;
}

class NexIDLivenessData {
  String? faceImageBase64;
  double? livenessScore;
}

class NexIDMatchingData {
  double? confidence;
}
