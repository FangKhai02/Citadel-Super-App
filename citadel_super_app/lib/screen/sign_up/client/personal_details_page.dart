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
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                const SignUpProgressBar(currentStep: 4),
                gapHeight4,

                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.brightBlue.withValues(alpha: 0.15),
                        AppColor.brightBlue.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.brightBlue.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.brightBlue.withValues(alpha: 0.15),
                          border: Border.all(
                            color: AppColor.brightBlue.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person_outline,
                            size: 28.sp,
                            color: AppColor.brightBlue,
                          ),
                        ),
                      ),
                      gapHeight16,
                      Text('Personal Details',
                        style: AppTextStyle.header1.copyWith(
                          fontSize: 28.spMin,
                          height: 1.3,
                          letterSpacing: -0.5,
                        ),
                      ),
                      gapHeight8,
                      Text(
                        'Complete your profile information',
                        style: AppTextStyle.bodyText.copyWith(
                          color: AppColor.brightBlue.withValues(alpha: 0.9),
                          fontSize: 14.spMin,
                        ),
                      ),
                    ],
                  ),
                ),
                gapHeight32,

                // Form Fields Section
                _buildSectionCard(children: [
                  _buildSectionHeader(
                    icon: Icons.home_outlined,
                    title: 'Residence Details',
                  ),
                  gapHeight20,
                  AppResidentialStatusFormField(
                    formKey: widget.formKey,
                    initialValue:
                        existingClientState?.personalDetails?.residentialStatus,
                  ),
                  gapHeight20,
                  AppMartialStatusFormField(
                    formKey: widget.formKey,
                    initialValue:
                        existingClientState?.personalDetails?.maritalStatus,
                  ),
                  gapHeight20,
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
                ]),
                gapHeight24,

                // Contact Information Section
                _buildSectionCard(children: [
                  _buildSectionHeader(
                    icon: Icons.email_outlined,
                    title: 'Contact Information',
                  ),
                  gapHeight20,
                  AppTextFormField(
                    formKey: widget.formKey,
                    label: 'Email',
                    initialValue: existingClientState?.personalDetails?.email ?? '',
                    fieldKey: AppFormFieldKey.emailKey,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  gapHeight20,
                  AppTextFormField(
                    formKey: widget.formKey,
                    isRequired: false,
                    label: 'Agent Referral Code',
                    fieldKey: AppFormFieldKey.agentReferralCodeKey,
                    hint: 'Optional',
                  ),
                ]),
                gapHeight24,

                // Address Section
                _buildSectionCard(children: [
                  _buildSectionHeader(
                    icon: Icons.location_on_outlined,
                    title: 'Address Details',
                  ),
                  gapHeight20,
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
                ]),
                gapHeight24,

                // Document Upload Section
                _buildSectionCard(children: [
                  _buildSectionHeader(
                    icon: Icons.folder_outlined,
                    title: 'Document Upload',
                  ),
                  gapHeight20,
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
                ]),
                gapHeight32,

                // Continue Button
                _buildContinueButton(context),
                gapHeight16,
              ],
            ),
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

  /// Build section card with consistent styling
  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.mainBlack.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  /// Build section header with icon and title
  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: AppColor.brightBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColor.brightBlue, size: 18.sp),
        ),
        gapWidth12,
        Text(
          title,
          style: AppTextStyle.label.copyWith(
            color: AppColor.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.spMin,
          ),
        ),
      ],
    );
  }

  /// Build continue button
  Widget _buildContinueButton(BuildContext context) {
    return PrimaryButton(
      key: const Key(AppFormFieldKey.primaryButtonValidateKey),
      onTap: () async {
        FocusScope.of(context).unfocus();

        await widget.formKey.currentState!.validate(
            onSuccess: (formData) async {
          await validateClientDetail(formData);
        });
      },
      title: 'Continue',
    );
  }
}
