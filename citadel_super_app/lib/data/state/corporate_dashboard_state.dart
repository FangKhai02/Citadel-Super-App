import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';

import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final corporatePortfolioFutureProvider = FutureProvider.autoDispose
    .family<List<ClientPortfolioVo>, String>((ref, corporateClientId) async {
  final CorporateRepository corporateRepository = CorporateRepository();

  return await corporateRepository.getPortfolio(corporateClientId);
});

final corporatePortfolioDetailFutureProvider = FutureProvider.autoDispose
    .family<ClientPortfolioProductDetailsResponseVo, ClientPortfolioReference>(
  (ref, reference) async {
    final corporateRepository = CorporateRepository();

    return await corporateRepository.getPortfolioDetail(
      reference.clientId ?? '',
      reference.referenceNumber,
    );
  },
);

final corporateTransactionFutureProvider = FutureProvider.autoDispose
    .family<List<TransactionVo>, String>((ref, corporateClientId) async {
  final CorporateRepository corporateRepository = CorporateRepository();
  return await corporateRepository.getCorporateTransaction(corporateClientId);
});
