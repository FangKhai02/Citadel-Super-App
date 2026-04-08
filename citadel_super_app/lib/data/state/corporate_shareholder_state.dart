import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_request_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_options_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final corporateShareholderProvider = StateNotifierProvider<
    CorporateShareholderProviderState, CorporateShareholderRequestVo>((ref) {
  return CorporateShareholderProviderState();
});

class CorporateShareholderProviderState
    extends StateNotifier<CorporateShareholderRequestVo> {
  CorporateShareholderProviderState() : super(CorporateShareholderRequestVo());

  CorporateShareholderRequestVo setCorporateShareholder(
      docType, formData, String icNo) {
    final address = formData[AppFormFieldKey.addressDetailsFormKey] as Address;

    state = state.copyWith(
      name: formData[AppFormFieldKey.nameKey],
      identityCardNumber: icNo,
      percentageOfShareholdings:
          double.parse(formData[AppFormFieldKey.percentageKey]),
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      address: address.street,
      postcode: address.postCode,
      city: address.city,
      state: address.state,
      country: address.country,
      identityDocumentType: docType,
      identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
      identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey],
    );

    return state;
  }

  CorporateShareholderRequestVo setCorporateShareholderPep(
      PepDeclarationVo pep) {
    state = state.copyWith(pepDeclaration: pep);

    return state;
  }

  void setPEPDeclarationPoliticalRelated(bool isPEP) {
    state = state.copyWith(
      pepDeclaration:
          (state.pepDeclaration ?? PepDeclarationVo()).copyWith(isPep: isPEP),
    );
  }

  void setPepDeclarationRelationship(RelationshipWithPep relationship) {
    state = state.copyWith(
      pepDeclaration: (state.pepDeclaration ?? PepDeclarationVo()).copyWith(
        pepDeclarationOptions: (state.pepDeclaration?.pepDeclarationOptions ??
                PepDeclarationOptionsVo())
            .copyWith(
          relationship: relationship.toKeyword,
        ),
      ),
    );
  }

  PepDeclarationVo? setPepDeclarationDetails(
      Map<String, dynamic> formData, String? name) {
    state = state.copyWith(
      pepDeclaration: (state.pepDeclaration ?? PepDeclarationVo()).copyWith(
        pepDeclarationOptions: (state.pepDeclaration?.pepDeclarationOptions ??
                PepDeclarationOptionsVo())
            .copyWith(
          name: (state.pepDeclaration?.pepDeclarationOptions?.relationship ==
                  'SELF')
              ? state.name ?? name
              : formData[AppFormFieldKey.immediateFamilyNameKey],
          position: formData[AppFormFieldKey.designationKey],
          organization: formData[AppFormFieldKey.organisationKey],
          supportingDocument:
              (formData[AppFormFieldKey.proofDocKey] as List<Document>)
                  .first
                  .base64EncodeStr,
        ),
      ),
    );
    return state.pepDeclaration;
  }
}
