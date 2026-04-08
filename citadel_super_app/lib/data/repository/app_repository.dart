import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/app_user_delete_request_vo.dart';
import 'package:citadel_super_app/data/request/contact_us_form_submit_request_vo.dart';
import 'package:citadel_super_app/data/request/face_compare_request_vo.dart';
import 'package:citadel_super_app/data/request/image_validate_request_vo.dart';
import 'package:citadel_super_app/data/response/face_compare_response_vo.dart';
import 'package:citadel_super_app/data/response/force_update_response_vo.dart';
import 'package:citadel_super_app/data/response/image_validate_response_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_app_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class AppRepository extends BaseWebService implements IAppRepository {
  @override
  Future<Map<String, dynamic>> getSettings() async {
    return await get(url: AppUrl.getSettings);
  }

  @override
  Future<Map<String, dynamic>> getAgencies() async {
    return await get(url: AppUrl.getAgencies);
  }

  @override
  Future<Map<String, dynamic>> getConstants() async {
    return await get(url: AppUrl.getConstants);
  }

  @override
  Future<Map<String, dynamic>> getMaintenance() async {
    return await get(url: AppUrl.getMaintenance);
  }

  @override
  Future<Map<String, dynamic>> getAppUser(String apiKey) async {
    return await post(url: AppUrl.getAppUser, parameter: {'apiKey': apiKey});
  }

  @override
  Future<void> postContactUs(ContactUsFormSubmitRequestVo req) async {
    await post(url: AppUrl.contactUs, parameter: req.toJson());
  }

  @override
  Future<void> deleteAccount(AppUserDeleteRequestVo req) async {
    await post(url: AppUrl.deleteAccount, parameter: req.toJson());
  }

  @override
  Future<ImageValidateResponseVo> imageValidate(
      ImageValidateRequestVo req) async {
    final response =
        await post(url: AppUrl.imageValidate, parameter: req.toJson());
    return ImageValidateResponseVo.fromJson(response);
  }

  @override
  Future<FaceCompareResponseVo> faceCompare(FaceCompareRequestVo req) async {
    final response =
        await post(url: AppUrl.faceCompare, parameter: req.toJson());
    return FaceCompareResponseVo.fromJson(response);
  }

  @override
  Future<ForceUpdateResponseVo> checkForceUpdate(
      String appVersion, String platform) async {
    final response = await get(url: AppUrl.forceUpdate(appVersion, platform));
    return ForceUpdateResponseVo.fromJson(response);
  }
}
