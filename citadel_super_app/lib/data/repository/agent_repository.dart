import 'package:citadel_super_app/app_folder/app_url.dart';
import 'package:citadel_super_app/data/model/sales_details.dart';
import 'package:citadel_super_app/data/request/agent_pin_request_vo.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/response/agent_client_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_commission_monthly_report_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_down_line_commission_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_down_line_list_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_down_line_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_earning_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_pending_signature_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_personal_sales_details_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_profile_response_vo.dart';
import 'package:citadel_super_app/data/response/agency_agents_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_secure_tag_response_vo.dart';
import 'package:citadel_super_app/data/response/agent_total_sales_response_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_response_vo.dart';
import 'package:citadel_super_app/data/response/product_order_summary_response_vo.dart';
import 'package:citadel_super_app/data/response/transaction_response_vo.dart';
import 'package:citadel_super_app/data/vo/agent_down_line_commission_vo.dart';
import 'package:citadel_super_app/data/vo/agent_secure_tag_vo.dart';
import 'package:citadel_super_app/data/vo/agent_personal_details_vo.dart';
import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:citadel_super_app/domain/i_repository/i_agent_repository.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

class AgentRepository extends BaseWebService implements IAgentRepository {
  @override
  Future<AgencyAgentsResponseVo> getAgentsById(String agencyId) async {
    AgencyAgentsResponseVo resp = AgencyAgentsResponseVo.fromJson(
        await get(url: '${AppUrl.getAgents}?agencyId=$agencyId'));
    return resp;
  }

  @override
  Future<AgentProfileResponseVo> getAgentProfile() async {
    final json = await get(url: AppUrl.getAgentProfile);
    return AgentProfileResponseVo.fromJson(json);
  }

  @override
  Future<AgentClientResponseVo> getAgentClientList(String? agentId) async {
    final json = await get(url: AppUrl.getAgentClientList(agentId: agentId));
    return AgentClientResponseVo.fromJson(json);
  }

  @override
  Future<List<ClientPortfolioVo>> getAgentClientPortfolio(
      String clientId) async {
    final json = await get(url: AppUrl.getAgentClientPortfolio(clientId));
    return ClientPortfolioResponseVo.fromJson(json).portfolio ?? [];
  }

  @override
  Future<List<TransactionVo>> getAgentClientTransactions(
      String clientId) async {
    final json = await get(url: AppUrl.getAgentClientTransactions(clientId));
    return TransactionResponseVo.fromJson(json).transactions ?? [];
  }

  @override
  Future<void> cancelAgentSecureTag(String clientId) async {
    await delete(url: AppUrl.secureTag(clientId));
  }

  @override
  Future<AgentSecureTagVo?> getAgentSecureTagStatus(String clientId) async {
    final json = await get(url: AppUrl.secureTag(clientId));
    return AgentSecureTagResponseVo.fromJson(json).secureTag;
  }

  @override
  Future<void> requestAgentSecureTag(String clientId) async {
    await post(url: AppUrl.secureTag(clientId));
  }

  Future<void> updateAgentProfile(AgentPersonalDetailsVo req) async {
    await post(url: AppUrl.updateAgentProfile, parameter: req.toJson());
  }

  @override
  Future<void> updateAgentProfileImage(String? base64Image) async {
    await post(url: AppUrl.editAgentProfileImage, parameter: {
      "profilePicture": base64Image,
    });
  }

  @override
  Future<void> registerPin(AgentPinRequestVo req) async {
    await post(url: AppUrl.createAgentPin, parameter: req.toJson());
  }

  @override
  Future<void> updatePin(AgentPinRequestVo req) async {
    await post(url: AppUrl.createAgentPin, parameter: req.toJson());
  }

  @override
  Future<void> validatePin(AgentPinRequestVo req) async {
    await post(url: AppUrl.createAgentPin, parameter: req.toJson());
  }

  @override
  Future<AgentPendingSignatureResponseVo> getPendingAgreement() async {
    final json = await get(url: AppUrl.pendingAgreement);
    return AgentPendingSignatureResponseVo.fromJson(json);
  }

  @override
  Future<ProductOrderSummaryResponseVo> agentProductPurchase(
      ProductPurchaseRequestVo req,
      {String? referenceNumber}) async {
    final json = await post(
        url: AppUrl.agentProductPurchase(referenceNumber),
        parameter: req.toJson());
    return ProductOrderSummaryResponseVo.fromJson(json);
  }

  @override
  Future<AgentEarningResponseVo> getAgentEarnings() async {
    final json = await get(url: AppUrl.agentEarning());
    return AgentEarningResponseVo.fromJson(json);
  }

  @override
  Future<AgentTotalSalesResponseVo> getAgentTotalSales(
      {String? agentId}) async {
    final json = await get(url: AppUrl.agentPersonalSales(agentId));
    return AgentTotalSalesResponseVo.fromJson(json);
  }

  @override
  Future<AgentPersonalSalesDetailsResponseVo> getAgentSalesDetails(
      {SalesDetails? details}) async {
    final json = await get(
        url: AppUrl.agentSalesDetails(details?.agentId,
            details?.monthYear?.month, details?.monthYear?.year));
    return AgentPersonalSalesDetailsResponseVo.fromJson(json);
  }

  @override
  Future<List<AgentDownLineCommissionVo>> getAgentComissionOverriding(
      {int? month, int? year}) async {
    final json = await get(url: AppUrl.agentComissionOverriding(month, year));
    return AgentDownLineCommissionResponseVo.fromJson(json)
            .downLineCommissionList ??
        [];
  }

  @override
  Future<AgentDownLineResponseVo> getAgentDownLine() async {
    final json = await get(url: AppUrl.agentDownline());
    return AgentDownLineResponseVo.fromJson(json);
  }

  @override
  Future<List<AgentVo>> getAgentDownLineList() async {
    final json = await get(url: AppUrl.agentDownlineList);
    return AgentDownLineListResponseVo.fromJson(json).agentDownLineList ?? [];
  }

  @override
  Future<String?> getAgentComissionReport(int month, int year,
      {String? agentId}) async {
    final json =
        await get(url: AppUrl.agentComissionReport(agentId, month, year));
    return AgentCommissionMonthlyReportResponseVo.fromJson(json)
        .agentCommissionMonthlyReport;
  }
}
