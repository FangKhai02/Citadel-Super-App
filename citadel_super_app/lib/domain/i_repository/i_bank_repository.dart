import 'package:citadel_super_app/data/vo/bank_details_vo.dart';

import '../../data/vo/bank_details_request_vo.dart';

abstract class IBankRepository {
  Future<List<BankDetailsVo>> getBanks();

  Future<void> updateBank(int id, BankDetailsRequestVo req);

  Future<void> deleteBank(int id);

  Future<BankDetailsVo> createBank(BankDetailsRequestVo vo);
}
