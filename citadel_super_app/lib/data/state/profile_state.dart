import 'package:citadel_super_app/data/repository/bank_repository.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../response/client_profile_response_vo.dart';
import '../vo/individual_beneficiary_vo.dart';

final profileProvider = FutureProvider.autoDispose
    .family<ClientProfileResponseVo, String?>((ref, clientId) async {
  final ClientRepository clientRepository = ClientRepository();
  return clientRepository.getProfile(clientId: clientId);
});

final beneficiariesProvider = FutureProvider.autoDispose
    .family<List<IndividualBeneficiaryVo>, String?>((ref, clientId) async {
  final ClientRepository clientRepository = ClientRepository();
  return clientRepository.getBeneficiaries(clientId);
});

final bankProvider = FutureProvider.autoDispose
    .family<List<BankDetailsVo>, String?>((ref, clientId) async {
  final BankRepository bankRepository = BankRepository();
  return bankRepository.getBanks(clientId: clientId);
});
