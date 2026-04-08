import 'package:citadel_super_app/data/request/app_user_delete_request_vo.dart';
import 'package:citadel_super_app/data/request/contact_us_form_submit_request_vo.dart';
import 'package:citadel_super_app/data/request/face_compare_request_vo.dart';
import 'package:citadel_super_app/data/request/image_validate_request_vo.dart';
import 'package:citadel_super_app/data/response/face_compare_response_vo.dart';
import 'package:citadel_super_app/data/response/force_update_response_vo.dart';

abstract class IAppRepository {
  Future<void> getSettings();
  Future<void> getAgencies();
  Future<void> getConstants();
  Future<void> getMaintenance();
  Future<void> getAppUser(String apiKey);
  Future<void> postContactUs(ContactUsFormSubmitRequestVo req);
  Future<void> deleteAccount(AppUserDeleteRequestVo req);
  Future<void> imageValidate(ImageValidateRequestVo req);
  Future<FaceCompareResponseVo> faceCompare(FaceCompareRequestVo req);
  Future<ForceUpdateResponseVo> checkForceUpdate(
      String appVersion, String platform);
}
