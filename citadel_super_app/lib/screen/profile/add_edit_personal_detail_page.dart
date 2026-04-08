import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_martial_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_residential_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_details_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_info_form.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditPersonalDetailPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final ClientProfileResponseVo user;

  EditPersonalDetailPage({super.key, required this.user});

  @override
  EditPersonalDetailPageState createState() => EditPersonalDetailPageState();
}

class EditPersonalDetailPageState
    extends ConsumerState<EditPersonalDetailPage> {
  late final TextEditingController genderController;
  late final TextEditingController nationalityController;
  late final TextEditingController residentController;
  late final TextEditingController maritalController;

  @override
  void initState() {
    genderController = TextEditingController(
        text: getValueForKey(widget.user.personalDetails.genderDisplay, ref));
    nationalityController = TextEditingController(
        text: widget.user.personalDetails.nationalityDisplay);
    residentController = TextEditingController(
        text: getValueForKey(
            widget.user.personalDetails.residentialStatusDisplay, ref));
    maritalController = TextEditingController(
        text: getValueForKey(
            widget.user.personalDetails.maritalStatusDisplay, ref));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDetail = widget.user.personalDetails;
    final countryCodeNotifier = ref.read(countryCodeProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Edit your details'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AppForm(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal Details', style: AppTextStyle.header1),
              gapHeight32,
              UserInfoForm(
                formKey: widget.formKey,
                user: userDetail,
                disabledFields: const [
                  DisabledField.myKadNumber,
                  DisabledField.dob,
                  DisabledField.email,
                ],
              ),
              Consumer(builder: (context, ref, child) {
                final constants = ref.read(appProvider).constants ?? [];
                final genderConstants = constants.firstWhere(
                    (element) => element.category == AppConstantsKey.gender);
                final options = genderConstants.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList();
                final initialOption = options.firstWhereOrNull(
                    (element) => element.value == userDetail.genderDisplay);

                return AppDropdown(
                  formKey: widget.formKey,
                  label: 'Gender',
                  enabled: initialOption == null,
                  fieldKey: AppFormFieldKey.genderKey,
                  hintText: 'Gender',
                  textController: genderController,
                  options: options,
                );
              }),
              Consumer(builder: (context, ref, child) {
                final countries =
                    ref.read(countryCodeProvider).countryCodes ?? [];
                final options = countries
                    .map((country) => AppDropDownItem(
                        value: country.countryName ?? '',
                        text: country.countryName ?? ''))
                    .toList();

                final initialOption = options.firstWhereOrNull(
                    (element) => element.value == nationalityController.text);
                if (initialOption != null) {
                  nationalityController.text = initialOption.value;
                }

                return AppDropdown(
                    formKey: widget.formKey,
                    label: 'Nationality',
                    enabled: initialOption == null,
                    fieldKey: AppFormFieldKey.nationalityKey,
                    textController: nationalityController,
                    hintText: 'Nationality',
                    options: options);
              }),
              AppResidentialStatusFormField(
                formKey: widget.formKey,
                initialValue: userDetail.residentialStatusDisplay,
                textController: residentController,
              ),
              AppMartialStatusFormField(
                formKey: widget.formKey,
                initialValue: userDetail.maritalStatusDisplay,
                textController: maritalController,
              ),
              AppMobileFormField(
                formKey: widget.formKey,
                country: countryCodeNotifier
                        .getObjectByDialCode(
                            dialCode: userDetail.mobileCountryCodeDisplay)
                        ?.countryName ??
                    '',
                initialValue: userDetail.mobileNumberDisplay,
              ),
              AppTextFormField(
                initialValue: userDetail.emailDisplay,
                formKey: widget.formKey,
                label: 'Email',
                fieldKey: AppFormFieldKey.emailKey,
                isEnabled: false,
              ),
              AppTextFormField(
                formKey: widget.formKey,
                label: 'Agent Referral Code',
                initialValue: widget.user.agentDetails?.agentReferralCode ?? '',
                fieldKey: AppFormFieldKey.agentReferralCodeKey,
                isEnabled: false,
              ),
              AddressDetailsForm(
                formKey: widget.formKey,
                address: userDetail.addressModel,
                requiredCorrespondingAddress: true,
              ),
              gapHeight32,
              AppUploadDocumentWidget(
                formKey: widget.formKey,
                initialFiles: userDetail?.correspondingAddress
                            ?.correspondingAddressProofKey !=
                        null
                    ? [
                        NetworkFile(
                            url: userDetail!.correspondingAddress!
                                    .correspondingAddressProofKey ??
                                '')
                      ]
                    : [],
                fieldKey: AppFormFieldKey.proofDocKey,
                type: DocumentType.proofOfAddress,
                label: 'Proof of Corresponding Address',
              ),
              gapHeight48,
              PrimaryButton(
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                onTap: () async => await update(context, ref),
                title: 'Confirm',
              ),
              gapHeight16,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> update(BuildContext context, WidgetRef ref) async {
    await widget.formKey.currentState!.validate(onSuccess: (formData) async {
      final ClientRepository clientRepository = ClientRepository();
      final req = ParameterHelper().editProfileParam(formData, widget.user);
      EasyLoadingHelper.show();
      await clientRepository.editProfile(req).baseThen(
        context,
        onResponseSuccess: (_) {
          final latestContext = (getAppContext() ?? context);
          latestContext.showSuccessSnackBar('Successfully Updated');
          ref.invalidate(profileProvider);
          Navigator.pop(latestContext);
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
    });
  }
}
