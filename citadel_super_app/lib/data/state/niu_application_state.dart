import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/request/niu_apply_requestuest_vo.dart';
import 'package:citadel_super_app/data/vo/niu_apply_document_vo.dart';
import 'package:citadel_super_app/data/vo/niu_apply_signee_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final niuApplicationProvider =
    StateNotifierProvider<NiuApplicationState, NiuApplyRequestuestVo>((ref) {
  return NiuApplicationState();
});

class NiuApplicationState extends StateNotifier<NiuApplyRequestuestVo> {
  NiuApplicationState() : super(NiuApplyRequestuestVo());

  void setAmountRequested(int amountRequested) {
    state = state.copyWith(amountRequested: amountRequested);
  }

  void setTenure(String tenure) {
    state = state.copyWith(tenure: tenure);
  }

  void setApplicationType(String applicationType) {
    state = state.copyWith(applicationType: applicationType);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDocumentNumber(String documentNumber) {
    state = state.copyWith(documentNumber: documentNumber);
  }

  void setAddress(Address address) {
    state = state.copyWith(
        address: address.street,
        postcode: address.postCode,
        city: address.city,
        state: address.state,
        country: address.country);
  }

  void setMobileNumber(String mobileCountryCode, String mobileNumber) {
    state = state.copyWith(
        mobileCountryCode: mobileCountryCode, mobileNumber: mobileNumber);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setNatureOfBusiness(String natureOfBusiness) {
    state = state.copyWith(natureOfBusiness: natureOfBusiness);
  }

  void setPurposeOfAdvances(String purposeOfAdvances) {
    state = state.copyWith(purposeOfAdvances: purposeOfAdvances);
  }

  void setDocuments(List<NiuApplyDocumentVo> documents) {
    state = state.copyWith(documents: documents);
  }

  void setFirstSignee(NiuApplySigneeVo firstSignee) {
    state = state.copyWith(firstSignee: firstSignee);
  }

  void setSecondSignee(NiuApplySigneeVo secondSignee) {
    state = state.copyWith(secondSignee: secondSignee);
  }
}
