import 'package:citadel_super_app/data/repository/niu_repository.dart';
import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final niuApplicationDetailsFutureProvider =
    FutureProvider.autoDispose<List<NiuGetApplicationDetailsVo>>((ref) async {
  return await NiuRepository().getApplication();
});
