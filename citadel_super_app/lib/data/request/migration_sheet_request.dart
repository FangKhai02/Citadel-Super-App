// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'migration_sheet_request.freezed.dart';
part 'migration_sheet_request.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class MigrationSheetRequest with _$MigrationSheetRequest {
  MigrationSheetRequest._();

  factory MigrationSheetRequest({
     List<int>? sheetIndexList,
    
  }) = _MigrationSheetRequest;
  
  factory MigrationSheetRequest.fromJson(Map<String, dynamic> json) => _$MigrationSheetRequestFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'sheetIndexList' : int.toExampleApiJson(),
  //   
  // };
}