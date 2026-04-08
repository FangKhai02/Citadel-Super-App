import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/change_password_request_vo.dart';
import 'package:citadel_super_app/data/request/login_requestuest_vo.dart';
import 'package:citadel_super_app/data/request/reset_password_request_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_login_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class LoginRepository extends BaseWebService implements ILoginRepository {
  @override
  Future<Map<String, dynamic>> login(LoginRequestuestVo loginRequestVo) async {
    return await post(url: AppUrl.login, parameter: loginRequestVo.toJson());
  }

  @override
  Future<void> forgotPassword(String email) async {
    await post(url: AppUrl.forgotPassword(email));
  }

  @override
  Future<void> changePassword(
      ChangePasswordRequestVo changePasswordRequestVo) async {
    await post(
        url: AppUrl.changePassword,
        parameter: changePasswordRequestVo.toJson());
  }

  @override
  Future<void> resetPassword(ResetPasswordRequestVo req) async {
    await post(url: AppUrl.resetPassword, parameter: req.toJson());
  }
}
