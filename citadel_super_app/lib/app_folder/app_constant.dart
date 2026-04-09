class AppConstant {
  AppConstant._();

  static const String kServer = 'kServer';
  static const String kProd = 'kProd';
  static const String kUAT = 'kUat';
  static const String kDev = 'kDev';
  static const String kLocal = 'kLocal';
  static const String kApiKey = 'kApiKey';
}

class AppFormFieldKey {
  AppFormFieldKey._();

  //user details
  static const emailKey = 'email';
  static const passwordKey = 'password';
  static const confirmPasswordKey = 'confirmPassword';
  static const nameKey = 'name';
  static const documentNumberKey = 'documentNumber';
  static const dobKey = 'dob';
  static const addressKey = 'address';
  static const postcodeKey = 'postcode';
  static const cityKey = 'city';
  static const stateKey = 'state';
  static const countryKey = 'country';
  static const correspondingAddressKey = 'correspondingAddress';
  static const correspondingPostcodeKey = 'correspondingPostcode';
  static const correspondingCityKey = 'correspondingCity';
  static const correspondingStateKey = 'correspondingState';
  static const correspondingCountryKey = 'correspondingCountry';
  static const countryCodeKey = 'countryCode';
  static const mobileNumberKey = 'mobileNumber';
  static const nationalityKey = 'nationality';
  static const genderKey = 'gender';
  static const residentialStatusKey = 'residentialStatus';
  static const maritalStatusKey = 'maritalStatus';
  static const agentReferralCodeKey = 'agentReferralCode';
  static const documentImageKey = 'documentImage';
  static const documentFrontImageKey = 'documentFrontImage';
  static const documentBackImageKey = 'documentBackImage';
  static const documentTypeKey = 'documentType';
  static const proofDocKey = 'proofDoc';
  static const supportingDocumentKey = 'supportingDocument';
  static const reasonKey = 'reason';
  static const remarkKey = 'remark';
  static const differentRegisteredAddressKey = 'differentRegisteredAddress';
  static const sameRegisteredAddressKey = 'sameRegisteredAddress';
  static const selfContactKey = 'selfContact';
  static const bankcruptcyDeclarationKey = 'bankcruptcyDeclaration';
  static const accountDeleteReasonKey = 'accountDeleteReason';
  static const employmentAddressDetailsFormKey = 'employmentAddressDetailsForm';

  //wealth source
  static const sourceOfIncomeKey = 'sourceOfIncome';
  static const annualIncomeKey = 'annualIncome';
  static const annualTurnDeclarationKey = 'annualTurnDeclaration';

  //agency details
  static const agencyCodeKey = 'agencyCode';
  static const agencyIDKey = 'agencyID';
  static const recruitmentManagerKey = 'recruitmentManager';

  //bank details
  static const bankNameKey = 'bankName';
  static const bankAccountNumberKey = 'bankAccountNumber';
  static const accountBankHolderNameKey = 'accountBankHolderName';
  static const swiftCodeKey = 'swiftCode';

  //declaration details
  static const immediateFamilyNameKey = 'immediateFamilyName';
  static const designationKey = 'designation';
  static const organisationKey = 'organisation';

  //employment details
  static const employmentTypeKey = 'employmentType';
  static const industryTypeKey = 'industryType';
  static const jobTitleKey = 'jobTitle';
  static const employerNameKey = 'employerName';

  //Beneficiary details
  static const relationshipToSettlorKey = 'relationshipToSettlor';
  static const relationshipToBeneficiaryKey = 'relationshipToBeneficiary';
  static const percentageKey = 'percentage';

  //Fund
  static const redeemAmountKey = 'redeemAmount';
  static const investmentAmountKey = 'investmentAmount';
  static const amountRolloverKey = 'amountRollover';
  static const productReallocationKey = 'productReallocation';
  static const amountReallocationKey = 'amountReallocation';
  static const methodOfRedemptionKey = 'methodOfRedemption';
  static const reasonOfRedemptionKey = 'reasonOfRedemption';

  static const primaryButtonValidateKey = 'primaryButtonValidate';
  static const addressDetailsFormKey = 'addressDetailsForm';

  //Niu
  static const amountRequestedKey = 'amountRequested';
  static const tenureKey = 'tenure';
  static const natureOfBusinessKey = 'natureOfBusiness';
  static const purposeOfAdvanceKey = 'purposeOfAdvance';
  static const businessAddressDetailsFormKey = 'businessAddressDetailsForm';
  static const signeeDateKey = 'signeeDate';
  static const signeeOneKey = 'signee1';
  static const signeeTwoKey = 'signee2';

  //Pin
  static const pinKey = 'pin';

  //Corporate
  static const entityNameKey = 'entityName';
  static const entityTypeKey = 'entityType';
  static const businessTypeKey = 'businessType';
  static const registrationNumberKey = 'registrationNumber';
  static const incorporationDateKey = 'incorporationDate';
  static const incorporationPlaceKey = 'incorporationPlace';
  static const companyAddressDetailsFormKey = 'companyAddressDetailsForm';
  static const roleKey = 'role';
  static const shareHolderAddressDetailsFormKey =
      'shareHolderAddressDetailsForm';
}

class AppSettingsKey {
  AppSettingsKey._();

  static const contactUsUrl = "app.contact_us_url";
  static const termsAndConditionsUrl = "app.terms_and_conditions_url";
  static const privacyPolicyUrl = "app.privacy_policy_url";

  static const niuApplicationTenureOptions =
      "app.niu_application_tenure_options";
  static const methodOfRedemptionOfWithdrawal =
      "app.method_of_redemption_of_withdrawal";
  static const reasonOfWithdrawal = "app.reason_of_withdrawal";
  static const onboardingAgreement = "app.onboarding_agreement";
}

class AppConstantsKey {
  AppConstantsKey._();

  static const gender = 'gender';
  static const residentialStatus = "residential_status";
  static const relationshipToSettlor = "relationship";
  static const martialStatus = "marital_status";
  static const employmentType = "employment_type";
  static const industryType = "industry_type";
  static const relationship = "relationship";
  static const bankList = "bank_list";
  static const businessType = "business_type";
  static const contactUsReason = "contact_us_reason";
  static const niuTenurePeriod = 'niu_application_tenure';
  static const niuApplicationType = "niu_application_type";
  static const sourceIncomeType = "source_of_income";
  static const annualDeclarationType = "annual_turn_of_declaration";
  static const redemptionEarlyRedeem = 'redemption_method_early_redemption';
  static const redemptionMethodType = "redemption_method_matured";
  static const withdrawalReason = 'withdrawal_reason';
  static const corporateEntityType = 'corporate_type_of_entity';
}
