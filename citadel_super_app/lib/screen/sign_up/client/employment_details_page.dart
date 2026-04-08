import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/sign_up/employment.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/request/onboarding_agreement_request_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/existing_client_state.dart';
import 'package:citadel_super_app/data/state/postcode_state.dart';
import 'package:citadel_super_app/data/state/sign_up_state.dart';
import 'package:citadel_super_app/data/vo/employment_details_vo.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';

class EmploymentDetailsPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  EmploymentDetailsPage({super.key});

  @override
  EmploymentDetailsPageState createState() => EmploymentDetailsPageState();
}

class EmploymentDetailsPageState extends ConsumerState<EmploymentDetailsPage> {
  late final TextEditingController employmentTypeController;
  late final TextEditingController employerNameController;
  late final TextEditingController industryTypeController;
  late final TextEditingController jobTitleController;
  late final TextEditingController addressController;
  late final TextEditingController postcodeController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    employmentTypeController = TextEditingController();
    employerNameController = TextEditingController();
    industryTypeController = TextEditingController();
    jobTitleController = TextEditingController();
    addressController = TextEditingController();
    postcodeController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final existingClientState = ref.watch(existingClientProvider);

    final constants = ref.read(appProvider).constants ?? [];
    final employmentTypeConstants = constants.firstWhere(
        (element) => element.category == AppConstantsKey.employmentType);
    final industryTypeConstants = constants.firstWhere(
        (element) => element.category == AppConstantsKey.industryType);

    bool noNeedEmploymentDetails() {
      return (signUpState.employment?.employmentType != null &&
              (signUpState.employment?.employmentType ==
                      EmploymentType.houseWife ||
                  signUpState.employment?.employmentType ==
                      EmploymentType.retired) ||
          signUpState.employment?.employmentType == EmploymentType.unemployed);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (existingClientState?.employmentDetails != null) {
          final employmentType =
              existingClientState?.employmentDetails?.employmentType;
          switch (employmentType) {
            case 'RETIRED':
              signUpNotifier.setEmploymentType(EmploymentType.retired);
              break;
            case 'HOUSEWIFE':
              signUpNotifier.setEmploymentType(EmploymentType.houseWife);
              break;
            case 'EMPLOYED':
              signUpNotifier.setEmploymentType(EmploymentType.employed);
              break;
            case 'SELF_EMPLOYED':
              signUpNotifier.setEmploymentType(EmploymentType.selfEmployed);
              break;
            case 'UNEMPLOYED':
              signUpNotifier.setEmploymentType(EmploymentType.unemployed);
              break;
            case 'OTHER':
              signUpNotifier.setEmploymentType(EmploymentType.other);
              break;
            default:
              break;
          }
          employmentTypeController.text = employmentTypeConstants.list!
                  .firstWhereOrNull((element) => element.key == employmentType)
                  ?.value ??
              '';

          employerNameController.text =
              existingClientState?.employmentDetails?.employerName ?? '';
          industryTypeController.text = industryTypeConstants.list!
                  .firstWhereOrNull((element) =>
                      element.key ==
                      existingClientState?.employmentDetails?.industryType)
                  ?.value ??
              '';

          addressController.text =
              existingClientState?.employmentDetails?.employerAddress ?? '';

          postcodeController.text =
              existingClientState?.employmentDetails?.postcode ?? '';

          cityController.text =
              existingClientState?.employmentDetails?.city ?? '';

          stateController.text =
              existingClientState?.employmentDetails?.state ?? '';

          countryController.text =
              existingClientState?.employmentDetails?.country ?? '';
        }
        widget.formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     widget.formKey.currentState?.validateFormButton();
    //   });
    // }, [signUpState.getEmployment]);

    Future<void> callValidateApi({Map<String, dynamic>? formData}) async {
      ValidationRepository repo = ValidationRepository();

      EmploymentDetailsVo req;
      if (noNeedEmploymentDetails()) {
        req = EmploymentDetailsVo(
            employmentType:
                signUpState.employment?.employmentType!.toKeyWord());
      } else {
        req = ParameterHelper().employmentDetailsValidationParam(formData);
      }

      EasyLoadingHelper.show();
      await repo.employmentDetailsValidation(req).baseThen(
        context,
        onResponseSuccess: (resp) async {
          ref.read(clientSignUpProvider.notifier).setEmploymentDetailsVo(req);

          AgreementRepository repo = AgreementRepository();
          await repo
              .onboardingAgreement(
                  'CLIENT',
                  OnboardingAgreementRequestVo(
                      name: ref
                              .read(clientSignUpProvider)
                              .clientIdentityDetailsRequestVo
                              ?.fullName ??
                          '',
                      identityCardNumber: ref
                              .read(clientSignUpProvider)
                              .clientIdentityDetailsRequestVo
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
                                        .read(clientSignUpProvider.notifier)
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
                        content: Text(
                            'Agreement not found, please seek for assistance')));
                return;
              }
            },
            onResponseError: (e, s) {
              ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
                  SnackBar(
                      backgroundColor: AppColor.errorRed,
                      content: Text(e.message)));
            },
          );
        },
        onResponseError: (e, s) {
          if (e.message.contains('validation')) {
            FormValidationHelper()
                .resolveValidationError(widget.formKey, e.message);
          } else {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
                SnackBar(
                    backgroundColor: AppColor.errorRed,
                    content: Text(e.message)));
          }
        },
      ).whenComplete(() => EasyLoadingHelper.dismiss());
    }

    return AppForm(
      key: widget.formKey,
      child: CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Enter your details'),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
              key: noNeedEmploymentDetails()
                  ? null
                  : const Key(AppFormFieldKey.primaryButtonValidateKey),
              title: 'Continue',
              onTap: noNeedEmploymentDetails()
                  ? () async {
                      callValidateApi();
                    }
                  : () async {
                      await widget.formKey.currentState!.validate(
                          onSuccess: (formData) async {
                        await callValidateApi(formData: formData);
                      });
                    }),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Employment Details',
                style: AppTextStyle.header1.copyWith(
                  fontSize: 28.spMin,
                  height: 1.3,
                  letterSpacing: -0.5,
                ),
              ),
              gapHeight32,
              AppDropdown(
                formKey: widget.formKey,
                label: 'Employment Type',
                fieldKey: AppFormFieldKey.employmentTypeKey,
                hintText: 'Employment Type',
                options: employmentTypeConstants.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList(),
                textController: employmentTypeController,
                onSelected: (item) {
                  switch (item.value) {
                    case 'RETIRED':
                      signUpNotifier.setEmploymentType(EmploymentType.retired);
                      break;
                    case 'HOUSEWIFE':
                      signUpNotifier
                          .setEmploymentType(EmploymentType.houseWife);
                      break;
                    case 'EMPLOYED':
                      signUpNotifier.setEmploymentType(EmploymentType.employed);
                      break;
                    case 'SELF_EMPLOYED':
                      signUpNotifier
                          .setEmploymentType(EmploymentType.selfEmployed);
                      break;
                    case 'UNEMPLOYED':
                      signUpNotifier
                          .setEmploymentType(EmploymentType.unemployed);
                      break;
                    case 'OTHER':
                      signUpNotifier.setEmploymentType(EmploymentType.other);
                      break;
                  }
                  widget.formKey.currentState?.validateFormButton();
                },
              ),
              Visibility(
                visible: !noNeedEmploymentDetails(),
                child: Column(children: [
                  AppTextFormField(
                    label: 'Name of Employer',
                    fieldKey: AppFormFieldKey.employerNameKey,
                    formKey: widget.formKey,
                    controller: employerNameController,
                  ),
                  Builder(builder: (context) {
                    final options = industryTypeConstants.list!
                        .map((e) =>
                            AppDropDownItem(value: e.key!, text: e.value!))
                        .toList();
                    final initialOption = options.firstWhereOrNull((element) =>
                        element.value ==
                        existingClientState?.employmentDetails?.industryType);

                    return AppDropdown(
                      formKey: widget.formKey,
                      label: 'Industry Type',
                      fieldKey: AppFormFieldKey.industryTypeKey,
                      textController: industryTypeController,
                      initialValue: initialOption?.text ?? '',
                      hintText: 'Industry Type',
                      options: options,
                    );
                  }),
                  AppTextFormField(
                    label: 'Job Title',
                    fieldKey: AppFormFieldKey.jobTitleKey,
                    controller: jobTitleController,
                    formKey: widget.formKey,
                  ),
                  addressWidget()
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressWidget() {
    return Column(
      children: [
        AppTextFormField(
            label: 'Address',
            controller: addressController,
            fieldKey: AppFormFieldKey.addressKey,
            formKey: widget.formKey),
        Row(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return AppTextFormField(
                  maxLength: 5,
                  formKey: widget.formKey,
                  label: 'Postcode',
                  controller: postcodeController,
                  fieldKey: AppFormFieldKey.postcodeKey,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (postcode) {
                    if (postcode.isNotEmpty && postcode.length == 5) {
                      Map<String, String> autoPopulateResult = ref
                          .read(postcodeProvider.notifier)
                          .autoPopulateFromPostCode(postcode: postcode);
                      cityController.text = autoPopulateResult['city'] ?? '';
                      stateController.text = autoPopulateResult['state'] ?? '';

                      if (cityController.text.isNotEmpty &&
                          stateController.text.isNotEmpty) {
                        countryController.text = ref
                                .read(countryCodeProvider.notifier)
                                .getObjectByCountryName(country: 'MALAYSIA')
                                ?.countryName ??
                            '';
                      }
                    } else if (postcode.isEmpty) {
                      cityController.clear();
                      stateController.clear();
                      countryController.clear();
                    }
                  },
                );
              }),
            ),
            gapWidth24,
            Expanded(
              child: AppTextFormField(
                  formKey: widget.formKey,
                  label: 'City',
                  controller: cityController,
                  fieldKey: AppFormFieldKey.cityKey),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: AppTextFormField(
                  formKey: widget.formKey,
                  label: 'State',
                  controller: stateController,
                  fieldKey: AppFormFieldKey.stateKey),
            ),
            gapWidth24,
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final countries =
                    ref.read(countryCodeProvider).countryCodes ?? [];

                return AppDropdown(
                    label: 'Country',
                    textController: countryController,
                    formKey: widget.formKey,
                    fieldKey: AppFormFieldKey.countryKey,
                    hintText: 'Country',
                    options: countries
                        .map((country) => AppDropDownItem(
                            value: country.countryName ?? '',
                            text: country.countryName ?? ''))
                        .toList());
              }),
            )
          ],
        ),
      ],
    );
  }
}
