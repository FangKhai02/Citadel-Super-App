import 'package:citadel_super_app/data/request/change_password_request_vo.dart';
import 'package:citadel_super_app/data/request/login_requestuest_vo.dart';
import 'package:citadel_super_app/data/request/reset_password_request_vo.dart';

abstract class ILoginRepository {
  Future<Map<String, dynamic>> login(LoginRequestuestVo loginRequestVo);

  Future<void> forgotPassword(String email);

  Future<void> changePassword(ChangePasswordRequestVo changePasswordRequestVo);

  Future<void> resetPassword(ResetPasswordRequestVo req);
}
