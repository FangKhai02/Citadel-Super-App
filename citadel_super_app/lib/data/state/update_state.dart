import 'dart:io';

import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateProvider = StateNotifierProvider<UpdateProvider, PepDeclaration>((ref) {
  return UpdateProvider();
});

class UpdateProvider extends StateNotifier<PepDeclaration> {
  UpdateProvider() : super(PepDeclaration());

  void setPEPDeclarationPoliticalRelated(bool? isPEP) {
    if (isPEP == null) {
      state = PepDeclaration();
    } else {
      state = state.copyWith(politicalRelated: isPEP);
    }
  }

  void setPepDeclarationRelationship(RelationshipWithPep relationship) {
    state = state.copyWith(relationshipWithPep: relationship);
  }

  void setPepDeclarationDetails({String? fullName, String? designation, String? organisation}) {
    state = state.copyWith(
      name: fullName,
      designation: designation,
      organisation: organisation,
    );
  }

  void setSupportingDoc(File? file) {
    state = state.copyWith(supportingDoc: file);
  }
}
