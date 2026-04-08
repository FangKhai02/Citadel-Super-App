import 'dart:convert';
import 'dart:io';

import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:collection/collection.dart';

enum RelationshipWithPep {
  self,
  familyMember,
  closeAssociate;

  String get toKeyword {
    switch (this) {
      case self:
        return "SELF";
      case familyMember:
        return "FAMILY";
      case closeAssociate:
        return "ASSOCIATE";
    }
  }
}

List<ListTileSelection> get getPepRelationshipList => [
      ListTileSelection(
        text: 'Self',
      ),
      ListTileSelection(
        text: 'Immediate Family Member',
      ),
      ListTileSelection(
        text: 'Close Associate',
      ),
    ];

int? getPepRelationshipIndex(String relationship) {
  if (relationship.isEmpty) {
    return null;
  }
  final listItem = getPepRelationshipList.firstWhereOrNull((item) {
    return item.text.equalsIgnoreCase(relationship);
  });
  if (listItem != null) {
    return getPepRelationshipList
        .indexWhere((element) => element.text == listItem.text);
  }
  return null;
}

class PepDeclaration {
  bool? politicalRelated;
  RelationshipWithPep? relationshipWithPep;
  String? name;
  String? designation;
  String? organisation;
  File? supportingDoc;

  bool get getPoliticalRelated => politicalRelated ?? false;
  RelationshipWithPep? get getRelationshipWithPep => relationshipWithPep;
  String get getName => name ?? '';
  String get getDesignation => designation ?? '';
  String get getOrganisation => organisation ?? '';
  File? get getSupportingDoc => supportingDoc;
  String? get getSupportingDocInBase64 => supportingDoc == null
      ? null
      : base64Encode(supportingDoc!.readAsBytesSync());

  PepDeclaration({
    this.politicalRelated,
    this.relationshipWithPep,
    this.name,
    this.designation,
    this.organisation,
    this.supportingDoc,
  });

  PepDeclaration copyWith({
    bool? politicalRelated,
    RelationshipWithPep? relationshipWithPep,
    String? name,
    String? designation,
    String? organisation,
    File? supportingDoc,
  }) {
    return PepDeclaration(
      politicalRelated: politicalRelated ?? this.politicalRelated,
      relationshipWithPep: relationshipWithPep ?? this.relationshipWithPep,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      organisation: organisation ?? this.organisation,
      supportingDoc: supportingDoc,
    );
  }
}
