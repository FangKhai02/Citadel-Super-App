// DEPRECATED STUB - Microblink is no longer used
// This stub is provided for backward compatibility during migration to FaceNet

class BlinkIdMultiSideRecognizerResult {
  final String? fullDocumentFrontImage;
  final String? fullDocumentBackImage;
  final String? mrzText;
  final String? documentNumber;
  final String? name;
  final String? nationality;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? address;
  final String? dateOfExpiry;

  BlinkIdMultiSideRecognizerResult({
    this.fullDocumentFrontImage,
    this.fullDocumentBackImage,
    this.mrzText,
    this.documentNumber,
    this.name,
    this.nationality,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.dateOfExpiry,
  });
}

class BlinkIdMultiSideRecognizer {
  bool returnFullDocumentImage = true;
  bool returnMrzImage = false;
  bool detectGlare = true;
  bool cropDocumentImage = false;
}

class RecognizerCollection {
  final List<Recognizer> recognizers = [];
  RecognizerCollection(List<Recognizer> recognizers);
}

class Recognizer {}

class RecognizerResult {}

class OverlaySettings {}

class BlinkIdOverlaySettings extends OverlaySettings {}

class MicroblinkScanner {
  static Future<List<RecognizerResult>> scanWithCamera(
    RecognizerCollection recognizers,
    BlinkIdOverlaySettings settings,
    String license,
  ) async {
    return [];
  }
}
