// DEPRECATED: Microblink is no longer used
// This stub is provided for backward compatibility during migration to FaceNet
// All Microblink functionality has been replaced with DocumentCaptureService and FaceNet

import 'package:image_picker/image_picker.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';

class MicroblinkService {
  final ImagePicker _picker = ImagePicker();

  /// Captures document image using camera (placeholder - actual capture uses DocumentCaptureService)
  Future<BlinkIdMultiSideRecognizerResult?> scan() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1600,
        maxHeight: 900,
      );

      if (image == null) return null;

      // For now, just return the image path - actual OCR will be manual entry
      return BlinkIdMultiSideRecognizerResult(
        fullDocumentFrontImage: image.path,
      );
    } catch (e) {
      return null;
    }
  }
}
