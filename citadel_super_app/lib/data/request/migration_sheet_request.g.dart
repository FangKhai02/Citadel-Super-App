// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'migration_sheet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MigrationSheetRequestImpl _$$MigrationSheetRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$MigrationSheetRequestImpl(
      sheetIndexList: (json['sheetIndexList'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$MigrationSheetRequestImplToJson(
        _$MigrationSheetRequestImpl instance) =>
    <String, dynamic>{
      'sheetIndexList': instance.sheetIndexList,
    };
