// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_wealth_source_details_vo.freezed.dart';
part 'client_wealth_source_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientWealthSourceDetailsVo with _$ClientWealthSourceDetailsVo {
  ClientWealthSourceDetailsVo._();

  factory ClientWealthSourceDetailsVo({
     String? annualIncomeDeclaration, 
     String? sourceOfIncome, 
    
  }) = _ClientWealthSourceDetailsVo;
  
  factory ClientWealthSourceDetailsVo.fromJson(Map<String, dynamic> json) => _$ClientWealthSourceDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "annualIncomeDeclaration" : 'string',
  //   "sourceOfIncome" : 'string',
  //   
  // };
}