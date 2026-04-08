import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/otp_verification_request.dart';
import 'package:citadel_super_app/domain/i_repository/i_otp_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class OtpRepository extends BaseWebService implements IOtpRepository {
  @override
  Future<void> sendOtp() async {
    await post(url: AppUrl.sendOtp);
  }

  @override
  Future<void> verifyOtp(OtpVerificationRequest req) async {
    await post(url: AppUrl.verifyOtp, parameter: req.toJson());
  }
}
