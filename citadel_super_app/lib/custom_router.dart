import 'package:citadel_super_app/screen/agent_action/agent_client_list_page.dart';
import 'package:citadel_super_app/screen/agent_action/agent_downline_list_page.dart';
import 'package:citadel_super_app/screen/agent_action/consent_request_page.dart';
import 'package:citadel_super_app/screen/agent_action/earning_details_page.dart';
import 'package:citadel_super_app/screen/agent_action/earning_list_page.dart';
import 'package:citadel_super_app/screen/company/company_details_page.dart';
import 'package:citadel_super_app/screen/company/document_upload_company_page.dart';
import 'package:citadel_super_app/screen/company/register_success_company_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_details_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_info_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_pep_declaration_page.dart';
import 'package:citadel_super_app/screen/company/wealth_source_page.dart';
import 'package:citadel_super_app/screen/agent_action/agent_client_details_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/agent_pending_sign_portfolio_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/agent_pending_sign_portfolio_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/commission_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/agent_downline_details_page.dart';
import 'package:citadel_super_app/screen/dashboard/client/secure_tag.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_bank_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_guardian_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_bank_List_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_bank_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_beneficiary_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_dashboard_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_profile_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_select_guardian_page.dart';
import 'package:citadel_super_app/screen/dashboard/dashboard_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/citadel_group_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/enter_new_password.dart';
import 'package:citadel_super_app/screen/dashboard/other/enter_old_password.dart';
import 'package:citadel_super_app/screen/fund/agent_create_product_purchase_order_result_page.dart';
import 'package:citadel_super_app/screen/fund/component/rollover/rollover_request_page.dart';
import 'package:citadel_super_app/screen/fund/component/rollover/rollover_result_page.dart';
import 'package:citadel_super_app/screen/fund/corporate_purchase_fund/corporate_purchase_fund_page.dart';
import 'package:citadel_super_app/screen/fund/portfolio/corporate_portfolio_detail_page.dart';
import 'package:citadel_super_app/screen/fund/withdraw_fund/withdrawal_request_page.dart';
import 'package:citadel_super_app/screen/fund/withdraw_fund/withdrawal_result_page.dart';
import 'package:citadel_super_app/screen/login/change_pin_page.dart';
import 'package:citadel_super_app/screen/login/create_pin_page.dart';
import 'package:citadel_super_app/screen/login/forgot_password_page.dart';
import 'package:citadel_super_app/screen/login/forgot_password_success_page.dart';
import 'package:citadel_super_app/screen/login/password_creation_success.dart';
import 'package:citadel_super_app/screen/login/pin_attempt_page.dart';
import 'package:citadel_super_app/screen/login/pin_create_success_page.dart';
import 'package:citadel_super_app/screen/maintenance/maintenance_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/contact_us_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/contact_us_success_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/privacy_policy_page.dart';
import 'package:citadel_super_app/screen/dashboard/other/terms_conditions_page.dart';
import 'package:citadel_super_app/screen/niu/niu_application_page.dart';
import 'package:citadel_super_app/screen/niu/niu_company_details_page.dart';
import 'package:citadel_super_app/screen/niu/niu_document_page.dart';
import 'package:citadel_super_app/screen/niu/niu_personal_details_page.dart';
import 'package:citadel_super_app/screen/niu/niu_sign_page.dart';
import 'package:citadel_super_app/screen/niu/niu_success_page.dart';
import 'package:citadel_super_app/screen/profile/account_delete_success_page.dart';
import 'package:citadel_super_app/screen/profile/account_deletion_request_page.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_agent_profile_page.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_guardian_page.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_pep_page.dart';
import 'package:citadel_super_app/screen/profile/agent/agent_profile_page.dart';
import 'package:citadel_super_app/screen/profile/profile_image_page.dart';
import 'package:citadel_super_app/screen/sign_up/client/disclaimer_page.dart';
import 'package:citadel_super_app/screen/transaction/transaction_detail_page.dart';
import 'package:citadel_super_app/screen/transaction/transaction_page.dart';
import 'package:citadel_super_app/screen/fund/fund_purchase_result_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_agent_detail_page.dart';
import 'package:citadel_super_app/screen/profile/bank_list_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_bank_detail_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_employment_detail_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_personal_detail_page.dart';
import 'package:citadel_super_app/screen/profile/beneficiary_list_page.dart';
import 'package:citadel_super_app/screen/fund/payment_gateway_page.dart';
import 'package:citadel_super_app/screen/fund/payment_result_page.dart';
import 'package:citadel_super_app/screen/fund/purchase_fund/purchase_fund_summary_page.dart';
import 'package:citadel_super_app/screen/profile/profile_bank_detail_page.dart';
import 'package:citadel_super_app/screen/profile/profile_beneficiary_detail_page.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_detail_page.dart';
import 'package:citadel_super_app/screen/sign_up/agent/contact_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/client/client_id_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/client/personal_details_page.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';
import 'package:citadel_super_app/screen/universal/select_bank_detail_page.dart';
import 'package:citadel_super_app/screen/universal/select_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/payment_proof_page.dart';
import 'package:citadel_super_app/screen/fund/portfolio/portfolio_detail_page.dart';
import 'package:citadel_super_app/screen/fund/portfolio/portfolio_page.dart';
import 'package:citadel_super_app/screen/fund/purchase_fund/purchase_fund_page.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_page.dart';
import 'package:citadel_super_app/screen/inbox/inbox_details_page.dart';
import 'package:citadel_super_app/screen/inbox/inbox_page.dart';
import 'package:citadel_super_app/screen/profile/profile_page.dart';
import 'package:citadel_super_app/screen/sign_up/agent/agency_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/agent/bank_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/client/bankcruptcy_declaration_page.dart';
import 'package:citadel_super_app/screen/sign_up/client/employment_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/client/pep_declaration_page.dart';
import 'package:citadel_super_app/screen/sign_up/register_success_page.dart';
import 'package:citadel_super_app/screen/sign_up/selfie_page.dart';
import 'package:citadel_super_app/screen/sign_up/face_verification_loading_page.dart';
import 'package:citadel_super_app/screen/sign_up/set_password_page.dart';
import 'package:citadel_super_app/screen/sign_up/agent/agent_id_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:citadel_super_app/screen/login/login_page.dart';
import 'package:citadel_super_app/screen/sign_up/signup_page.dart';
import 'package:citadel_super_app/screen/splash_page.dart';
import 'package:citadel_super_app/screen/undefined_route_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_bank_detail_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_sub_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/select_guardian_page.dart';
import 'package:citadel_super_app/screen/universal/select_subs_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/view_document_page.dart';
import 'package:citadel_super_app/web_screen/web_agreement_page.dart';
import 'package:citadel_super_app/web_screen/web_e_sign_agreement_page.dart';
import 'package:citadel_super_app/web_screen/web_finish_page.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static const String splash = '/';
  static const String webAgreement = '/';
  static const String login = '/login';
  static const String maintenance = '/maintenance';
  static const String webESignAgreement = '/webESignAgreement';
  static const String webFinish = '/webFinish';

  //Sign Up
  static const String signUp = '/signUp';
  static const String bankruptcyDeclaration = '/signup/bankruptcyDeclaration';
  static const String document = '/signup/document';
  static const String agentIdDetails = '/signup/agentIdDetails';
  static const String contactDetails = '/signup/contactDetails';
  static const String clientIdDetails = '/signup/clientIdDetails';
  static const String personalDetails = '/signup/personalDetails';
  static const String selfie = '/signup/selfie';
  static const String faceVerificationLoading = '/signup/faceVerificationLoading';
  static const String agencyDetails = '/signup/agencyDetails';
  static const String bankDetails = '/signup/bankDetails';
  static const String eSignAgreement = '/signup/eSignAgreement';
  static const String setPassword = '/signup/setPassword';
  static const String pepDeclaration = '/signup/pepDeclaration';
  static const String employmentDetails = '/signup/employmentDetails';
  static const String registerSuccess = 'signup/registerSuccess';
  static const String disclaimer = '/signup/disclaimer';

  //Dashboard
  static const String dashboard = '/dashboard';

  //Inbox
  static const String inbox = '/inbox';
  static const String inboxDetails = '/inbox/details';

  //Transaction
  static const String transaction = '/transaction';
  static const String transactionDetail = '/transactionDetail';

  //Profile
  static const String clientProfile = '/profile';
  static const String clientProfileBeneficiary = '/profile/beneficiary';
  static const String clientProfileBank = '/profile/bank';
  static const String profileImage = '/profile/image';
  static const String editPersonalDetail = '/profile/addEditPersonalDetail';
  static const String addEditEmploymentDetail =
      '/profile/addEditEmploymentDetail';
  static const String bankList = '/profile/bankList';
  static const String addEditBankDetail = '/profile/addEditBankDetail';
  static const String addEditAgentDetail = '/profile/addEditAgentDetail';
  static const String beneficiaryList = '/profile/beneficiaryList';
  static const String addEditBeneficiary = '/profile/addEditBeneficiary';
  static const String addEditGuardian = '/profile/addEditGuardian';
  static const String addEditPepPage = '/profile/addEditPep';
  static const String accountDeletion = '/profile/accountDeletion';
  static const String accountDeleteSuccess = '/profile/accountDeleteSuccess';

  //Agent
  static const String agentProfile = '/profile/agentProfile';
  static const String agentProfileEdit = 'profile/agentProfileEdit';
  static const String agentClientList = '/agent/clientList';
  static const String agentClientDetails = '/agent/clientDetails';
  static const String agentCommission = '/agent/commission';
  static const String agentDownlineList = '/agent/downlineList';
  static const String agentDownlineDetails = '/agent/downline/details';
  static const String pendingSignPortfolio = 'agent/pendingSignPortfolio';
  static const String pendingSignPortfolioDetail =
      'agent/pendingSignPortfolioDetail';
  static const String agentEarningList = '/agent/earningList';
  static const String agentEarningDetails = '/agent/earningDetails';

  //Fund
  static const String trustFund = '/fund/purchaseFund/trustFund';
  static const String trustFundDetail = '/fund/purchaseFund/Detail';
  static const String purchaseFund = '/fund/purchaseFund/purchaseFund';
  static const String purchaseFundSummary = '/fund/purchaseFundSummary';
  static const String paymentGateway = '/fund/paymentGateway';
  static const String paymentResult = '/fund/paymentResult';
  static const String portfolio = '/fund/portfolio';
  static const String portfolioDetail = '/fund/portfolio/Detail';
  static const String corporatePortfolioDetail =
      '/fund/corporatePortfolioDetail';
  static const String fundPurchaseResult = '/fund/fundPurchaseResult';
  static const String withdrawalRequest = '/fund/withdrawalRequest';
  static const String withdrawalResult = '/fund/withdrawalResult';
  static const String rolloverRequest = '/rolloverRequest';
  static const String rolloverResult = '/fund/rolloverResult';
  static const String corporatePurchaseFund = '/fund/corporatePurchaseFund';
  static const String agentCreateProductOrderResult =
      '/fund/agentCreateProductOrderReuslt';

  //Universal
  static const String paymentProof = '/paymentProof';
  static const String selectBankDetail = '/selectBankDetail';
  static const String selectBeneficiary = '/selectBeneficiary';
  static const String selectGuardian = '/selectGuardian';
  static const String selectSubstituteBeneficiary =
      '/selectSubstituteBeneficiary';
  static const String selectCorporateBank = '/selectCorporateBankDetail';
  static const String selectCorporateBeneficiary =
      '/selectCorporateBeneficiary';
  static const String selectCorporateSubsBeneficiary =
      '/selectCorporateSubsBeneficiary';
  static const String viewDocument = '/viewDocument';

  //Other
  static const String contactUs = '/ContactUsPage';
  static const String contactUsSuccess = '/ContactUsSuccessPage';
  static const String termsConditions = '/TermsConditionsPage';
  static const String privacyPolicy = '/PrivacyPolicyPage';
  static const String enterOldPassword = '/EnterOldPasswordPage';
  static const String enterNewPassword = '/EnterNewPasswordPage';
  static const String citadelGroup = '/CitadelGroupPage';

  //ConsentRequestPage
  static const String consentRequest = '/agent/ConsentRequestPage';

  //Client - SecureTagPage
  static const String secureTag = '/client/SecureTagPage';

  //Login
  static const String forgotPassword = '/ForgotPasswordPage';
  static const String forgotPasswordSuccess = '/ForgotPasswordSuccessPage';
  static const String passwordCreationSuccess =
      '/login/PasswordCreationSuccessPage';
  static const String createPin = '/CreatePinPage';
  static const String pinCreateSucess = '/PinCreateSuccessPage';
  static const String changePin = '/ChangePinPage';
  static const String pinAttempt = '/PinAttemptPage';

  //Corporate
  static const String companyDetails = '/CompanyDetailsPage';
  static const String documentUploadCompany = '/DocumentUploadCompanyPage';
  static const String registerSuccessCompany = '/RegisterSuccessCompanyPage';
  static const String shareHolderDetails = '/ShareHolderDetailsPage';
  static const String shareHolderInfo = '/ShareHolderInfoPage';
  static const String shareHolder = '/ShareHolderPage';
  static const String shareHolderPepDeclaration =
      '/ShareHolderPepDeclarationPage';
  static const String wealthSource = '/WealthSourcePage';
  static const String corporateDashboard = '/CorporateDashboardPage';
  static const String corporateProfile = '/CorporateProfilePage';
  static const String corporateAddEditBank = '/CorporateAddEditBankDetailPage';
  static const String corporateBankDetail = '/CorporateBankDetailPage';
  static const String corporateBankList = '/CorporateBankListPage';
  static const String corporateBeneficiaryDetail =
      '/CorporateBeneficiaryDetailPage';
  static const String corporateAddEditBeneficiary =
      'CorporateAddEditBeneficiaryPage';
  static const String corporateAddEditGuardian =
      '/CorporateAddEditGuardianPage';
  static const String corporateSelectGuardian = '/CorporateSelectGuardianPage';
  //Niu
  static const String niuApplication = '/niuApplication';
  static const String niuPersonalDetails = '/niuPersonalDetails';
  static const String niuCompanyDetails = '/niuCompanyDetails';
  static const String niuDocument = '/niuDocument';
  static const String niuSuccess = '/niuSuccess';
  static const String niuSign = '/niuSignPage';

  //Web

  static Route<dynamic> createPageRoute(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        });
  }

  static Route<dynamic> generateWebRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');
    final query = uri.queryParameters;

    switch (uri.path) {
      case webAgreement:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => WebAgreementPage(
                  identifier: query['data'],
                  environment: query['env'],
                ));
      case webESignAgreement:
        final webESignAgreement = settings.arguments as WebESignAgreementPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => webESignAgreement);
      case webFinish:
        final webFinish = settings.arguments as WebFinishPage;
        return MaterialPageRoute(settings: settings, builder: (_) => webFinish);
      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UndefinedRoutePage());
    }
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');
    final query = uri.queryParameters;

    switch (uri.path) {
      case splash:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginPage());
      case maintenance:
        final maintenancePage = settings.arguments as MaintenancePage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => maintenancePage);
      case signUp:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SignupPage());
      case bankruptcyDeclaration:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const BankcruptcyDeclarationPage());
      case disclaimer:
        return MaterialPageRoute(
            settings: settings, builder: (_) => DisclaimerPage());
      case document:
        final documentPage = settings.arguments as DocumentPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => documentPage);
      case agentIdDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AgentIdDetailsPage());
      case contactDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ContactDetailsPage());
      case clientIdDetails:
        final clientIdDetailsPage = settings.arguments as ClientIdDetailsPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => clientIdDetailsPage);
      case personalDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => PersonalDetailsPage());
      case selfie:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SelfiePage());
      case faceVerificationLoading:
        final args = settings.arguments as FaceVerificationLoadingPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => args);
      case agencyDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AgencyDetailsPage());
      case bankDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => BankDetailsPage());
      case eSignAgreement:
        final esignAgreementPage = settings.arguments as ESignAgreementPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => esignAgreementPage);
      case setPassword:
        final arg = settings.arguments as SetPasswordPage? ?? SetPasswordPage();
        return MaterialPageRoute(settings: settings, builder: (_) => arg);
      case pepDeclaration:
        return MaterialPageRoute(
            settings: settings, builder: (_) => PepDeclarationPage());
      case employmentDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => EmploymentDetailsPage());
      case registerSuccess:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const RegisterSuccessPage());
      case dashboard:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const DashboardPage());
      case transaction:
        final arg = settings.arguments as TransactionPage;
        return MaterialPageRoute(settings: settings, builder: (_) => arg);
      case transactionDetail:
        final transactionDetailPage =
            settings.arguments as TransactionDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => transactionDetailPage);
      case portfolio:
        final portfolioPage = settings.arguments as PortfolioPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => portfolioPage);
      case portfolioDetail:
        final portfolioDetailPage = settings.arguments as PortfolioDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => portfolioDetailPage);
      case corporatePortfolioDetail:
        final corporatePortfolioDetailPage =
            settings.arguments as CorporatePortfolioDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporatePortfolioDetailPage);
      case inbox:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const InboxPage());
      case inboxDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => InboxDetailsPage(
            id: int.tryParse(query['id'] ?? ''),
          ),
        );
      case clientProfile:
        final clientProfilePage = settings.arguments as ProfilePage;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => clientProfilePage,
        );
      //return createPageRoute(const ProfilePage());
      case agentProfile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AgentProfilePage(),
        );
      case agentProfileEdit:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AddEditAgentProfilePage(),
        );
      case agentClientList:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AgentClientListPage());
      case agentClientDetails:
        final agentClientDetailsPage =
            settings.arguments as AgentClientDetailsPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => agentClientDetailsPage);
      case agentCommission:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CommissionPage());
      case clientProfileBank:
        final profileBankDetailPage =
            settings.arguments as ProfileBankDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => profileBankDetailPage);
      case clientProfileBeneficiary:
        final profileBeneficiaryDetailPage =
            settings.arguments as ProfileBeneficiaryDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => profileBeneficiaryDetailPage);
      case profileImage:
        final profileImagePage = settings.arguments as ProfileImagePage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => profileImagePage);
      case editPersonalDetail:
        final addEditPersonalDetailPage =
            settings.arguments as EditPersonalDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditPersonalDetailPage);
      case addEditEmploymentDetail:
        final addEditEmploymentDetailPage =
            settings.arguments as AddEditEmploymentDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditEmploymentDetailPage);
      case bankList:
        final bankListPage = settings.arguments as BankListPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => bankListPage);
      case addEditBankDetail:
        final addEditBankDetailPage =
            settings.arguments as AddEditBankDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditBankDetailPage);
      case beneficiaryList:
        final beneficiaryListPage = settings.arguments as BeneficiaryListPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => beneficiaryListPage);
      case addEditBeneficiary:
        final addEditBeneficiaryPage =
            settings.arguments as AddEditBeneficiaryPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditBeneficiaryPage);
      case addEditAgentDetail:
        final addEditAgentDetailPage =
            settings.arguments as AddEditAgentDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditAgentDetailPage);
      case addEditGuardian:
        final addEditGuardianPage = settings.arguments as AddEditGuardianPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditGuardianPage);
      case addEditPepPage:
        final addEditPepPage = settings.arguments as AddEditPepPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => addEditPepPage);
      case accountDeletion:
        final accountDeletionRequestPage =
            settings.arguments as AccountDeletionRequestPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => accountDeletionRequestPage);
      case accountDeleteSuccess:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AccountDeleteSuccessPage());
      case selectBankDetail:
        final selectBankDetailPage = settings.arguments as SelectBankDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => selectBankDetailPage);

      case selectBeneficiary:
        final selectBeneficiaryPage =
            settings.arguments as SelectBeneficiaryPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => selectBeneficiaryPage);
      case selectSubstituteBeneficiary:
        final selectSubstituteBeneficiaryPage =
            settings.arguments as SelectSubsBeneficiaryPage;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => selectSubstituteBeneficiaryPage);
      case selectGuardian:
        final selectGuardianPage = settings.arguments as SelectGuardianPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => selectGuardianPage);
      case paymentProof:
        final paymentProofPage = settings.arguments as PaymentProofPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => paymentProofPage);

      case fundPurchaseResult:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FundPurchaseResultPage());
      case withdrawalRequest:
        final withdrawalRequestPage =
            settings.arguments as WithdrawalRequestPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => withdrawalRequestPage);
      case withdrawalResult:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WithdrawalResultPage());
      case rolloverRequest:
        final rolloverRequestPage = settings.arguments as RolloverRequestPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => rolloverRequestPage);
      case rolloverResult:
        final rolloverResultPage = settings.arguments as RolloverResultPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => rolloverResultPage);
      case trustFund:
        final trustFundPage = settings.arguments as TrustFundPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => trustFundPage);
      case trustFundDetail:
        final trustFundDetailPage = settings.arguments as TrustFundDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => trustFundDetailPage);
      case purchaseFund:
        final purchaseFundPage = settings.arguments as PurchaseFundPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => purchaseFundPage);
      case purchaseFundSummary:
        final purchaseFundSummaryPage =
            settings.arguments as PurchaseFundSummaryPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => purchaseFundSummaryPage);
      case corporatePurchaseFund:
        final corporatePurchaseFundPage =
            settings.arguments as CorporatePurchaseFundPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporatePurchaseFundPage);
      case agentCreateProductOrderResult:
        final agentCreateProductOrderReusltPage =
            settings.arguments as AgentCreateProductPurchaseOrderResultPage;
        return MaterialPageRoute(
            builder: (_) => agentCreateProductOrderReusltPage);
      case paymentGateway:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PaymentGatewayPage());
      case paymentResult:
        final paymentResultPage = settings.arguments as PaymentResultPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => paymentResultPage);
      case selectCorporateBank:
        final selectCorporateBankPage =
            settings.arguments as SelectCorporateBankDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => selectCorporateBankPage);
      case selectCorporateBeneficiary:
        final selectCorporateBeneficiaryPage =
            settings.arguments as SelectCorporateBeneficiaryPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => selectCorporateBeneficiaryPage);
      case selectCorporateSubsBeneficiary:
        final selectCorporateSubsBeneficiaryPage =
            settings.arguments as SelectCorporateSubsBeneficiaryPage;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => selectCorporateSubsBeneficiaryPage);
      case viewDocument:
        final viewDocumentPage = settings.arguments as ViewDocumentPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => viewDocumentPage);
      case contactUs:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ContactUsPage());
      case contactUsSuccess:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactUsSuccessPage());
      case termsConditions:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TermsConditionsPage());
      case privacyPolicy:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyPage());
      case consentRequest:
        final arg = settings.arguments as ConsentRequestPage;
        return MaterialPageRoute(settings: settings, builder: (_) => arg);
      case secureTag:
        final arg = settings.arguments as SecureTagPage;
        return MaterialPageRoute(settings: settings, builder: (_) => arg);

      case forgotPassword:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ForgotPasswordPage());

      case forgotPasswordSuccess:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ForgotPasswordSuccessPage());
      case passwordCreationSuccess:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const PasswordCreationSuccessPage());
      case enterOldPassword:
        return MaterialPageRoute(
            settings: settings, builder: (_) => EnterOldPasswordPage());
      case enterNewPassword:
        final enterNewPasswordPage = settings.arguments as EnterNewPasswordPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => enterNewPasswordPage);
      case citadelGroup:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CitadelGroupPage());
      case agentDownlineList:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AgentDownlineListPage());
      case agentDownlineDetails:
        final agentDownlineDetailsPage =
            settings.arguments as AgentDownlineDetailsPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => agentDownlineDetailsPage);
      case pendingSignPortfolio:
        return MaterialPageRoute(
            builder: (_) => const AgentPendingSignPortfolioPage());
      case pendingSignPortfolioDetail:
        final portfolioDetailPage =
            settings.arguments as AgentPendingSignPortfolioDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => portfolioDetailPage);
      case agentEarningList:
        final agentEarningListPage = settings.arguments as EarningListPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => agentEarningListPage);
      case agentEarningDetails:
        final agentEarningDetailsPage =
            settings.arguments as EarningDetailsPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => agentEarningDetailsPage);
      case niuApplication:
        return MaterialPageRoute(
            settings: settings, builder: (_) => NiuApplicationPage());
      case niuPersonalDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => NiuPersonalDetailsPage());
      case niuCompanyDetails:
        return MaterialPageRoute(
            settings: settings, builder: (_) => NiuCompanyDetailsPage());
      case niuDocument:
        return MaterialPageRoute(
            settings: settings, builder: (_) => NiuDocumentPage());
      case niuSuccess:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const NiuSuccessPage());
      case niuSign:
        return MaterialPageRoute(
            settings: settings, builder: (_) => NiuSignPage());
      case createPin:
        return MaterialPageRoute(
            settings: settings, builder: (_) => CreatePinPage());
      case changePin:
        final changePinPage = settings.arguments as ChangePinPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => changePinPage);
      case pinCreateSucess:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PinCreateSuccessPage());
      case pinAttempt:
        final pinAttempt = settings.arguments as PinAttemptPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => pinAttempt);
      case companyDetails:
        final companyDetailsPage = settings.arguments as CompanyDetailsPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => companyDetailsPage);
      case documentUploadCompany:
        return MaterialPageRoute(
            settings: settings, builder: (_) => DocumentUploadCompanyPage());
      case registerSuccessCompany:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const RegisterSuccessCompanyPage());
      case shareHolderDetails:
        final shareHolderDetailsPage =
            settings.arguments as ShareHolderDetailsPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => shareHolderDetailsPage);
      case shareHolderInfo:
        final shareHolderInfo = settings.arguments as ShareHolderInfoPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => shareHolderInfo);
      case shareHolder:
        final shareHolderPage = settings.arguments as ShareHolderPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => shareHolderPage);
      case shareHolderPepDeclaration:
        final shareHolderPepDeclarationPage =
            settings.arguments as ShareHolderPepDeclarationPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => shareHolderPepDeclarationPage);
      case wealthSource:
        final wealthSourcePage = settings.arguments as WealthSourcePage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => wealthSourcePage);
      case corporateDashboard:
        final corporateDashboardPage =
            settings.arguments as CorporateDashboardPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateDashboardPage);
      case corporateProfile:
        final corporateProfilePage = settings.arguments as CorporateProfilePage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateProfilePage);
      case corporateBankDetail:
        final corporateBankDetailPage =
            settings.arguments as CorporateBankDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateBankDetailPage);

      case corporateAddEditBank:
        final corporateAddEditBankPage =
            settings.arguments as CorporateAddEditBankDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateAddEditBankPage);

      case corporateBankList:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CorporateBankListPage());

      case corporateBeneficiaryDetail:
        final corporateBeneficiaryDetailPage =
            settings.arguments as CorporateBeneficiaryDetailPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateBeneficiaryDetailPage);

      case corporateAddEditBeneficiary:
        final corporateAddEditBeneficiaryPage =
            settings.arguments as CorporateAddEditBeneficiaryPage;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => corporateAddEditBeneficiaryPage);

      case corporateAddEditGuardian:
        final corporateAddEditGuardianPage =
            settings.arguments as CorporateAddEditGuardianPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateAddEditGuardianPage);

      case corporateSelectGuardian:
        final corporateSelectGuardianPage =
            settings.arguments as CorporateSelectGuardianPage;
        return MaterialPageRoute(
            settings: settings, builder: (_) => corporateSelectGuardianPage);
      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UndefinedRoutePage());
    }
  }
}
