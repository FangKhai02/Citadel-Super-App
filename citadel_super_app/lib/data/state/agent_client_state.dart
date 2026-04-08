import 'package:citadel_super_app/data/model/month_year.dart';
import 'package:citadel_super_app/data/model/sales_details.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/response/agent_client_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_down_line_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_pending_signature_response_vo.dart';
import 'package:citadel_super_app/data/vo/agent_down_line_commission_vo.dart';
import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final agentClientListFutureProvider = FutureProvider.autoDispose
    .family<AgentClientResponseVo, String?>((ref, agentId) async {
  final AgentRepository agentRepository = AgentRepository();
  return agentRepository.getAgentClientList(agentId);
});

final agentClientPortfolioFutureProvider =
    FutureProvider.autoDispose.family((ref, String clientId) async {
  return await AgentRepository().getAgentClientPortfolio(clientId);
});

final agentClientTransactionsFutureProvider =
    FutureProvider.autoDispose.family((ref, String clientId) async {
  return await AgentRepository().getAgentClientTransactions(clientId);
});

final agentPendingAgreementPortfoliosFutureProvider =
    FutureProvider.autoDispose<AgentPendingSignatureResponseVo>((ref) async {
  final AgentRepository agentRepository = AgentRepository();
  return agentRepository.getPendingAgreement();
});

final agentTotalSalesFutureProvider =
    FutureProvider.autoDispose.family((ref, String? agentId) async {
  return await AgentRepository().getAgentTotalSales(agentId: agentId);
});

final agentSalesDetailsFutureProvider =
    FutureProvider.autoDispose.family((ref, SalesDetails? details) async {
  return await AgentRepository().getAgentSalesDetails(details: details);
});

final agentEarningFutureProvider = FutureProvider.autoDispose((ref) async {
  return await AgentRepository().getAgentEarnings();
});

final agentComissionOverridingFutureProvider = FutureProvider.autoDispose
    .family<List<AgentDownLineCommissionVo>, MonthYear?>(
        (ref, selectedTime) async {
  return await AgentRepository().getAgentComissionOverriding(
      month: selectedTime?.month, year: selectedTime?.year);
});

final agentDownlineFutureProvider =
    FutureProvider.autoDispose<AgentDownLineResponseVo>((ref) async {
  return await AgentRepository().getAgentDownLine();
});

final agentDownLineListFutureProvider =
    FutureProvider.autoDispose<List<AgentVo>>((ref) async {
  return await AgentRepository().getAgentDownLineList();
});
