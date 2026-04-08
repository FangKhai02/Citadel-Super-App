import 'package:citadel_super_app/data/request/otp_verification_request.dart';

abstract class IOtpRepository {
  Future<void> sendOtp();
  Future<void> verifyOtp(OtpVerificationRequest req);
}
