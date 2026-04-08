// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corresponding_address.freezed.dart';
part 'corresponding_address.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorrespondingAddress with _$CorrespondingAddress {
  CorrespondingAddress._();

  factory CorrespondingAddress({
     bool? isSameCorrespondingAddress, 
     String? correspondingAddress, 
     String? correspondingPostcode, 
     String? correspondingCity, 
     String? correspondingState, 
     String? correspondingCountry, 
     String? correspondingAddressProofKey, 
    
  }) = _CorrespondingAddress;
  
  factory CorrespondingAddress.fromJson(Map<String, dynamic> json) => _$CorrespondingAddressFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'isSameCorrespondingAddress' : false,
  //   'correspondingAddress' : 'string',
  //   'correspondingPostcode' : 'string',
  //   'correspondingCity' : 'string',
  //   'correspondingState' : 'string',
  //   'correspondingCountry' : 'string',
  //   'correspondingAddressProofKey' : 'string',
  //   
  // };
}