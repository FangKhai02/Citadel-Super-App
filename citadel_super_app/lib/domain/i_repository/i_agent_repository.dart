import 'package:citadel_super_app/data/model/sales_details.dart';
import 'package:citadel_super_app/data/request/agent_pin_request_vo.dart';
import 'package:citadel_super_app/data/request/agent_product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/response/agent_client_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_down_line_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_earning_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_pending_signature_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_personal_sales_details_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_profile_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_total_sales_response_vo.dart';
import 'package:citadel_super_app/data/response/product_order_summary_response_vo.dart';
import 'package:citadel_super_app/data/vo/agent_down_line_commission_vo.dart';
import 'package:citadel_super_app/data/vo/agent_secure_tag_vo.dart';
import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';

import '../../data/response/agency_agents_response_vo.dart';

abstract class IAgentRepository {
  Future<AgencyAgentsResponseVo> getAgentsById(String agencyId);

  Future<AgentSecureTagVo?> getAgentSecureTagStatus(String clientId);

  Future<void> requestAgentSecureTag(String clientId);

  Future<void> cancelAgentSecureTag(String clientId);

  Future<void> updateAgentProfileImage(String? base64Image);

  Future<void> registerPin(AgentPinRequestVo req);

  Future<void> updatePin(AgentPinRequestVo req);

  Future<void> validatePin(AgentPinRequestVo req);

  Future<AgentProfileResponseVo> getAgentProfile();

  Future<AgentClientResponseVo> getAgentClientList(String? agentId);

  Future<List<ClientPortfolioVo>> getAgentClientPortfolio(String clientId);

  Future<List<TransactionVo>> getAgentClientTransactions(String clientId);

  Future<AgentEarningResponseVo> getAgentEarnings();

  Future<AgentTotalSalesResponseVo> getAgentTotalSales({String? agentId});

  Future<AgentPersonalSalesDetailsResponseVo> getAgentSalesDetails(
      {SalesDetails? details});

  Future<AgentPendingSignatureResponseVo> getPendingAgreement();

  Future<ProductOrderSummaryResponseVo> agentProductPurchase(
      ProductPurchaseRequestVo req);

  Future<List<AgentDownLineCommissionVo>> getAgentComissionOverriding(
      {int? month, int? year});

  Future<AgentDownLineResponseVo> getAgentDownLine();

  Future<List<AgentVo>> getAgentDownLineList();

  Future<String?> getAgentComissionReport(int month, int year,
      {String? agentId});
}
