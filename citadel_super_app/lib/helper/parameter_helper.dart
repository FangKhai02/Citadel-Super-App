import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/model/corresponding_address.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/request/agent_pin_request_vo.dart';
import 'package:citadel_super_app/data/request/agent_product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/request/agent_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/request/client_profile_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_bank_details_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_bank_details_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_beneficiary_creation_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_beneficiary_update_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_documents_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_guardian_creation_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_guardian_update_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_beneficiary_create_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_beneficiary_update_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_guardian_create_request_vo.dart';
import 'package:citadel_super_app/data/request/individual_guardian_update_request_vo.dart';
import 'package:citadel_super_app/data/request/product_early_redemption_request_vo.dart';
import 'package:citadel_super_app/data/request/product_purchase_request_vo.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_address_details_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_client_user_details_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_client_validate_two_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_edit_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_request_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_request_vo.dart';
import 'package:citadel_super_app/data/request/change_password_request_vo.dart';
import 'package:citadel_super_app/data/request/client_guardian_creation_request_vo.dart';
import 'package:citadel_super_app/data/vo/client_identity_details_request_vo.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_request_vo.dart';
import 'package:citadel_super_app/data/request/client_pin_request_vo.dart';
import 'package:citadel_super_app/data/request/client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/request/contact_us_form_submit_request_vo.dart';
import 'package:citadel_super_app/data/request/login_requestuest_vo.dart';
import 'package:citadel_super_app/data/request/reset_password_request_vo.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/vo/agent_personal_details_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_documents_vo.dart';
import 'package:citadel_super_app/data/vo/employment_details_vo.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_options_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_contact_details_vo.dart';
import 'package:citadel_super_app/data/vo/sign_up_base_identity_details_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:recase/recase.dart';

class ParameterHelper {
  SignUpBaseIdentityDetailsVo agentIdentifyValidationParam(docType, formData) {
    return SignUpBaseIdentityDetailsVo(
      fullName: formData[AppFormFieldKey.nameKey],
      identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
      dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
      identityDocumentType: docType,
      identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
      identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey],
    );
  }

  SignUpBaseContactDetailsVo agentContactValidationParam(formData) {
    Address addressObj = formData[AppFormFieldKey.addressDetailsFormKey];
    final proofDocument =
        (formData[AppFormFieldKey.proofDocKey] as List<Document>).first;

    return SignUpBaseContactDetailsVo(
      address: addressObj.street,
      postcode: addressObj.postCode,
      city: addressObj.city,
      state: addressObj.state.toCamelCase(),
      country: addressObj.country,
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      proofOfAddressFile: proofDocument.base64EncodeStr,
    );
  }

  AgentSignUpRequestVo agentSignUpParam(
      {required AgentSignUp agentSignUp, required String password}) {
    return AgentSignUpRequestVo(
      identityDetails: agentSignUp.signUpBaseIdentityDetailsVo,
      contactDetails: agentSignUp.signUpBaseContactDetailsVo,
      selfieImage: agentSignUp.selfieImage,
      agencyDetails: agentSignUp.signUpAgentAgencyDetailsRequestVo,
      bankDetails: agentSignUp.bankDetailsVo,
      digitalSignature: agentSignUp.signature,
      password: password,
    );
  }

  ClientIdentityDetailsRequestVo clientIdentifyValidationParam(
      docType, formData, {String? frontImage, String? backImage}) {
    return ClientIdentityDetailsRequestVo(
      fullName: formData[AppFormFieldKey.nameKey],
      identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
      dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
      gender: (formData[AppFormFieldKey.genderKey]).toString().constantCase,
      nationality: formData[AppFormFieldKey.nationalityKey],
      identityDocumentType: docType,
      identityCardFrontImage: frontImage,
      identityCardBackImage: backImage,
    );
  }

  ClientPersonalDetailsRequestVo clientPersonalDetailsValidationParam(
      formData) {
    final proofDocument =
        (formData[AppFormFieldKey.proofDocKey] as List<Document>).first;

    final String camelState = formData[AppFormFieldKey.stateKey];
    final String camelCorrespondingState =
        formData[AppFormFieldKey.correspondingStateKey];

    return ClientPersonalDetailsRequestVo(
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
      correspondingAddress: CorrespondingAddress(
        isSameCorrespondingAddress:
            formData[AppFormFieldKey.sameRegisteredAddressKey],
        correspondingAddress: formData[AppFormFieldKey.correspondingAddressKey],
        correspondingPostcode:
            formData[AppFormFieldKey.correspondingPostcodeKey],
        correspondingCity: formData[AppFormFieldKey.correspondingCityKey],
        correspondingState: camelCorrespondingState.toCamelCase(),
        correspondingCountry: formData[AppFormFieldKey.correspondingCountryKey],
        correspondingAddressProofKey:
            (formData[AppFormFieldKey.proofDocKey] as List<Document>)
                .first
                .base64EncodeStr,
      ),
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      proofOfAddressFile: proofDocument.base64EncodeStr,
      maritalStatus:
          formData[AppFormFieldKey.maritalStatusKey].toString().constantCase,
      residentialStatus: formData[AppFormFieldKey.residentialStatusKey]
          .toString()
          .constantCase,
      agentReferralCode: formData[AppFormFieldKey.agentReferralCodeKey].isEmpty
          ? null
          : formData[AppFormFieldKey.agentReferralCodeKey],
    );
  }

  ClientSignUpRequestVo clientSignUpParam(
      {required ClientSignUp clientSignUp, required String password}) {
    return ClientSignUpRequestVo(
      identityDetails: clientSignUp.clientIdentityDetailsRequestVo,
      personalDetails: clientSignUp.clientPersonalDetailsRequestVo,
      selfieImage: clientSignUp.selfieImage,
      pepDeclaration: clientSignUp.pepDeclarationVo,
      employmentDetails: clientSignUp.employmentDetailsVo,
      digitalSignature: clientSignUp.signature,
      password: password,
    );
  }

  LoginRequestuestVo loginParam(formData) {
    return LoginRequestuestVo(
      email: formData[AppFormFieldKey.emailKey],
      password: formData[AppFormFieldKey.passwordKey],
      oneSignalSubscriptionId: OneSignal.User.pushSubscription.id,
    );
  }

  EmploymentDetailsVo employmentDetailsValidationParam(formData) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return EmploymentDetailsVo(
      employmentType:
          formData[AppFormFieldKey.employmentTypeKey].toString().constantCase,
      employerName: formData[AppFormFieldKey.employerNameKey],
      industryType: formData[AppFormFieldKey.industryTypeKey],
      jobTitle: formData[AppFormFieldKey.jobTitleKey],
      employerAddress: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
    );
  }

  BankDetailsRequestVo bankDetailsValidationParam(formData) {
    final proofDocument =
        (formData[AppFormFieldKey.proofDocKey] as List<Document>).first;

    return BankDetailsRequestVo(
      bankName: formData[AppFormFieldKey.bankNameKey],
      accountNumber: formData[AppFormFieldKey.bankAccountNumberKey],
      accountHolderName: formData[AppFormFieldKey.accountBankHolderNameKey],
      bankAddress: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: formData[AppFormFieldKey.stateKey],
      country: formData[AppFormFieldKey.countryKey],
      swiftCode: formData[AppFormFieldKey.swiftCodeKey],
      bankAccountProofFile: proofDocument.base64EncodeStr,
    );
  }

  BankDetailsRequestVo createBankDetailParam(formData) {
    final proofDocument =
        (formData[AppFormFieldKey.proofDocKey] as List<Document>).first;

    return BankDetailsRequestVo(
      bankName: formData[AppFormFieldKey.bankNameKey],
      accountNumber: formData[AppFormFieldKey.bankAccountNumberKey],
      accountHolderName: formData[AppFormFieldKey.accountBankHolderNameKey],
      bankAddress: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: formData[AppFormFieldKey.stateKey],
      country: formData[AppFormFieldKey.countryKey],
      swiftCode: formData[AppFormFieldKey.swiftCodeKey],
      bankAccountProofFile: proofDocument.base64EncodeStr,
    );
  }

  IndividualBeneficiaryUpdateRequestVo updateClientBeneficiaryParam(
      formData, IndividualBeneficiaryVo? beneficiary) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return IndividualBeneficiaryUpdateRequestVo(
        fullName: formData[AppFormFieldKey.nameKey],
        relationshipToSettlor:
            formData[AppFormFieldKey.relationshipToSettlorKey],
        gender: formData[AppFormFieldKey.genderKey],
        nationality: formData[AppFormFieldKey.nationalityKey],
        address: formData[AppFormFieldKey.addressKey],
        postcode: formData[AppFormFieldKey.postcodeKey],
        city: formData[AppFormFieldKey.cityKey],
        state: camelState.toCamelCase(),
        country: formData[AppFormFieldKey.countryKey],
        residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
        maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
        mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
        mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
        email: formData[AppFormFieldKey.emailKey],
        identityCardBackImage: beneficiary?.identityCardBackImageKey,
        identityCardFrontImage: beneficiary?.identityCardFrontImageKey,
        identityCardNumber: beneficiary?.identityCardNumber,
        identityDocumentType: beneficiary?.identityDocumentType,
        guardianId: beneficiary?.guardian?.id,
        relationshipToGuardian: beneficiary?.relationshipToGuardian,
        relationshipToBeneficiary: beneficiary?.relationshipToSettlor,
        dob: beneficiary?.dob);
  }

  IndividualBeneficiaryCreateRequestVo createClientBeneficiaryParam(
      String docType, formData) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return IndividualBeneficiaryCreateRequestVo(
      relationshipToSettlor: formData[AppFormFieldKey.relationshipToSettlorKey],
      fullName: formData[AppFormFieldKey.nameKey],
      identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
      dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
      gender: formData[AppFormFieldKey.genderKey],
      nationality: formData[AppFormFieldKey.nationalityKey],
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
      residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
      maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      identityDocumentType: docType,
      identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
      identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey],
    );
  }

  IndividualGuardianCreateRequestVo createClientGuardianParam(
      String? docType, formData, int? beneficiaryId) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return IndividualGuardianCreateRequestVo(
      beneficiaryId: beneficiaryId,
      fullName: formData[AppFormFieldKey.nameKey],
      identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
      dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
      gender: formData[AppFormFieldKey.genderKey],
      nationality: formData[AppFormFieldKey.nationalityKey],
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
      residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
      maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      identityDocumentType: docType,
      identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
      identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey],
      relationshipToGuardian:
          formData[AppFormFieldKey.relationshipToBeneficiaryKey],
    );
  }

  ClientGuardianCreationRequestVo
      createClientGuardianFromExistingBeneficiaryParam(
          IndividualBeneficiaryVo existingBeneficiary, int beneficiaryId) {
    return ClientGuardianCreationRequestVo(
      beneficiaryId: beneficiaryId,
      fullName: existingBeneficiary.fullName,
      identityCardNumber: existingBeneficiary.identityCardNumber,
      dob: existingBeneficiary.dob,
      gender: existingBeneficiary.gender,
      nationality: existingBeneficiary.nationality,
      address: existingBeneficiary.address,
      postcode: existingBeneficiary.postcode,
      city: existingBeneficiary.city,
      state: existingBeneficiary.state,
      country: existingBeneficiary.country,
      residentialStatus: existingBeneficiary.residentialStatus,
      maritalStatus: existingBeneficiary.maritalStatus,
      // mobileCountryCode: existingBeneficiary.mobileCountryCode,
      mobileNumber: existingBeneficiary.mobileNumber,
      email: existingBeneficiary.email,
      // identityCardFrontImage: existingBeneficiary.image,
      // identityCardBackImage: existingBeneficiary.,
      // relationshipToGuardian:
      //     formData[AppFormFieldKey.relationshipToBeneficiaryKey],
    );
  }

  ChangePasswordRequestVo changePasswordParam(
      String oldPassword, String? newPassword) {
    if (newPassword == null) {
      return ChangePasswordRequestVo(
        oldPassword: oldPassword,
      );
    } else {
      return ChangePasswordRequestVo(
          oldPassword: oldPassword, newPassword: newPassword);
    }
  }

  ClientPinRequestVo changePinParam({String? newPin, String? oldPin}) {
    if (newPin != null && oldPin != null) {
      return ClientPinRequestVo(newPin: newPin, oldPin: oldPin);
    }
    if (newPin != null) {
      return ClientPinRequestVo(newPin: newPin);
    }
    return ClientPinRequestVo(oldPin: oldPin);
  }

  AgentPinRequestVo changeAgentPinParam({String? newPin, String? oldPin}) {
    if (newPin != null && oldPin != null) {
      return AgentPinRequestVo(newPin: newPin, oldPin: oldPin);
    }
    if (newPin != null) {
      return AgentPinRequestVo(newPin: newPin);
    }
    return AgentPinRequestVo(oldPin: oldPin);
  }

  ContactUsFormSubmitRequestVo contactUsFormSubmitRequestVo(formData) {
    return ContactUsFormSubmitRequestVo(
      name: formData[AppFormFieldKey.nameKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      reason: formData[AppFormFieldKey.reasonKey],
      remark: formData[AppFormFieldKey.remarkKey],
    );
  }

  ResetPasswordRequestVo resetPasswordRequest(
      String email, String token, Map<String, dynamic> formData) {
    return ResetPasswordRequestVo(
      email: email,
      token: token,
      password: formData[AppFormFieldKey.passwordKey],
    );
  }

  AgentPersonalDetailsVo agentProfileUpdateParam(formData) {
    final address = formData[AppFormFieldKey.addressDetailsFormKey] as Address;

    return AgentPersonalDetailsVo(
      name: formData[AppFormFieldKey.nameKey],
      address: address.street,
      postcode: address.postCode,
      city: address.city,
      state: address.state,
      country: address.country,
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
    );
  }

  CorporateClientUserDetailsRequestVo corporateClientUserParam(formData) {
    return CorporateClientUserDetailsRequestVo(
      name: formData[AppFormFieldKey.nameKey],
      identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
      dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: formData[AppFormFieldKey.stateKey],
      country: formData[AppFormFieldKey.countryKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: formData[AppFormFieldKey.emailKey],
      identityCardFrontImageKey:
          formData[AppFormFieldKey.documentFrontImageKey],
      identityCardBackImageKey:
          (formData[AppFormFieldKey.documentBackImageKey] as String).isEmpty
              ? null
              : formData[AppFormFieldKey.documentBackImageKey],
    );
  }

  CorporateShareholderRequestVo validateCorporateShareholderParam(
      formData, String icNo) {
    final address = formData[AppFormFieldKey.addressDetailsFormKey] as Address;
    return CorporateShareholderRequestVo(
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
        identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
        identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey],
        pepDeclaration: PepDeclarationVo(
            isPep: true,
            pepDeclarationOptions: PepDeclarationOptionsVo(
                relationship: "SELF",
                name: "String",
                position: "String",
                organization: "String",
                supportingDocument: "String")));
  }

  CorporateShareholderEditRequestVo editCorporateShareholderParam(
      int id, formData) {
    final address = formData[AppFormFieldKey.addressDetailsFormKey] as Address;
    return CorporateShareholderEditRequestVo(
      corporateShareholderId: id,
      name: formData[AppFormFieldKey.nameKey],
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
    );
  }

  CorporateDetailsRequestVo corporateProfileParam(formData) {
    final address = formData[AppFormFieldKey.addressDetailsFormKey] as Address;
    final businessAddress =
        formData[AppFormFieldKey.companyAddressDetailsFormKey] as Address?;

    try {
      return CorporateDetailsRequestVo(
        entityName: formData[AppFormFieldKey.entityNameKey],
        entityType: formData[AppFormFieldKey.entityTypeKey],
        registrationNumber: formData[AppFormFieldKey.registrationNumberKey],
        dateIncorporate:
            (formData[AppFormFieldKey.incorporationDateKey] as String)
                .getEpochTime(),
        placeIncorporate: formData[AppFormFieldKey.incorporationPlaceKey],
        businessType: formData[AppFormFieldKey.businessTypeKey],
        registeredAddress: address.street,
        city: address.city,
        state: address.state.toCamelCase(),
        postcode: address.postCode,
        country: address.country,
        corporateAddressDetails: CorporateAddressDetailsVo(
          isDifferentRegisteredAddress: businessAddress != null,
          businessAddress: businessAddress?.street ?? address.street,
          businessCity: businessAddress?.city ?? address.city,
          businessState: businessAddress?.state ?? address.state,
          businessPostcode: businessAddress?.postCode ?? address.postCode,
          businessCountry: businessAddress?.country ?? address.country,
        ),
        contactName: formData[AppFormFieldKey.nameKey],
        contactIsMyself: formData[AppFormFieldKey.selfContactKey],
        contactDesignation: formData[AppFormFieldKey.designationKey],
        contactMobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
        contactMobileNumber: formData[AppFormFieldKey.mobileNumberKey],
        contactEmail: formData[AppFormFieldKey.emailKey],
      );
    } catch (e) {
      return CorporateDetailsRequestVo();
    }
  }

  CorporateClientValidateTwoRequestVo corporateDocValidationParam(
      CorporateClientSignUpRequestVo corporateSignUp) {
    return CorporateClientValidateTwoRequestVo(
        annualIncomeDeclaration: corporateSignUp.annualIncomeDeclaration,
        sourceOfIncome: corporateSignUp.sourceOfIncome,
        digitalSignature: corporateSignUp.digitalSignature);
  }

  CorporateBankDetailsRequestVo createCorporateBankParam(formData) {
    final proofDocument =
        (formData[AppFormFieldKey.proofDocKey] as List<Document>).first;

    return CorporateBankDetailsRequestVo(
      bankName: formData[AppFormFieldKey.bankNameKey],
      accountNumber: formData[AppFormFieldKey.bankAccountNumberKey],
      accountHolderName: formData[AppFormFieldKey.accountBankHolderNameKey],
      bankAddress: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: formData[AppFormFieldKey.stateKey],
      country: formData[AppFormFieldKey.countryKey],
      swiftCode: formData[AppFormFieldKey.swiftCodeKey],
      bankAccountProofFile: proofDocument.base64EncodeStr,
    );
  }

  CorporateBankDetailsEditRequestVo editCorporateBankParam(int? id, formData) {
    final proofDocument =
        (formData[AppFormFieldKey.proofDocKey] as List<Document>).first;

    return CorporateBankDetailsEditRequestVo(
      corporateBankDetailsId: id,
      bankName: formData[AppFormFieldKey.bankNameKey],
      accountNumber: formData[AppFormFieldKey.bankAccountNumberKey],
      accountHolderName: formData[AppFormFieldKey.accountBankHolderNameKey],
      bankAddress: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: formData[AppFormFieldKey.stateKey],
      country: formData[AppFormFieldKey.countryKey],
      swiftCode: formData[AppFormFieldKey.swiftCodeKey],
      bankAccountProofFile: proofDocument.base64EncodeStr,
    );
  }

  CorporateBeneficiaryUpdateRequestVo editCorporateBeneficiaryParam(formData) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return CorporateBeneficiaryUpdateRequestVo(
      fullName: formData[AppFormFieldKey.nameKey],
      relationshipToSettlor: formData[AppFormFieldKey.relationshipToSettlorKey],
      gender: formData[AppFormFieldKey.genderKey],
      nationality: formData[AppFormFieldKey.nationalityKey],
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
      residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
      maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: (formData[AppFormFieldKey.emailKey] as String).trim(),
    );
  }

  CorporateBeneficiaryCreationRequestVo createCorporateBeneficiaryParam(
      formData, String docType) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return CorporateBeneficiaryCreationRequestVo(
        relationshipToSettlor:
            formData[AppFormFieldKey.relationshipToSettlorKey],
        fullName: formData[AppFormFieldKey.nameKey],
        identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
        dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
        gender: formData[AppFormFieldKey.genderKey],
        nationality: formData[AppFormFieldKey.nationalityKey],
        address: formData[AppFormFieldKey.addressKey],
        postcode: formData[AppFormFieldKey.postcodeKey],
        city: formData[AppFormFieldKey.cityKey],
        state: camelState.toCamelCase(),
        country: formData[AppFormFieldKey.countryKey],
        residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
        maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
        mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
        mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
        email: (formData[AppFormFieldKey.emailKey] as String).trim(),
        documentType: docType.toUpperCase(),
        identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
        identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey]);
  }

  CorporateGuardianCreationRequestVo createCorporateGuardianParam(
      int? id, formData, String? docType) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return CorporateGuardianCreationRequestVo(
        corporateBeneficiaryId: id,
        fullName: formData[AppFormFieldKey.nameKey],
        identityCardNumber: formData[AppFormFieldKey.documentNumberKey],
        dob: (formData[AppFormFieldKey.dobKey] as String).getEpochTime(),
        gender: formData[AppFormFieldKey.genderKey],
        nationality: formData[AppFormFieldKey.nationalityKey],
        address: formData[AppFormFieldKey.addressKey],
        postcode: formData[AppFormFieldKey.postcodeKey],
        city: formData[AppFormFieldKey.cityKey],
        state: camelState.toCamelCase(),
        country: formData[AppFormFieldKey.countryKey],
        residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
        maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
        mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
        mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
        email: (formData[AppFormFieldKey.emailKey] as String).trim(),
        identityCardFrontImage: formData[AppFormFieldKey.documentFrontImageKey],
        identityCardBackImage: formData[AppFormFieldKey.documentBackImageKey],
        relationshipToGuardian:
            formData[AppFormFieldKey.relationshipToBeneficiaryKey],
        identityDocumentType: docType);
  }

  CorporateGuardianUpdateRequestVo editCorporateGuardianParam(formData) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return CorporateGuardianUpdateRequestVo(
      fullName: formData[AppFormFieldKey.nameKey],
      gender: formData[AppFormFieldKey.genderKey],
      nationality: formData[AppFormFieldKey.nationalityKey],
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
      residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
      maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: (formData[AppFormFieldKey.emailKey] as String).trim(),
    );
  }

  IndividualGuardianUpdateRequestVo editGuardianParam(formData) {
    final String camelState = formData[AppFormFieldKey.stateKey];
    return IndividualGuardianUpdateRequestVo(
      fullName: formData[AppFormFieldKey.nameKey],
      gender: formData[AppFormFieldKey.genderKey],
      nationality: formData[AppFormFieldKey.nationalityKey],
      address: formData[AppFormFieldKey.addressKey],
      postcode: formData[AppFormFieldKey.postcodeKey],
      city: formData[AppFormFieldKey.cityKey],
      state: camelState.toCamelCase(),
      country: formData[AppFormFieldKey.countryKey],
      residentialStatus: formData[AppFormFieldKey.residentialStatusKey],
      maritalStatus: formData[AppFormFieldKey.maritalStatusKey],
      mobileCountryCode: formData[AppFormFieldKey.countryCodeKey],
      mobileNumber: formData[AppFormFieldKey.mobileNumberKey],
      email: (formData[AppFormFieldKey.emailKey] as String).trim(),
    );
  }

  PepDeclarationVo editPepParam(
    ClientProfileResponseVo user,
    formData,
    bool? isPep,
    String? relationship,
  ) {
    if (isPep ?? false) {
      return PepDeclarationVo(
        isPep: isPep ?? user.pepDeclaration?.isPep,
        pepDeclarationOptions: PepDeclarationOptionsVo(
          relationship: relationship ??
              user.pepDeclaration?.pepDeclarationOptions?.relationship,
          name: (relationship ?? '').equalsIgnoreCase('SELF')
              ? user.personalDetails.nameDisplay
              : formData[AppFormFieldKey.immediateFamilyNameKey] ??
                  user.pepDeclaration?.pepDeclarationOptions?.name,
          position: formData[AppFormFieldKey.designationKey] ??
              user.pepDeclaration?.pepDeclarationOptions?.position,
          organization: formData[AppFormFieldKey.organisationKey] ??
              user.pepDeclaration?.pepDeclarationOptions?.organization,
          supportingDocument:
              (formData[AppFormFieldKey.proofDocKey] as List<Document>)
                  .first
                  .base64EncodeStr,
        ),
      );
    } else {
      return PepDeclarationVo(isPep: isPep ?? user.pepDeclaration?.isPep);
    }
  }

  ClientProfileEditRequestVo editProfileParam(
      Map formData, ClientProfileResponseVo user,
      {String? annualIncomeDeclaration, String? sourceOfIncome}) {
    try {
      //TODO:
      Address? address;
      Address? employerAddress;
      String? correspondingAddress;
      String? correspondingCity;
      String? correspondingState;
      String? correspondingCountry;
      String? correspondingPostcode;
      address = formData[AppFormFieldKey.addressDetailsFormKey] as Address?;

      employerAddress =
          formData[AppFormFieldKey.employmentAddressDetailsFormKey] as Address?;

      correspondingAddress = formData[AppFormFieldKey.correspondingAddressKey];
      correspondingCity = formData[AppFormFieldKey.correspondingCityKey];
      correspondingState = formData[AppFormFieldKey.correspondingStateKey];
      correspondingCountry = formData[AppFormFieldKey.correspondingCountryKey];
      correspondingPostcode =
          formData[AppFormFieldKey.correspondingPostcodeKey];

      return ClientProfileEditRequestVo(
          nationality: formData[AppFormFieldKey.nationalityKey],
          name: formData[AppFormFieldKey.nameKey] ??
              user.personalDetails.nameDisplay,
          address: address?.street ?? user.personalDetails.addressDisplay,
          postcode: address?.postCode ?? user.personalDetails.postcodeDisplay,
          city: address?.city ?? user.personalDetails.cityDisplay,
          state: address?.state ?? user.personalDetails.stateDisplay,
          country: address?.country ?? user.personalDetails.countryDisplay,
          mobileNumber: formData[AppFormFieldKey.mobileNumberKey] ??
              user.personalDetails.mobileNumberDisplay,
          mobileCountryCode: formData[AppFormFieldKey.countryCodeKey] ??
              user.personalDetails.mobileCountryCodeDisplay,
          email: formData[AppFormFieldKey.emailKey] ??
              user.personalDetails.emailDisplay,
          residentialStatus: formData[AppFormFieldKey.residentialStatusKey] ??
              user.personalDetails.residentialStatusDisplay,
          maritalStatus: formData[AppFormFieldKey.maritalStatusKey] ??
              user.personalDetails.maritalStatusDisplay,
          employmentDetails: EmploymentDetailsVo(
            employmentType: formData[AppFormFieldKey.employmentTypeKey] ??
                user.employmentDetails.employmentTypeDisplay,
            employerName: formData[AppFormFieldKey.employerNameKey] ??
                user.employmentDetails.employerNameDisplay,
            industryType: formData[AppFormFieldKey.industryTypeKey] ??
                user.employmentDetails.industryTypeDisplay,
            jobTitle: formData[AppFormFieldKey.jobTitleKey] ??
                user.employmentDetails.jobTitleDisplay,
            employerAddress: employerAddress?.street ??
                user.employmentDetails.employerAddressDisplay,
            postcode: employerAddress?.postCode ??
                user.employmentDetails.employerPostcodeDisplay,
            city: employerAddress?.city ??
                user.employmentDetails.employerCityDisplay,
            state: employerAddress?.state ??
                user.employmentDetails.employerStateDisplay,
            country: employerAddress?.country ??
                user.employmentDetails.employerCountryDisplay,
          ),
          correspondingAddress: CorrespondingAddress(
              isSameCorrespondingAddress:
                  formData[AppFormFieldKey.sameRegisteredAddressKey] ??
                      user.personalDetails?.correspondingAddress
                          ?.isSameCorrespondingAddress,
              correspondingAddress: correspondingAddress ??
                  user.personalDetails?.correspondingAddress
                      ?.correspondingAddress,
              correspondingPostcode: correspondingPostcode ??
                  user.personalDetails?.correspondingAddress
                      ?.correspondingPostcode,
              correspondingCity: correspondingCity ??
                  user.personalDetails?.correspondingAddress?.correspondingCity,
              correspondingState: correspondingState ??
                  user.personalDetails?.correspondingAddress
                      ?.correspondingState,
              correspondingCountry: correspondingCountry ??
                  user.personalDetails?.correspondingAddress?.correspondingCountry,
              correspondingAddressProofKey: (formData[AppFormFieldKey.proofDocKey] as List<Document>?)?.first.base64EncodeStr ?? user.personalDetails?.correspondingAddress?.correspondingAddressProofKey),
          annualIncomeDeclaration: annualIncomeDeclaration ?? user.wealthSourceDetails.annualIncomeDeclarationDisplay,
          sourceOfIncome: sourceOfIncome ?? user.wealthSourceDetails.sourceOfIncomeDisplay);
    } catch (e) {
      appDebugPrint(e);
      return ClientProfileEditRequestVo();
    }
  }

  CorporateDocumentsRequestVo uploadCorporateDocumentsParam(
      List<Document> documentList) {
    return CorporateDocumentsRequestVo(
        corporateDocuments: documentList
            .map((doc) => CorporateDocumentsVo(
                  id: doc.id,
                  fileName: doc.fileName,
                  file: doc.base64EncodeStr,
                ))
            .toList());
  }

  ProductPurchaseRequestVo agentProductPurchaseParam(
      String clientId, ProductPurchaseRequestVo req) {
    return ProductPurchaseRequestVo(
      clientId: clientId,
      productDetails: req.productDetails,
      clientBankId: req.clientBankId,
      beneficiaries: req.beneficiaries,
      paymentMethod: req.paymentMethod,
      corporateClientId: req.corporateClientId,
    );
  }

  ProductEarlyRedemptionRequestVo productEarlyRedemptionRequestVo(
    String referenceNumber,
    double redeemAmount,
    Map formData,
  ) {
    return ProductEarlyRedemptionRequestVo(
      orderReferenceNumber: referenceNumber,
      withdrawalAmount: redeemAmount,
      withdrawalMethod: formData[AppFormFieldKey.methodOfRedemptionKey],
      withdrawalReason: formData[AppFormFieldKey.reasonOfRedemptionKey],
      supportingDocumentKey: formData[AppFormFieldKey.proofDocKey] != null
          ? (formData[AppFormFieldKey.proofDocKey] as List<Document>)
              .first
              .base64EncodeStr
          : null,
    );
  }
}
