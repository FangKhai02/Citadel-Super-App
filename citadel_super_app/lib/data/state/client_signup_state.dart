import 'package:citadel_super_app/data/vo/client_identity_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/employment_details_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientSignUp {
  ClientIdentityDetailsRequestVo? clientIdentityDetailsRequestVo;
  ClientPersonalDetailsRequestVo? clientPersonalDetailsRequestVo;
  PepDeclarationVo? pepDeclarationVo;
  EmploymentDetailsVo? employmentDetailsVo;
  String? selfieImage;
  String? signature;

  ClientSignUp(
      {this.clientIdentityDetailsRequestVo,
      this.clientPersonalDetailsRequestVo,
      this.pepDeclarationVo,
      this.employmentDetailsVo,
      this.selfieImage,
      this.signature});

  ClientSignUp copyWith({
    ClientIdentityDetailsRequestVo? clientIdentityDetailsRequestVo,
    ClientPersonalDetailsRequestVo? clientPersonalDetailsRequestVo,
    PepDeclarationVo? pepDeclarationVo,
    EmploymentDetailsVo? employmentDetailsVo,
    String? selfieImage,
    String? signature,
  }) {
    return ClientSignUp(
      clientIdentityDetailsRequestVo:
          clientIdentityDetailsRequestVo ?? this.clientIdentityDetailsRequestVo,
      clientPersonalDetailsRequestVo:
          clientPersonalDetailsRequestVo ?? this.clientPersonalDetailsRequestVo,
      pepDeclarationVo: pepDeclarationVo ?? this.pepDeclarationVo,
      employmentDetailsVo: employmentDetailsVo ?? this.employmentDetailsVo,
      selfieImage: selfieImage ?? this.selfieImage,
      signature: signature ?? this.signature,
    );
  }
}

final clientSignUpProvider =
    StateNotifierProvider.autoDispose<ClientSignUpState, ClientSignUp>((ref) {
  return ClientSignUpState();
});

class ClientSignUpState extends StateNotifier<ClientSignUp> {
  ClientSignUpState() : super(ClientSignUp());

  void setClientIdentityDetailsRequestVo(
      ClientIdentityDetailsRequestVo clientIdentityDetailsRequestVo) {
    state = state.copyWith(
        clientIdentityDetailsRequestVo: clientIdentityDetailsRequestVo);
  }

  void setClientPersonalDetailsRequestVo(
      ClientPersonalDetailsRequestVo clientPersonalDetailsRequestVo) {
    state = state.copyWith(
        clientPersonalDetailsRequestVo: clientPersonalDetailsRequestVo);
  }

  void setPepDeclarationVo(PepDeclarationVo pepDeclarationVo) {
    state = state.copyWith(pepDeclarationVo: pepDeclarationVo);
  }

  void setEmploymentDetailsVo(EmploymentDetailsVo employmentDetailsVo) {
    state = state.copyWith(employmentDetailsVo: employmentDetailsVo);
  }

  void setSignature(String signature) {
    state = state.copyWith(signature: signature);
  }

  void setSelfieImage(String selfieImage) {
    state = state.copyWith(selfieImage: selfieImage);
  }
}
