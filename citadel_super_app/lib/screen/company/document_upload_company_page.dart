import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/request/corporate_client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/request/onboarding_agreement_request_vo.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DocumentUploadCompanyPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  DocumentUploadCompanyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corporateDocState = ref.watch(corporateDocumentsProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    final List<String> documentDescriptions = [
      'Profile of entity, organization chart and profile of key management/Board of Directors ',
      'Certificate of incorporation and/or certificate of commercial registration',
      'Memorandum and Articles of Association/Constitution/By-Laws of the Entity where applicable',
      'Latest Annual Return & Form 24, 44 & 49 or Super Form',
      'Certified true copy of identification documents (NRIC/Passport) for the directors, shareholders & authorized signatories',
      'Board Resolution/Minutes of Meeting of the Entity authorizing the establishment of the Trust with the list of authorized',
    ];

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Proof of Upload'),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload Company Document',
                    style: AppTextStyle.header1,
                  ),
                  gapHeight16,
                  ...List.generate(documentDescriptions.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}.',
                              style: AppTextStyle.description,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                documentDescriptions[index],
                                style: AppTextStyle.description,
                              ),
                            ),
                          ],
                        ),
                        if (index != documentDescriptions.length - 1)
                          gapHeight8,
                      ],
                    );
                  }),
                  gapHeight32,
                  corporateDocState.when(data: (data) {
                    return AppUploadDocumentWidget(
                        formKey: formKey,
                        fieldKey: AppFormFieldKey.proofDocKey,
                        label: 'Company Document',
                        type: DocumentType.companyDocument,
                        initialFiles: data.isEmpty
                            ? []
                            : data
                                .map((doc) => Document(
                                    id: doc.id,
                                    fileName: doc.fileName ?? '',
                                    base64EncodeStr: doc.file ?? ''))
                                .toList(),
                        maxFile: 6,
                        minFile: 2);
                  }, error: (e, s) {
                    return AppUploadDocumentWidget(
                        formKey: formKey,
                        fieldKey: AppFormFieldKey.proofDocKey,
                        label: 'Company Document',
                        type: DocumentType.companyDocument,
                        maxFile: 6,
                        minFile: 2);
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                  gapHeight32,
                  PrimaryButton(
                    key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await formKey.currentState?.validate(
                          onSuccess: (formData) async {
                        final documentList =
                            (formData[AppFormFieldKey.proofDocKey]
                                as List<Document>);
                        CorporateRepository repo = CorporateRepository();
                        final req = ParameterHelper()
                            .uploadCorporateDocumentsParam(documentList);
                        final referenceNumber =
                            ref.read(corporateRefProvider) ?? '';
                        repo
                            .uploadCorporateDocuments(referenceNumber, req)
                            .baseThen(
                          context,
                          onResponseSuccess: (_) async {
                            await onboardingAgreement(ref, context);
                          },
                          onResponseError: (e, s) {
                            if (e.message.contains('validation')) {
                              FormValidationHelper()
                                  .resolveValidationError(formKey, e.message);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                  backgroundColor: AppColor.errorRed,
                                ),
                              );
                            }
                          },
                        );
                      });
                    },
                    title: 'Confirm',
                  ),
                ],
              ))),
    );
  }

  Future<void> onboardingAgreement(WidgetRef ref, BuildContext context) async {
    final profileState = await ref.watch(profileProvider(null).future);
    final corporateProfileState =
        await ref.watch(corporateProfileProvider(null).future);

    AgreementRepository repo = AgreementRepository();

    final req = OnboardingAgreementRequestVo(
        name: profileState.personalDetails.nameDisplay,
        corporateClientId:
            corporateProfileState.corporateClient?.corporateClientId ?? '');

    EasyLoadingHelper.show();
    await repo.onboardingAgreement('CORPORATE_CLIENT', req).baseThen(context,
        onResponseSuccess: (link) {
      if (link != null) {
        DownloadFileHelper().createFileOfPdfFromUrl(link).then((file) {
          Navigator.pushNamed(context, CustomRouter.eSignAgreement,
              arguments: ESignAgreementPage(
                  path: file.path,
                  onSubmit: (signature, [name, userId, role]) async {
                    await showAgreementDialog(context, ref, signature);
                  }));
        }).catchError((e) {
          ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                  backgroundColor: AppColor.errorRed,
                  content:
                      Text('Agreement not found, please seek for assistance')));
        });
      } else {
        ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColor.errorRed,
                content:
                    Text('Agreement not found, please seek for assistance')));
      }
    }, onResponseError: (e, s) {
      ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(SnackBar(
          backgroundColor: AppColor.errorRed, content: Text(e.message)));
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  Future<void> showAgreementDialog(
      BuildContext context, WidgetRef ref, String signature) async {
    await showDialog(
        context: getAppContext() ?? context,
        builder: (context) {
          return AppDialog(
            title: 'Declaration',
            message:
                'I declare that the details furnished above are true and correct to the best of my knowledge and I undertake to inform you of any changes therein immediately. I am also aware that I may be held liable for any form of false, misleading or misrepresented information being provided. I authorise Citadel Trustee Berhad to perform credit checks or any inquiries on my creditworthiness or in relation to assets, liabilities and make references to any credit applications or any subsequent application. I also understand that Citadel Trustee Berhad has the right to request for further information and or to decline this application.',
            positiveText: 'Confirm',
            positiveOnTap: () async {
              await setSigning(ref, context, signature);
            },
            negativeText: 'Decline',
            negativeOnTap: () {},
          );
        });
  }

  Future<void> setSigning(
      WidgetRef ref, BuildContext context, String signature) async {
    final corporateSignUpNotifier = ref.read(corporateSignUpProvider.notifier);

    final req = CorporateClientSignUpRequestVo(
        corporateDetails: corporateSignUpNotifier.state?.corporateDetails,
        annualIncomeDeclaration:
            corporateSignUpNotifier.state?.annualIncomeDeclaration,
        sourceOfIncome: corporateSignUpNotifier.state?.sourceOfIncome,
        digitalSignature: signature);

    EasyLoadingHelper.show();
    CorporateRepository repo = CorporateRepository();

    await repo
        .createCorporate(ref.read(corporateRefProvider), req, false)
        .baseThen(
      context,
      onResponseSuccess: (data) async {
        // ignore: unused_result
        await ref.refresh(corporateProfileProvider(null).future);
        Navigator.pushNamed(
            getAppContext() ?? context, CustomRouter.registerSuccessCompany);
      },
      onResponseError: (e, s) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AppDialog(
                title: 'Corporate create failed',
                message: e.message,
                isRounded: true,
                positiveOnTap: () {
                  Navigator.pop(context);
                },
                showNegativeButton: false,
              );
            });
      },
    ).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
