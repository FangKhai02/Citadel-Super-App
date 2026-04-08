import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/vo/bank_details_request_vo.dart';
import 'package:citadel_super_app/data/response/bank_details_response.dart';
import 'package:citadel_super_app/data/response/create_bank_response_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_bank_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class BankRepository extends BaseWebService implements IBankRepository {
  @override
  Future<void> deleteBank(int? id, {String? clientId}) async {
    await post(url: AppUrl.bankDelete(id, clientId: clientId));
  }

  @override
  Future<List<BankDetailsVo>> getBanks({String? clientId}) async {
    final json = await get(url: AppUrl.bank(clientId));
    return BankDetailsResponse.fromJson(json).bankDetails ?? [];
  }

  @override
  Future<void> updateBank(int? id, BankDetailsRequestVo req,
      {String? clientId}) async {
    await post(
        url: AppUrl.bankUpdate(id, clientId: clientId),
        parameter: req.toJson());
  }

  @override
  Future<BankDetailsVo> createBank(BankDetailsRequestVo req,
      {String? clientId}) async {
    final json =
        await post(url: AppUrl.bankCreate(clientId), parameter: req.toJson());
    return CreateBankResponseVo.fromJson(json).bankDetails ?? BankDetailsVo();
  }
}
