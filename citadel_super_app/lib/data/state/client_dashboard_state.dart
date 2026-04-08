import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';

class ClientPortfolioReference {
  String referenceNumber;
  String? clientId;

  ClientPortfolioReference({required this.referenceNumber, this.clientId});
}

final clientPortfolioFutureProvider =
    FutureProvider.autoDispose<List<ClientPortfolioVo>>((ref) async {
  final ClientRepository clientRepository = ClientRepository();
  return await clientRepository.getPortfolio();
});

final clientPortfolioDetailFutureProvider = FutureProvider.autoDispose
    .family<ClientPortfolioProductDetailsResponseVo, ClientPortfolioReference>(
  (ref, reference) async {
    final clientRepository = ClientRepository();
    return await clientRepository.getPortfolioDetail(reference);
  },
);

final clientTransactionFutureProvider =
    FutureProvider.autoDispose<List<TransactionVo>>((ref) async {
  final ClientRepository clientRepository = ClientRepository();
  return await clientRepository.getClientTransaction();
});
