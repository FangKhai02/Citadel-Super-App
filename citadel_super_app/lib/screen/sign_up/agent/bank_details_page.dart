import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/request/onboarding_agreement_request_vo.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/state/existing_agent_state.dart';
import 'package:citadel_super_app/data/vo/bank_details_request_vo.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/bank_details_form.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BankDetailsPage extends HookConsumerWidget {
  BankDetailsPage({super.key});

  final formKey = GlobalKey<AppFormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existingAgentState = ref.watch(existingAgentProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.darkToBright2,
          appBar: const CitadelAppBar(
            title: 'Enter your details',
          ),
          bottomNavigationBar: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: PrimaryButton(
              title: 'Continue',
              key: const Key(AppFormFieldKey.primaryButtonValidateKey),
              onTap: () async {
                await formKey.currentState?.validate(
                    onSuccess: (formData) async {
                  await validateBank(context, ref, formData);
                });
              },
            ),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bank Details', style: AppTextStyle.header1.copyWith(
                      fontSize: 28.spMin,
                      height: 1.3,
                      letterSpacing: -0.5,
                    )),
                    BankDetailsForm(
                      formKey: formKey,
                      bank: CommonBankDetails(
                        bankName: existingAgentState?.bankDetails?.bankName,
                        bankAccountNumber:
                            existingAgentState?.bankDetails?.accountNumber,
                        bankAccountHolderName:
                            existingAgentState?.bankDetails?.accountHolderName,
                        bankAddress:
                            existingAgentState?.bankDetails?.bankAddress,
                        bankPostcode: existingAgentState?.bankDetails?.postcode,
                        bankCity: existingAgentState?.bankDetails?.city,
                        bankState: existingAgentState?.bankDetails?.state,
                        bankCountry: existingAgentState?.bankDetails?.country,
                        swiftCode: existingAgentState?.bankDetails?.swiftCode,
                      ),
                    ),
                    gapHeight16,
                    AppUploadDocumentWidget(
                      formKey: formKey,
                      fieldKey: AppFormFieldKey.proofDocKey,
                      label: 'Bank Header Proof',
                      initialFiles: existingAgentState
                                  ?.bankDetails?.bankAccountProofFile !=
                              null
                          ? [
                              NetworkFile(
                                  url: existingAgentState
                                          ?.bankDetails?.bankAccountProofFile ??
                                      '')
                            ]
                          : [],
                    ),
                  ]))),
    );
  }

  Future<void> validateBank(
      BuildContext context, WidgetRef ref, formData) async {
    ValidationRepository repo = ValidationRepository();
    final req = ParameterHelper().bankDetailsValidationParam(formData);

    await repo.bankDetailsValidation(req).baseThen(
      getAppContext() ?? context,
      onResponseSuccess: (resp) async {
        await onboardingAgreement(context, ref, req);
      },
      onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper().resolveValidationError(formKey, e.message);
        } else {
          if (e.message.equalsIgnoreCase('api.bank.account.exists')) {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Bank account number already exist. Kindly enter a different bank account'),
                backgroundColor: AppColor.errorRed,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.errorRed, content: Text(e.message)));
          }
        }
      },
    );
  }

  Future<void> onboardingAgreement(
      BuildContext context, WidgetRef ref, BankDetailsRequestVo req) async {
    globalRef.read(agentSignUpProvider.notifier).setBankDetailsVo(req);

    AgreementRepository repo = AgreementRepository();

    await repo
        .onboardingAgreement(
            'AGENT',
            OnboardingAgreementRequestVo(
                name: ref
                        .read(agentSignUpProvider)
                        .signUpBaseIdentityDetailsVo
                        ?.fullName ??
                    '',
                identityCardNumber: ref
                        .read(agentSignUpProvider)
                        .signUpBaseIdentityDetailsVo
                        ?.identityCardNumber ??
                    ''))
        .baseThen(
      context,
      onResponseSuccess: (link) {
        if (link != null) {
          DownloadFileHelper().createFileOfPdfFromUrl(link).then((file) {
            Navigator.pushNamed(context, CustomRouter.eSignAgreement,
                arguments: ESignAgreementPage(
                  path: file.path,
                  onSubmit: (signature, [name, userId, role]) async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            title: 'Declaration',
                            message:
                                'I declare that the details furnished above are true and correct to the best of my knowledge and I undertake to inform you of any changes therein immediately. I am also aware that I may be held liable for any form of false, misleading or misrepresented information being provided. I authorise Citadel Trustee Berhad to perform credit checks or any inquiries on my creditworthiness or in relation to assets, liabilities and make references to any credit applications or any subsequent application. I also understand that Citadel Trustee Berhad has the right to request for further information and or to decline this application.',
                            positiveText: 'Confirm',
                            positiveOnTap: () {
                              ref
                                  .read(agentSignUpProvider.notifier)
                                  .setSignature(signature);

                              Navigator.pushNamed(
                                  context, CustomRouter.setPassword);
                            },
                            negativeText: 'Decline',
                            negativeOnTap: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                ));
          }).catchError((e) {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
                const SnackBar(
                    backgroundColor: AppColor.errorRed,
                    content: Text(
                        'Agreement not found, please seek for assistance')));
          });
        } else {
          ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                  backgroundColor: AppColor.errorRed,
                  content:
                      Text('Agreement not found, please seek for assistance')));
          return;
        }
      },
      onResponseError: (e, s) {
        ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      },
    );
  }
}
