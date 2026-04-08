// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_portfolio_vo.dart';
import '../vo/agent_dividend_payout_vo.dart';


part 'agent_client_details_response_vo.freezed.dart';
part 'agent_client_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class AgentClientDetailsResponseVo with _$AgentClientDetailsResponseVo {
  AgentClientDetailsResponseVo._();

  factory AgentClientDetailsResponseVo({
     String? code,
     String? message,
     List<ClientPortfolioVo>? clientPortfolio,
     List<AgentDividendPayoutVo>? dividendPayouts,
    
  }) = _AgentClientDetailsResponseVo;
  
  factory AgentClientDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$AgentClientDetailsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "clientPortfolio" : ClientPortfolioVo.toExampleApiJson(),
  //   "dividendPayouts" : AgentDividendPayoutVo.toExampleApiJson(),
  //   
  // };
}