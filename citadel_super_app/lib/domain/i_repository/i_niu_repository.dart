import 'package:citadel_super_app/data/request/niu_apply_requestuest_vo.dart';
import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';

abstract class INiuRepository {
  Future<void> niuApply(NiuApplyRequestuestVo req);

  Future<List<NiuGetApplicationDetailsVo>> getApplication ();
}