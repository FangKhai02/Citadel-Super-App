// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'share_holdings_validation_request_vo.freezed.dart';
part 'share_holdings_validation_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ShareHoldingsValidationRequestVo with _$ShareHoldingsValidationRequestVo {
  ShareHoldingsValidationRequestVo._();

  factory ShareHoldingsValidationRequestVo({
     List<int>? shareHolderIds,
    
  }) = _ShareHoldingsValidationRequestVo;
  
  factory ShareHoldingsValidationRequestVo.fromJson(Map<String, dynamic> json) => _$ShareHoldingsValidationRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'shareHolderIds' : int.toExampleApiJson(),
  //   
  // };
}