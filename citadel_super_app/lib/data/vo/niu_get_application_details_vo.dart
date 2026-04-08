// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/niu_get_document_vo.dart';


part 'niu_get_application_details_vo.freezed.dart';
part 'niu_get_application_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NiuGetApplicationDetailsVo with _$NiuGetApplicationDetailsVo {
  NiuGetApplicationDetailsVo._();

  factory NiuGetApplicationDetailsVo({
     String? applicationType, 
     int? amountRequested, 
     String? requestedOn, 
     String? name, 
     String? documentNumber, 
     String? fullAddress, 
     String? fullMobileNumber, 
     String? email, 
     List<NiuGetDocumentVo>? documents, 
    
  }) = _NiuGetApplicationDetailsVo;
  
  factory NiuGetApplicationDetailsVo.fromJson(Map<String, dynamic> json) => _$NiuGetApplicationDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "applicationType" : 'string',
  //   "amountRequested" : 0,
  //   "requestedOn" : 'string',
  //   "name" : 'string',
  //   "documentNumber" : 'string',
  //   "fullAddress" : 'string',
  //   "fullMobileNumber" : 'string',
  //   "email" : 'string',
  //   "documents" : NiuGetDocumentVo.toExampleApiJson(),
  //   
  // };
}