import 'package:citadel_super_app/data/model/sign_up/employment.dart';
import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';

enum SignUpAs {
  client,
  agent,
}

class SignUp {
  SignUpAs? signUpType;
  PepDeclaration? pepDeclarationModel;
  Employment? employment;

  SignUpAs get getSignUpType => signUpType ?? SignUpAs.client;
  PepDeclaration get getPepDeclarationModel =>
      pepDeclarationModel ?? PepDeclaration();
  Employment get getEmployment => employment ?? Employment();

  SignUp({this.signUpType, this.pepDeclarationModel, this.employment});

  SignUp copyWith({
    SignUpAs? signUpType,
    PepDeclaration? pepDeclarationModel,
    Employment? employment,
  }) {
    return SignUp(
      signUpType: signUpType ?? this.signUpType,
      pepDeclarationModel: pepDeclarationModel ?? this.pepDeclarationModel,
      employment: employment ?? this.employment,
    );
  }
}
