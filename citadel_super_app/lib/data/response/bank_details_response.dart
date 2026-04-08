// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/bank_details_vo.dart';


part 'bank_details_response.freezed.dart';
part 'bank_details_response.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class BankDetailsResponse with _$BankDetailsResponse {
  BankDetailsResponse._();

  factory BankDetailsResponse({
     String? code,
     String? message,
     List<BankDetailsVo>? bankDetails,
    
  }) = _BankDetailsResponse;
  
  factory BankDetailsResponse.fromJson(Map<String, dynamic> json) => _$BankDetailsResponseFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "bankDetails" : BankDetailsVo.toExampleApiJson(),
  //   
  // };
}