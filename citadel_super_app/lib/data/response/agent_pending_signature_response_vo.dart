// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_portfolio_vo.dart';
import '../vo/client_portfolio_vo.dart';


part 'agent_pending_signature_response_vo.freezed.dart';
part 'agent_pending_signature_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentPendingSignatureResponseVo with _$AgentPendingSignatureResponseVo {
  AgentPendingSignatureResponseVo._();

  factory AgentPendingSignatureResponseVo({
     String? code,
     String? message,
     List<ClientPortfolioVo>? productOrders,
     List<ClientPortfolioVo>? earlyRedemptions,
    
  }) = _AgentPendingSignatureResponseVo;
  
  factory AgentPendingSignatureResponseVo.fromJson(Map<String, dynamic> json) => _$AgentPendingSignatureResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "productOrders" : ClientPortfolioVo.toExampleApiJson(),
  //   "earlyRedemptions" : ClientPortfolioVo.toExampleApiJson(),
  //   
  // };
}