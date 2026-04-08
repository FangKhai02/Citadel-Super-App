// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/niu_apply_document_vo.dart';
import '../vo/niu_apply_signee_vo.dart';
import '../vo/niu_apply_signee_vo.dart';


part 'niu_apply_requestuest_vo.freezed.dart';
part 'niu_apply_requestuest_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NiuApplyRequestuestVo with _$NiuApplyRequestuestVo {
  NiuApplyRequestuestVo._();

  factory NiuApplyRequestuestVo({
     int? amountRequested,
     String? tenure,
     String? applicationType,
     String? name,
     String? documentNumber,
     String? address,
     String? postcode,
     String? city,
     String? state,
     String? country,
     String? mobileCountryCode,
     String? mobileNumber,
     String? email,
     String? natureOfBusiness,
     String? purposeOfAdvances,
     List<NiuApplyDocumentVo>? documents,
     NiuApplySigneeVo? firstSignee,
     NiuApplySigneeVo? secondSignee,
    
  }) = _NiuApplyRequestuestVo;
  
  factory NiuApplyRequestuestVo.fromJson(Map<String, dynamic> json) => _$NiuApplyRequestuestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'amountRequested' : 0,
  //   'tenure' : 'string',
  //   'applicationType' : 'string',
  //   'name' : 'string',
  //   'documentNumber' : 'string',
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   'natureOfBusiness' : 'string',
  //   'purposeOfAdvances' : 'string',
  //   'documents' : NiuApplyDocumentVo.toExampleApiJson(),
  //   'firstSignee' : NiuApplySigneeVo.toExampleApiJson(),
  //   'secondSignee' : NiuApplySigneeVo.toExampleApiJson(),
  //   
  // };
}