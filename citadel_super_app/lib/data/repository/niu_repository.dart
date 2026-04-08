import 'dart:core';

import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/request/niu_apply_requestuest_vo.dart';
import 'package:citadel_super_app/data/response/niu_get_application_response_vo.dart';
import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_niu_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class NiuRepository extends BaseWebService implements INiuRepository {
  @override
  Future<void> niuApply(NiuApplyRequestuestVo req) async {
    await post(url: AppUrl.niuApply, parameter: req.toJson());
  }

  @override
  Future<List<NiuGetApplicationDetailsVo>> getApplication() async {
    final json = await get(url: AppUrl.getNiuApplication);
    return NiuGetApplicationResponseVo.fromJson(json).applications ?? [];
  }
}
