import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_enum.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/project_widget/app_version_environment_switcher.dart';

class AppUrl {
  AppUrl._();

  static String environment = AppConstant.kUAT;

  static init() async {
    getEnvironment();
  }

  static Future<void> setEnvironment(String env) async {
    await SharedPreferenceHelper().setSelectedEnvironment(env);
    environment = env;
  }

  static Future<void> getEnvironment() async {
    environment = await SharedPreferenceHelper()
        .getSelectedEnvironment(key: AppConstant.kServer);
  }

  static String get getEnvironmentUrl {
    switch (environment) {
      case AppConstant.kUAT:
        return 'https://api.citadel.nexstream.com.my/citadelBackend';
      case AppConstant.kDev:
        return 'https://api.citadel.nexstream.com.my/citadelBackend';
      case AppConstant.kProd:
      default:
        return 'https://app.citadelgroup.com.my/citadelBackend';
    }
  }

  // Niu Controller
  static String get niuApply => "$getEnvironmentUrl/api/niu/apply";

  static String get getNiuApplication =>
      "$getEnvironmentUrl/api/niu/application";

  // Sign Up Controller
  static String get clientSignUp => "$getEnvironmentUrl/api/sign-up/client";

  static String get clientIdentityValidation =>
      "$getEnvironmentUrl/api/sign-up/client/validation/identity-details";

  static String get clientDetailsValidation =>
      "$getEnvironmentUrl/api/sign-up/client/validation/personal-details";

  static String agentSignUp({String? idNumber}) => idNumber != null
      ? "$getEnvironmentUrl/api/sign-up/agent?identityCardNumber=$idNumber"
      : "$getEnvironmentUrl/api/sign-up/agent";

  static String get agentContactValidation =>
      "$getEnvironmentUrl/api/sign-up/agent/validation/contact-details";

  static String get agentIdentityValidation =>
      "$getEnvironmentUrl/api/sign-up/agent/validation/identity-details";

  static String checkExistingClient(String idNumber) =>
      "$getEnvironmentUrl/api/sign-up/client?identityCardNumber=$idNumber";

  // Bank Controller
  static String bank(String? clientId) => clientId != null
      ? "$getEnvironmentUrl/api/bank?clientId=$clientId"
      : "$getEnvironmentUrl/api/bank";

  static String bankUpdate(int? bankId, {String? clientId}) => clientId != null
      ? "$getEnvironmentUrl/api/bank/edit?bankId=$bankId&clientId=$clientId"
      : "$getEnvironmentUrl/api/bank/edit?bankId=$bankId";

  static String bankCreate(String? clientId) => clientId != null
      ? "$getEnvironmentUrl/api/bank/create?clientId=$clientId"
      : "$getEnvironmentUrl/api/bank/create";

  static String bankDelete(int? bankId, {String? clientId}) => clientId != null
      ? "$getEnvironmentUrl/api/bank/delete?bankId=$bankId&clientId=$clientId"
      : "$getEnvironmentUrl/api/bank/delete?bankId=$bankId";

  // Agent Controller
  static String get getAgents => "$getEnvironmentUrl/api/agent/agents";

  static String get getAgentProfile => "$getEnvironmentUrl/api/agent/profile";

  static String get agentProfileUpdate =>
      "$getEnvironmentUrl/api/agent/profile/edit";

  static String getAgentClientList({String? agentId}) => agentId != null
      ? "$getEnvironmentUrl/api/agent/clients?agentId=$agentId"
      : "$getEnvironmentUrl/api/agent/clients";

  static String getAgentClientPortfolio(String clientId) =>
      "$getEnvironmentUrl/api/agent/client/portfolio?clientId=$clientId";

  static String getAgentClientTransactions(String clientId) =>
      "$getEnvironmentUrl/api/agent/client/transactions?clientId=$clientId";

  static String get updateAgentProfile =>
      "$getEnvironmentUrl/api/agent/profile/edit";

  static String get editAgentProfileImage =>
      "$getEnvironmentUrl/api/agent/profile-image/edit";

  static String secureTag(String clientId) =>
      "$getEnvironmentUrl/api/agent/secure-tag/$clientId";

  static String get createAgentPin => "$getEnvironmentUrl/api/agent/pin";

  static String agentProductPurchase(String? referenceNumber) => referenceNumber ==
          null
      ? "$getEnvironmentUrl/api/agent/purchase"
      : "$getEnvironmentUrl/api/agent/purchase?referenceNumber=$referenceNumber";

  static String get pendingAgreement =>
      "$getEnvironmentUrl/api/agent/pending-agreement";

  static String agentEarning({String? agentId}) => agentId != null
      ? "$getEnvironmentUrl/api/agent/earning?agentId=$agentId"
      : "$getEnvironmentUrl/api/agent/earning";

  static String agentPersonalSales(String? agentId) => agentId != null
      ? "$getEnvironmentUrl/api/agent/personal-sales/total-sales?agentId=$agentId"
      : "$getEnvironmentUrl/api/agent/personal-sales/total-sales";

  static String agentSalesDetails(String? agentId, int? month, int? year) {
    String url;
    url = agentId != null
        ? "$getEnvironmentUrl/api/agent/personal-sales/sales-details?agentId=$agentId"
        : "$getEnvironmentUrl/api/agent/personal-sales/sales-details";
    if (month != null && year != null) {
      if (agentId != null) {
        url += "&";
      } else {
        url += "?";
      }
      url += "month=$month&year=$year";
    }
    return url;
  }

  static String agentComissionOverriding(int? month, int? year) => month !=
              null &&
          year != null
      ? "$getEnvironmentUrl/api/agent/commission-overriding?month=$month&year=$year"
      : "$getEnvironmentUrl/api/agent/commission-overriding";

  static String agentDownline({String? agentId}) => agentId != null
      ? "$getEnvironmentUrl/api/agent/downline?agentId=$agentId"
      : "$getEnvironmentUrl/api/agent/downline";

  static String get agentDownlineList =>
      "$getEnvironmentUrl/api/agent/downline/list";

  static String agentComissionReport(String? agentId, int month, int year) =>
      agentId != null
          ? "$getEnvironmentUrl/api/agent/commission-report?agentId=$agentId&month=$month&year=$year"
          : "$getEnvironmentUrl/api/agent/commission-report?month=$month&year=$year";

  // App Controller
  static String get getSettings => "$getEnvironmentUrl/api/app/settings";

  static String get getAgencies => "$getEnvironmentUrl/api/app/agency";

  static String get getConstants => "$getEnvironmentUrl/api/app/constants";

  static String get getMaintenance => "$getEnvironmentUrl/api/app/maintenance";

  static String get getAppUser => "$getEnvironmentUrl/api/app/user";

  static String get contactUs => "$getEnvironmentUrl/api/app/contact-us";

  static String get deleteAccount => "$getEnvironmentUrl/api/app/user/delete";

  static String get imageValidate =>
      "$getEnvironmentUrl/api/app/face-id/image-validate";

  static String get faceCompare =>
      "$getEnvironmentUrl/api/app/face-id/compare";

  static String forceUpdate(String appVersion, String platform) =>
      "$getEnvironmentUrl/api/app/force-update/$appVersion/$platform";

  // Client Controller
  static String get clientPin => "$getEnvironmentUrl/api/client/pin";

  static String clientProfile(String? clientId) => clientId != null
      ? "$getEnvironmentUrl/api/client/profile?clientId=$clientId"
      : "$getEnvironmentUrl/api/client/profile";

  static String get clientProfileEdit => "$getEnvironmentUrl/api/client/edit";

  static String get clientProfileImageEdit =>
      "$getEnvironmentUrl/api/client/profile-image/edit";

  static String clientBeneficiaries(String? clientId) => clientId != null
      ? "$getEnvironmentUrl/api/client/beneficiaries?clientId=$clientId"
      : "$getEnvironmentUrl/api/client/beneficiaries";

  static String clientBeneficiaryCreate(String? clientId) => clientId != null
      ? "$getEnvironmentUrl/api/client/beneficiary?clientId=$clientId"
      : "$getEnvironmentUrl/api/client/beneficiary";

  static String clientBeneficiaryEdit(int? beneficiaryId, String? clientId) =>
      clientId != null
          ? "$getEnvironmentUrl/api/client/beneficiary/edit?beneficiaryId=$beneficiaryId&clientId=$clientId"
          : "$getEnvironmentUrl/api/client/beneficiary/edit?beneficiaryId=$beneficiaryId";

  static String clientBeneficiaryDelete(int? beneficiaryId, String? clientId) =>
      clientId != null
          ? "$getEnvironmentUrl/api/client/beneficiary/delete?beneficiaryId=$beneficiaryId&clientId=$clientId"
          : "$getEnvironmentUrl/api/client/beneficiary/delete?beneficiaryId=$beneficiaryId";

  static String get clientSecureTag =>
      "$getEnvironmentUrl/api/client/secure-tag";

  static String clientSecureTagConsent(SecureTagAction? action) =>
      "$clientSecureTag/consent?action=${action?.toServer}";

  static String clientGuardianCreate(String? clientId) => clientId != null
      ? "$getEnvironmentUrl/api/client/guardian?clientId=$clientId"
      : "$getEnvironmentUrl/api/client/guardian";

  static String get clientPortfolio =>
      "$getEnvironmentUrl/api/client/portfolio";

  static String clientPortfolioDetail(ClientPortfolioReference reference) => reference
              .clientId !=
          null
      ? "$getEnvironmentUrl/api/client/portfolio/product?referenceNumber=${reference.referenceNumber}&clientId=${reference.clientId}"
      : "$getEnvironmentUrl/api/client/portfolio/product?referenceNumber=${reference.referenceNumber}";

  static String clientGuardianEdit(int? guardianId, {String? clientId}) =>
      clientId != null
          ? "$getEnvironmentUrl/api/client/guardian/edit?guardianId=$guardianId&clientId=$clientId"
          : "$getEnvironmentUrl/api/client/guardian/edit?guardianId=$guardianId";

  static String clientGuardianDelete(int? guardianId, {String? clientId}) =>
      clientId != null
          ? "$getEnvironmentUrl/api/client/guardian/delete?guardianId=$guardianId&clientId=$clientId"
          : "$getEnvironmentUrl/api/client/guardian/delete?guardianId=$guardianId";

  static String get clientGuardianRelationshipUpdate =>
      "$getEnvironmentUrl/api/client/beneficiary-guardian-relationship";

  static String get clientPepEdit => "$getEnvironmentUrl/api/client/pep/edit";

  static String get getClientTransaction =>
      "$getEnvironmentUrl/api/client/transactions";

  // Validation Controller
  static String get pepValidation => "$getEnvironmentUrl/api/validation/pep";

  static String get employmentDetailValidation =>
      "$getEnvironmentUrl/api/validation/employment-details";

  static String get bankDetailsValidation =>
      "$getEnvironmentUrl/api/validation/bank-details";

  static String get userDetailsValidation =>
      "$getEnvironmentUrl/api/validation/corporate/user-details";

  static String get corporateDetailsValidation =>
      "$getEnvironmentUrl/api/validation/corporate/corporate-details";

  static String get shareholderDetailsValidation =>
      "$getEnvironmentUrl/api/validation/corporate/shareholder-details";

  static String get shareholdersPercentageValidation =>
      "$getEnvironmentUrl/api/validation/corporate/shareholder-shareholdings";

  static String get corporateDocValidation =>
      "$getEnvironmentUrl/api/validation/corporate/documents";

  static String corporateDirectorIdentityValidation(
          String identityCardNumber) =>
      "$getEnvironmentUrl/api/validation/corporate/director/identity?identityCardNumber=$identityCardNumber";

  static String get editCorporateWealthSource =>
      "$getEnvironmentUrl/api/corporate/edit";

  static String get editCorporateDetailsValidation =>
      "$getEnvironmentUrl/api/validation/corporate/corporate-details/edit";

  static String recruitmentManagerValidation(
          String agencyId, String recruitmentManagerCode) =>
      "$getEnvironmentUrl/api/validation/agent/recruit-manager-code?agencyId=$agencyId&recruitManagerCode=$recruitmentManagerCode";

  // Login Controller
  static String get login => "$getEnvironmentUrl/api/login";

  static String forgotPassword(String email) =>
      "$getEnvironmentUrl/api/login/forgot-password?email=$email";

  static String get changePassword =>
      "$getEnvironmentUrl/api/login/change-password";

  static String get resetPassword =>
      "$getEnvironmentUrl/api/login/reset-password";

  // Product Controller
  static String get getProductList => "$getEnvironmentUrl/api/product/list";

  static String getProductDetailById(int productId) =>
      "$getEnvironmentUrl/api/product/$productId";

  static String purchaseFund(String? referenceNumber) => referenceNumber == null
      ? "$getEnvironmentUrl/api/product/purchase"
      : "$getEnvironmentUrl/api/product/purchase?referenceNumber=$referenceNumber";

  static String get purchaseFundValidation =>
      "$getEnvironmentUrl/api/product/purchase/validation/product";

  static String get purchaseFundValidation2 =>
      "$getEnvironmentUrl/api/product/purchase/validation/beneficiary-distribution";

  static String uploadPaymentReceipt(String referenceNumber, bool isDraft) =>
      "$getEnvironmentUrl/api/product/payment-receipts?referenceNumber=$referenceNumber&isDraft=$isDraft";

  static String getPaymentReceipts(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/payment-receipts?referenceNumber=$referenceNumber";

  static String getProductBeneficiaries(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/beneficiaries?referenceNumber=$referenceNumber";

  static String productDraftDelete(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/delete?referenceNumber=$referenceNumber";

  static String productRollOver(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/rollover?orderReferenceNumber=$referenceNumber";

  static String productReallocate(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/reallocation?orderReferenceNumber=$referenceNumber";

  static String productFullRedemption(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/full-redemption?orderReferenceNumber=$referenceNumber";

  static String productEarlyRedemption(bool isRedemption) =>
      "$getEnvironmentUrl/api/product/early-redemption?isRedemption=$isRedemption";

  static String getReallocatableProductCodes(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/reallocation/product-codes?orderReferenceNumber=$referenceNumber";

  static String getProductIncrementalList(String referenceNumber) =>
      "$getEnvironmentUrl/api/product/incremental-amount-list?orderReferenceNumber=$referenceNumber";

  static String getProductBankDetails(String productCode) =>
      "$getEnvironmentUrl/api/product/bank-details?productCode=$productCode";

  // Notification Controller
  static String get syncNotification => '$getNotification/sync';

  static String get readNotification => '$getNotification/read';

  static String get deleteNotification => '$getNotification/delete';

  static String get getNotification => '$getEnvironmentUrl/api/notification';

  //Corporate Controller
  static String createShareholder(String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholder?referenceNumber=$referenceNumber";

  static String editShareholder(String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholder/edit?referenceNumber=$referenceNumber";

  static String deleteShareholder(int? shareholderId, String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholder/delete?referenceNumber=$referenceNumber&corporateShareHolderId=$shareholderId";

  static String addShareholderToCoporate(String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholder/add?referenceNumber=$referenceNumber";

  static String getShareholders(String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholders?referenceNumber=$referenceNumber";

  static String getShareholderById(
          int? shareholderId, String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholder?referenceNumber=$referenceNumber&corporateShareholderId=$shareholderId";

  static String getCorporateProfile(String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/profile?corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/profile";

  static String getCorporateBeneficiary(String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/beneficiary/view-all?corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/beneficiary/view-all";

  static String getCorporateBeneficiaryById(
          int? beneficiaryId, String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/beneficiary/view?corporateBeneficiaryId=$beneficiaryId&corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/beneficiary/view?corporateBeneficiaryId=$beneficiaryId";

  static String getCorporateBank(String? corporateClientId) => corporateClientId !=
          null
      ? "$getEnvironmentUrl/api/corporate/bank-details/view-all?corporateClientId=$corporateClientId"
      : "$getEnvironmentUrl/api/corporate/bank-details/view-all";

  static String getCorporateBankById(int? bankId) =>
      "$getEnvironmentUrl/api/corporate/bank-details/view?corporateBankId=$bankId";

  static String createCorporate(String? referenceNumber, bool? isDraft) =>
      referenceNumber == null
          ? "$getEnvironmentUrl/api/corporate/sign-up?isDraft=$isDraft"
          : "$getEnvironmentUrl/api/corporate/sign-up?referenceNumber=$referenceNumber&isDraft=$isDraft";

  static String get corporateProfileImageEdit =>
      "$getEnvironmentUrl/api/corporate/client/profile-image/edit";

  static String createCorporateBank(String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/bank-details?corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/bank-details";

  static String editCorporateBank(String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/bank-details/edit?corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/bank-details/edit";

  static String deleteCorporateBank(int? bankId, String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/bank-details/delete?corporateBankId=$bankId&corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/bank-details/delete?corporateBankId=$bankId";

  static String createCorporateBenficiary(String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/beneficiary?corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/beneficiary";

  static String editCorporateBenficiary(int? beneficiaryId,
          {String? corporateClientId}) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/beneficiary/edit?corporateBeneficiaryId=$beneficiaryId&corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/beneficiary/edit?corporateBeneficiaryId=$beneficiaryId";

  static String deleteCorporateBenficiary(
          int? beneficiaryId, String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/beneficiary/delete?corporateBeneficiaryId=$beneficiaryId&corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/beneficiary/delete?corporateBeneficiaryId=$beneficiaryId";

  static String createCorporateGuardian(String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/guardian?corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/guardian";

  static String editCorporateGuardian(
          int? guardianId, String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/guardian/edit?corporateGuardianId=$guardianId&corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/guardian/edit?corporateGuardianId=$guardianId";

  static String deleteCorporateGuardian(
          int? guardianId, String? corporateClientId) =>
      corporateClientId != null
          ? "$getEnvironmentUrl/api/corporate/guardian/delete?corporateGuardianId=$guardianId&corporateClientId=$corporateClientId"
          : "$getEnvironmentUrl/api/corporate/guardian/delete?corporateGuardianId=$guardianId";

  static String get editCorporateProfile =>
      "$getEnvironmentUrl/api/corporate/user-detail/edit";

  static String get editCorporateDetail =>
      "$getEnvironmentUrl/api/corporate/corporate-details/edit";
  static String editCorporateShareholderPep(
          int? shareholderId, String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/shareholder-pep/edit?shareHolderId=$shareholderId&referenceNumber=$referenceNumber";
  static String corporateDocuments(String referenceNumber) =>
      "$getEnvironmentUrl/api/corporate/documents?referenceNumber=$referenceNumber";
  static String corporatePortfolio(String corporateClientId) =>
      "$getEnvironmentUrl/api/corporate/portfolio?corporateClientId=$corporateClientId";
  static String corporatePortfolioDetail(
          String corporateClientId, String orderReferenceNumber) =>
      "$getEnvironmentUrl/api/corporate/portfolio/product?corporateClientId=$corporateClientId&orderReferenceNumber=$orderReferenceNumber";
  static String getCorporateTransaction(String corporateClientId) =>
      "$getEnvironmentUrl/api/corporate/transactions?corporateClientId=$corporateClientId";
  static String corporatePurchaseFund(String? referenceNumber) =>
      referenceNumber == null
          ? "$getEnvironmentUrl/api/corporate/product/purchase"
          : "$getEnvironmentUrl/api/corporate/product/purchase?referenceNumber=$referenceNumber";

  //Agreement
  static String onboardingAgreement(String agreementType) =>
      "$getEnvironmentUrl/api/agreement/onboarding-agreement?userType=$agreementType";

  static String purchaseAgreement(String referenceNumber) =>
      "$getEnvironmentUrl/api/agreement/trust-fund-agreement?orderReferenceNumber=$referenceNumber";

  static String earlyRedemptionAgreement(String referenceNumber) =>
      "$getEnvironmentUrl/api/agreement/early-redemption-agreement?redemptionReferenceNumber=$referenceNumber";

  static String rollOverAgreement(String referenceNumber) =>
      "$getEnvironmentUrl/api/agreement/rollover-agreement?orderReferenceNumber=$referenceNumber";

  static String reallocateAgreement(String referenceNumber) =>
      "$getEnvironmentUrl/api/agreement/reallocate-agreement?orderReferenceNumber=$referenceNumber";

  static String verifyAgreementWitness(String referenceNumber) =>
      "$getEnvironmentUrl/api/agreement/trust-fund-agreement/verification?orderReferenceNumber=$referenceNumber";

  static String getSecondSigneeAgreementLink(String referenceNumber) =>
      "$getEnvironmentUrl/api/agreement/second-signee-agreement-link?orderReferenceNumber=$referenceNumber";

  static String secondSigneeAgreement({String? identificationNumber}) =>
      identificationNumber != null
          ? "$getEnvironmentUrl/api/agreement/second-signee-agreement?uniqueIdentifier=$identificationNumber"
          : "$getEnvironmentUrl/api/agreement/second-signee-agreement";

  //OTP
  static String get sendOtp => "$getEnvironmentUrl/api/otp/send";

  static String get verifyOtp => "$getEnvironmentUrl/api/otp/verify";
}
