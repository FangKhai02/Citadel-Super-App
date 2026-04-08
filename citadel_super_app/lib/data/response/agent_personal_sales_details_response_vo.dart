// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_personal_sales_details_vo.dart';


part 'agent_personal_sales_details_response_vo.freezed.dart';
part 'agent_personal_sales_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentPersonalSalesDetailsResponseVo with _$AgentPersonalSalesDetailsResponseVo {
  AgentPersonalSalesDetailsResponseVo._();

  factory AgentPersonalSalesDetailsResponseVo({
     String? code,
     String? message,
     List<AgentPersonalSalesDetailsVo>? salesDetails,
    
  }) = _AgentPersonalSalesDetailsResponseVo;
  
  factory AgentPersonalSalesDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$AgentPersonalSalesDetailsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "salesDetails" : AgentPersonalSalesDetailsVo.toExampleApiJson(),
  //   
  // };
}