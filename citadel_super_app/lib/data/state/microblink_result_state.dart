import 'package:citadel_super_app/service/document_capture_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Provider for KYC document state with notifier
final kycDocumentNotifierProvider = StateNotifierProvider.autoDispose<KycDocumentNotifier,
    KycDocumentState>((ref) {
  return KycDocumentNotifier();
});

class KycDocumentState {
  final DocumentType? documentType;
  final String? documentImage;  // Base64 encoded front image
  final String? backImage;       // Base64 encoded back image
  final String? fullName;
  final String? documentNumber;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? selfieImage;  // Base64 encoded

  KycDocumentState({
    this.documentType,
    this.documentImage,
    this.backImage,
    this.fullName,
    this.documentNumber,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.selfieImage,
  });

  KycDocumentState copyWith({
    DocumentType? documentType,
    String? documentImage,
    String? backImage,
    String? fullName,
    String? documentNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? nationality,
    String? selfieImage,
  }) {
    return KycDocumentState(
      documentType: documentType ?? this.documentType,
      documentImage: documentImage ?? this.documentImage,
      backImage: backImage ?? this.backImage,
      fullName: fullName ?? this.fullName,
      documentNumber: documentNumber ?? this.documentNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      selfieImage: selfieImage ?? this.selfieImage,
    );
  }
}

class KycDocumentNotifier extends StateNotifier<KycDocumentState> {
  KycDocumentNotifier() : super(KycDocumentState());

  void setDocumentType(DocumentType type) {
    state = state.copyWith(documentType: type);
  }

  void setDocumentImage(String image) {
    state = state.copyWith(documentImage: image);
  }

  void setDocumentBackImage(String image) {
    state = state.copyWith(backImage: image);
  }

  void setDocumentDetails({
    String? fullName,
    String? documentNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? nationality,
  }) {
    state = state.copyWith(
      fullName: fullName,
      documentNumber: documentNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
      nationality: nationality,
    );
  }

  void setSelfieImage(String image) {
    state = state.copyWith(selfieImage: image);
  }

  void clear() {
    state = KycDocumentState();
  }
}

// Legacy provider for backward compatibility during migration
final microblinkResultProvider = StateNotifierProvider.autoDispose<MicroblinkResultNotifier,
    BlinkIdMultiSideRecognizerResult?>((ref) {
  return MicroblinkResultNotifier();
});

// Legacy state for backward compatibility
class BlinkIdMultiSideRecognizerResult {
  final String? fullDocumentFrontImage;
  final String? fullDocumentBackImage;
  final String? name;
  final String? documentNumber;
  final String? nationality;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? documentType;

  // Computed properties for compatibility
  String get docType => documentType ?? 'MYKAD';
  bool get isMyKad => documentType?.toUpperCase() == 'MYKAD' || (documentNumber?.length == 12);
  bool get isPassport => documentType?.toUpperCase() == 'PASSPORT';
  bool get isIkad => documentType?.toUpperCase() == 'IKAD';
  bool get isMyTentera => documentType?.toUpperCase() == 'MYTENTERA';
  bool get isMyKid => documentType?.toUpperCase() == 'MYKID';
  bool get isMyPR => documentType?.toUpperCase() == 'MYPR';

  // For extension compatibility
  int? get dobInEpoch => dateOfBirth?.millisecondsSinceEpoch;
  String get frontImage => fullDocumentFrontImage ?? '';
  String get backImage => fullDocumentBackImage ?? '';
  String nameFormatted() => name ?? '';
  String genderFormatted() => gender ?? '';
  String nationalityFormatted() => nationality ?? '';

  BlinkIdMultiSideRecognizerResult({
    this.fullDocumentFrontImage,
    this.fullDocumentBackImage,
    this.name,
    this.documentNumber,
    this.nationality,
    this.gender,
    this.dateOfBirth,
    this.documentType,
  });
}

class MicroblinkResultNotifier extends StateNotifier<BlinkIdMultiSideRecognizerResult?> {
  MicroblinkResultNotifier() : super(null);

  void setMicroblinkResult(BlinkIdMultiSideRecognizerResult result) {
    state = result;
  }
}
