// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_two_signature_request_vo.freezed.dart';
part 'client_two_signature_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientTwoSignatureRequestVo with _$ClientTwoSignatureRequestVo {
  ClientTwoSignatureRequestVo._();

  factory ClientTwoSignatureRequestVo({
     String? uniqueIdentifier,
     String? signatureImage,
     String? name,
     String? idNumber,
     String? role,
    
  }) = _ClientTwoSignatureRequestVo;
  
  factory ClientTwoSignatureRequestVo.fromJson(Map<String, dynamic> json) => _$ClientTwoSignatureRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'uniqueIdentifier' : 'string',
  //   'signatureImage' : 'string',
  //   'name' : 'string',
  //   'idNumber' : 'string',
  //   'role' : 'string',
  //   
  // };
}