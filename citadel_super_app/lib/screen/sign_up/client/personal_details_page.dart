import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/sign_up_repository.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/existing_client_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_martial_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_residential_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalDetailsPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  PersonalDetailsPage({super.key});

  @override
  PersonalDetailsPageState createState() {
    return PersonalDetailsPageState();
  }
}

class PersonalDetailsPageState extends ConsumerState<PersonalDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final microblinkResultState = ref.watch(microblinkResultProvider);
    final existingClientState = ref.watch(existingClientProvider);
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Identity Verification'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AppForm(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal Details', style: AppTextStyle.header1.copyWith(
                fontSize: 28.spMin,
                height: 1.3,
                letterSpacing: -0.5,
              )),
              AppResidentialStatusFormField(
                formKey: widget.formKey,
                initialValue:
                    existingClientState?.personalDetails?.residentialStatus,
              ),
              AppMartialStatusFormField(
                formKey: widget.formKey,
                initialValue:
                    existingClientState?.personalDetails?.maritalStatus,
              ),
              AppMobileFormField(
                formKey: widget.formKey,
                country: countryCodeNotifier
                        .getObjectByDialCode(
                            dialCode: existingClientState
                                ?.personalDetails?.mobileCountryCode)
                        ?.countryName ??
                    '',
                initialValue:
                    existingClientState?.personalDetails?.mobileNumber,
              ),
              AppTextFormField(
                formKey: widget.formKey,
                label: 'Email',
                initialValue: existingClientState?.personalDetails?.email ?? '',
                fieldKey: AppFormFieldKey.emailKey,
                keyboardType: TextInputType.emailAddress,
              ),
              AppTextFormField(
                  formKey: widget.formKey,
                  isRequired: false,
                  label: 'Agent Referral Code',
                  fieldKey: AppFormFieldKey.agentReferralCodeKey),
              AddressDetailsForm(
                formKey: widget.formKey,
                address: Address(
                  isSameCorrespondingAddress: existingClientState
                          ?.personalDetails
                          ?.correspondingAddress
                          ?.isSameCorrespondingAddress ??
                      false,
                  street: existingClientState?.personalDetails?.address ??
                      microblinkResultState
                          .getResultAsClientPersonalDetails.addressDisplay,
                  postCode: existingClientState?.personalDetails?.postcode ??
                      microblinkResultState
                          .getResultAsClientPersonalDetails.postcodeDisplay,
                  city: existingClientState?.personalDetails?.city ??
                      microblinkResultState
                          .getResultAsClientPersonalDetails.cityDisplay,
                  state: existingClientState?.personalDetails?.state ??
                      microblinkResultState
                          .getResultAsClientPersonalDetails.stateDisplay,
                  country: existingClientState?.personalDetails?.country ??
                      microblinkResultState
                          .getResultAsClientPersonalDetails.countryDisplay,
                ),
                requiredCorrespondingAddress: true,
              ),
              gapHeight32,
              AppUploadDocumentWidget(
                formKey: widget.formKey,
                fieldKey: AppFormFieldKey.proofDocKey,
                type: DocumentType.proofOfAddress,
                label: 'Proof of Address',
                initialFiles:
                    existingClientState?.personalDetails?.proofOfAddressFile !=
                            null
                        ? [
                            NetworkFile(
                                url: existingClientState
                                        ?.personalDetails?.proofOfAddressFile ??
                                    '')
                          ]
                        : [],
              ),
              gapHeight48,
              PrimaryButton(
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                onTap: () async {
                  FocusScope.of(context).unfocus();

                  await widget.formKey.currentState!.validate(
                      onSuccess: (formData) async {
                    await validateClientDetail(formData);
                  });
                },
                title: 'Continue',
              ),
              gapHeight16,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validateClientDetail(formData) async {
    SignUpRepository repo = SignUpRepository();
    final req =
        ParameterHelper().clientPersonalDetailsValidationParam(formData);

    EasyLoadingHelper.show();
    await repo.clientDetailsValidation(req).baseThen(
      context,
      onResponseSuccess: (response) {
        globalRef
            .read(clientSignUpProvider.notifier)
            .setClientPersonalDetailsRequestVo(req);

        Navigator.pushNamed(context, CustomRouter.selfie);
      },
      onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper()
              .resolveValidationError(widget.formKey, e.message);
        } else {
          if (e.message == 'api.email.has.been.taken') {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                content:
                    Text('The email address you entered is already in use'),
                backgroundColor: AppColor.errorRed,
              ),
            );
          } else {
            ScaffoldMessenger.of(getAppContext() ?? context)
                .showSnackBar(SnackBar(
              content: Text(e.message),
              backgroundColor: AppColor.errorRed,
            ));
          }
        }
      },
    ).whenComplete(() {
      EasyLoadingHelper.dismiss();
    });
  }
}
