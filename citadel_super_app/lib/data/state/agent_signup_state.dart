import 'package:citadel_super_app/data/vo/bank_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_agent_agency_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_contact_details_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_identity_details_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final agentSignUpProvider =
    StateNotifierProvider.autoDispose<AgentSignUpState, AgentSignUp>((ref) {
  return AgentSignUpState();
});

class AgentSignUp {
  SignUpBaseIdentityDetailsVo? signUpBaseIdentityDetailsVo;
  SignUpBaseContactDetailsVo? signUpBaseContactDetailsVo;
  SignUpAgentAgencyDetailsRequestVo? signUpAgentAgencyDetailsRequestVo;
  BankDetailsRequestVo? bankDetailsVo;
  String? selfieImage;
  String? signature;

  AgentSignUp(
      {this.signUpBaseIdentityDetailsVo,
      this.signUpBaseContactDetailsVo,
      this.signUpAgentAgencyDetailsRequestVo,
      this.bankDetailsVo,
      this.selfieImage,
      this.signature});

  AgentSignUp copyWith({
    SignUpBaseIdentityDetailsVo? signUpBaseIdentityDetailsVo,
    SignUpBaseContactDetailsVo? signUpBaseContactDetailsVo,
    SignUpAgentAgencyDetailsRequestVo? signUpAgentAgencyDetailsRequestVo,
    BankDetailsRequestVo? bankDetailsVo,
    String? selfieImage,
    String? signature,
  }) {
    return AgentSignUp(
      signUpBaseIdentityDetailsVo:
          signUpBaseIdentityDetailsVo ?? this.signUpBaseIdentityDetailsVo,
      signUpBaseContactDetailsVo:
          signUpBaseContactDetailsVo ?? this.signUpBaseContactDetailsVo,
      signUpAgentAgencyDetailsRequestVo: signUpAgentAgencyDetailsRequestVo ??
          this.signUpAgentAgencyDetailsRequestVo,
      bankDetailsVo: bankDetailsVo ?? this.bankDetailsVo,
      selfieImage: selfieImage ?? this.selfieImage,
      signature: signature ?? this.signature,
    );
  }
}

class AgentSignUpState extends StateNotifier<AgentSignUp> {
  AgentSignUpState() : super(AgentSignUp());

  void setSignUpBaseIdentityDetailsVo(
      SignUpBaseIdentityDetailsVo signUpBaseIdentityDetailsVo) {
    state = state.copyWith(
        signUpBaseIdentityDetailsVo: signUpBaseIdentityDetailsVo);
  }

  void setSignUpBaseContactDetailsVo(
      SignUpBaseContactDetailsVo signUpBaseContactDetailsVo) {
    state =
        state.copyWith(signUpBaseContactDetailsVo: signUpBaseContactDetailsVo);
  }

  void setSignUpAgentAgencyDetailsRequestVo(
      SignUpAgentAgencyDetailsRequestVo signUpAgentAgencyDetailsRequestVo) {
    state = state.copyWith(
        signUpAgentAgencyDetailsRequestVo: signUpAgentAgencyDetailsRequestVo);
  }

  void setSignUpAgentAgencyDetailsRequestVoAgencyCode(String agencyId) {
    state = state.copyWith(
        signUpAgentAgencyDetailsRequestVo:
            (state.signUpAgentAgencyDetailsRequestVo ??
                    SignUpAgentAgencyDetailsRequestVo())
                .copyWith(agencyId: agencyId));
  }

  void setSignUpAgentAgencyDetailsRequestVoRecruitManagerCode(
      String recruitManagerCode) {
    state = state.copyWith(
        signUpAgentAgencyDetailsRequestVo:
            (state.signUpAgentAgencyDetailsRequestVo ??
                    SignUpAgentAgencyDetailsRequestVo())
                .copyWith(recruitManagerCode: recruitManagerCode));
  }

  void setBankDetailsVo(BankDetailsRequestVo bankDetailsVo) {
    state = state.copyWith(bankDetailsVo: bankDetailsVo);
  }

  void setSelfieImage(String selfieImage) {
    state = state.copyWith(selfieImage: selfieImage);
  }

  void setSignature(String signature) {
    state = state.copyWith(signature: signature);
  }
}
