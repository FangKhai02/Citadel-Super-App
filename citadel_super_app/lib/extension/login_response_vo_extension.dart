import 'package:citadel_super_app/data/response/login_response_vo.dart';

import '../data/model/bottom_navigation.dart';

extension LoginResponseVoExtension on LoginResponseVo? {
  LoginAs get loginAs => isAgent ? LoginAs.agent : LoginAs.client;

  bool get isAgent => this?.userType == 'AGENT';

  bool get isClient => this?.userType != 'AGENT';

  bool get requiredPin => this?.hasPin != null && !(this!.hasPin!);
}
