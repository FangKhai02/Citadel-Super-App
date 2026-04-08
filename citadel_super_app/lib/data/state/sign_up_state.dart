import 'dart:io';

import 'package:citadel_super_app/data/model/sign_up/employment.dart';
import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';
import 'package:citadel_super_app/data/model/sign_up.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpProvider = StateNotifierProvider<SignUpState, SignUp>((ref) {
  return SignUpState();
});

class SignUpState extends StateNotifier<SignUp> {
  SignUpState() : super(SignUp(signUpType: SignUpAs.client));

  void setSignUpType(SignUpAs signUpType) {
    state = state.copyWith(signUpType: signUpType);
  }

  void setPEPDeclarationPoliticalRelated(bool? isPEP) {
    if (isPEP == null) {
      state = state.copyWith(pepDeclarationModel: PepDeclaration());
    } else {
      state = state.copyWith(
          pepDeclarationModel:
              state.getPepDeclarationModel.copyWith(politicalRelated: isPEP));
    }
  }

  void setPepDeclarationRelationship(RelationshipWithPep relationship) {
    state = state.copyWith(
        pepDeclarationModel: state.getPepDeclarationModel
            .copyWith(relationshipWithPep: relationship));
  }

  void setPepDeclarationDetails(
      {String? fullName, String? designation, String? organisation}) {
    state = state.copyWith(
        pepDeclarationModel: state.getPepDeclarationModel.copyWith(
            name: fullName,
            designation: designation,
            organisation: organisation));
  }

  void setSupportingDoc(File? file) {
    state = state.copyWith(
        pepDeclarationModel:
            state.getPepDeclarationModel.copyWith(supportingDoc: file));
  }

  void setEmploymentType(EmploymentType? employmentType) {
    state = state.copyWith(
        employment:
            state.getEmployment.copyWith(employmentType: employmentType));
  }
}
