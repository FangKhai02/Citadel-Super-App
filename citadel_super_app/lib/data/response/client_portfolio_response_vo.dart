// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_portfolio_vo.dart';


part 'client_portfolio_response_vo.freezed.dart';
part 'client_portfolio_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientPortfolioResponseVo with _$ClientPortfolioResponseVo {
  ClientPortfolioResponseVo._();

  factory ClientPortfolioResponseVo({
     String? code,
     String? message,
     List<ClientPortfolioVo>? portfolio,
    
  }) = _ClientPortfolioResponseVo;
  
  factory ClientPortfolioResponseVo.fromJson(Map<String, dynamic> json) => _$ClientPortfolioResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "portfolio" : ClientPortfolioVo.toExampleApiJson(),
  //   
  // };
}