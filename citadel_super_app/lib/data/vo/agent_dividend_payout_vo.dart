// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_dividend_payout_vo.freezed.dart';
part 'agent_dividend_payout_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class AgentDividendPayoutVo with _$AgentDividendPayoutVo {
  AgentDividendPayoutVo._();

  factory AgentDividendPayoutVo({
     String? dividendPayoutId, 
     String? productName, 
     String? productCode, 
     int? dividendAmount, 
     int? dividendPayoutDate, 
    
  }) = _AgentDividendPayoutVo;
  
  factory AgentDividendPayoutVo.fromJson(Map<String, dynamic> json) => _$AgentDividendPayoutVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "dividendPayoutId" : 'string',
  //   "productName" : 'string',
  //   "productCode" : 'string',
  //   "dividendAmount" : 0,
  //   "dividendPayoutDate" : 0,
  //   
  // };
}