import 'dart:convert';
import 'dart:typed_data';

import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/state/postcode_state.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_guardian_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/helper/upload_file_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_document_image_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_martial_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_residential_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class CorporateDetailsForm extends StatefulHookConsumerWidget {
  final CorporateRepository corporateRepository = CorporateRepository();
  final CorporateBeneficiaryVo? beneficiary;
  final CorporateGuardianVo? guardian;
  final formKey = GlobalKey<AppFormState>();
  final String title;
  final bool isEnabled;
  final bool isEdit;

  final Widget? Function(BuildContext, WidgetRef, GlobalKey<AppFormState>)?
      relationship;
  final Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)
      onCreate;
  final Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)
      onEdit;
  final Widget? Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)?
      onDelete;

  CorporateDetailsForm(
      {super.key,
      this.beneficiary,
      this.guardian,
      this.relationship,
      required this.title,
      required this.onCreate,
      required this.onEdit,
      this.isEnabled = true,
      this.isEdit = true,
      this.onDelete});

  @override
  CorporateAddEditBeneficiaryDetailPageState createState() =>
      CorporateAddEditBeneficiaryDetailPageState();
}

class CorporateAddEditBeneficiaryDetailPageState
    extends ConsumerState<CorporateDetailsForm> {
  late final TextEditingController nameController;
  late final TextEditingController documentNumberController;
  late final TextEditingController dobController;
  late final TextEditingController genderController;
  late final TextEditingController nationalityController;

  late final TextEditingController addressController;
  late final TextEditingController postcodeController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController countryController;

  late final TextEditingController residentialController;
  late final TextEditingController maritalController;

  @override
  void initState() {
    nameController = TextEditingController();
    documentNumberController = TextEditingController();
    dobController = TextEditingController();
    genderController = TextEditingController();
    nationalityController = TextEditingController();
    addressController = TextEditingController();
    postcodeController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    residentialController = TextEditingController();
    maritalController = TextEditingController();

    super.initState();
  }

  Future<Uint8List> getImage(image) async {
    return await UploadFileHelper().getImageAsUint8List(image);
  }

  @override
  Widget build(BuildContext context) {
    final microblinkState = ref.watch(microblinkResultProvider);
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);

    final front = useState<Uint8List?>(null);
    final back = useState<Uint8List?>(null);

    Future<void> loadImage() async {
      try {
        final frontImage =
            await getImage(widget.beneficiary?.identityCardFrontImageKey);

        final backtImage =
            await getImage(widget.beneficiary?.identityCardBackImageKey);

        front.value = frontImage;
        back.value = backtImage;
      } catch (e) {
        appDebugPrint('Error loading image: $e');
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.guardian != null) {
          nameController.text = widget.guardian.nameDisplay;
          documentNumberController.text =
              widget.guardian.identityCardNumberDisplay;
          dobController.text = widget.guardian?.dob?.toDDMMYYY ?? '';
          genderController.text = widget.guardian.genderDisplay;
          nationalityController.text = widget.guardian.nationalityDisplay;
          addressController.text = widget.guardian.addressDisplay;
          postcodeController.text = widget.guardian.postcodeDisplay;
          cityController.text = widget.guardian.cityDisplay;
          stateController.text = widget.guardian.stateDisplay;
          countryController.text = widget.guardian.countryDisplay;
          residentialController.text =
              getValueForKey(widget.guardian.residentialStatusDisplay, ref);
          maritalController.text = widget.guardian.maritalStatusDisplay;
        } else {
          nameController.text = widget.beneficiary?.fullName ??
              microblinkState.getResultAsClientPersonalDetails.nameDisplay;
          documentNumberController.text =
              widget.beneficiary?.identityCardNumber ??
                  microblinkState.getResultAsClientPersonalDetails
                      .identityCardNumberDisplay;
          dobController.text = widget.beneficiary?.dob?.toDDMMYYY ??
              microblinkState.getResultAsClientPersonalDetails.dobDisplay;
          genderController.text = widget.beneficiary?.gender ??
              microblinkState.getResultAsClientPersonalDetails.genderDisplay;
          genderController.text = genderController.text;
          nationalityController.text = widget.beneficiary?.nationality ??
              microblinkState
                  .getResultAsClientPersonalDetails.nationalityDisplay;

          addressController.text = widget.beneficiary?.address ??
              microblinkState.getResultAsClientPersonalDetails.addressDisplay;
          postcodeController.text = widget.beneficiary?.postcode ??
              microblinkState.getResultAsClientPersonalDetails.postcodeDisplay;
          cityController.text = widget.beneficiary?.city ??
              microblinkState.getResultAsClientPersonalDetails.cityDisplay;
          stateController.text = widget.beneficiary?.state ??
              microblinkState.getResultAsClientPersonalDetails.stateDisplay;
          countryController.text = widget.beneficiary?.country ??
              microblinkState.getResultAsClientPersonalDetails.countryDisplay;

          residentialController.text =
              getValueForKey(widget.beneficiary?.residentialStatus ?? '', ref);
          maritalController.text = widget.beneficiary?.maritalStatus ?? '';
          loadImage();
        }

        widget.formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      child: CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: CitadelAppBar(title: widget.title),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    (widget.beneficiary != null || widget.guardian != null)
                        ? 'Edit ${widget.title}'
                        : 'New ${widget.title}',
                    style: AppTextStyle.header1),
                gapHeight32,
                widget.relationship?.call(context, ref, widget.formKey) ??
                    const SizedBox.shrink(),
                AppTextFormField(
                  formKey: widget.formKey,
                  label: 'Full Name',
                  controller: nameController,
                  fieldKey: AppFormFieldKey.nameKey,
                  isEnabled: widget.isEnabled,
                ),
                AppTextFormField(
                  formKey: widget.formKey,
                  label: 'User ID',
                  controller: documentNumberController,
                  fieldKey: AppFormFieldKey.documentNumberKey,
                  maxLength: microblinkState?.docType == 'MyKad'
                      ? 12
                      : 20,
                  isEnabled: false,
                ),
                AppDatePickerFormField(
                  formKey: widget.formKey,
                  label: 'Date of Birth',
                  controller: dobController,
                  isEnabled: false,
                ),
                Consumer(builder: (context, ref, child) {
                  final constants = ref.read(appProvider).constants ?? [];
                  final genderConstants = constants.firstWhere(
                      (element) => element.category == AppConstantsKey.gender);
                  final options = genderConstants.list!
                      .map(
                          (e) => AppDropDownItem(value: e.key!, text: e.value!))
                      .toList();
                  final initialOption = options.firstWhereOrNull((element) =>
                      element.value ==
                      (widget.beneficiary?.gender ??
                          widget.guardian?.gender ??
                          microblinkState
                              .getResultAsClientPersonalDetails.gender));

                  return AppDropdown(
                    formKey: widget.formKey,
                    label: 'Gender',
                    enabled: initialOption == null,
                    fieldKey: AppFormFieldKey.genderKey,
                    hintText: 'Gender',
                    initialValue: initialOption?.text ?? '',
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
                  final initialOption = options.firstWhereOrNull((element) =>
                      element.value ==
                      (widget.beneficiary?.nationality ??
                          widget.guardian?.nationality ??
                          microblinkState.getResultAsClientPersonalDetails
                              .nationalityDisplay));

                  return AppDropdown(
                      formKey: widget.formKey,
                      label: 'Nationality',
                      enabled: initialOption == null,
                      fieldKey: AppFormFieldKey.nationalityKey,
                      textController: nationalityController,
                      hintText: 'Nationality',
                      options: options);
                }),
                AppTextFormField(
                    label: 'Address',
                    controller: addressController,
                    fieldKey: AppFormFieldKey.addressKey,
                    isEnabled: widget.isEnabled,
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
                          isEnabled: widget.isEnabled,
                          keyboardType: TextInputType.number,
                          onChanged: (postcode) {
                            if (postcode.isNotEmpty && postcode.length == 5) {
                              Map<String, String> autoPopulateResult = ref
                                  .read(postcodeProvider.notifier)
                                  .autoPopulateFromPostCode(postcode: postcode);
                              cityController.text =
                                  autoPopulateResult['city'] ?? '';
                              stateController.text =
                                  autoPopulateResult['state'] ?? '';

                              if (cityController.text.isNotEmpty &&
                                  stateController.text.isNotEmpty) {
                                countryController.text = ref
                                        .read(countryCodeProvider.notifier)
                                        .getObjectByCountryName(
                                            country: 'MALAYSIA')
                                        ?.countryName ??
                                    '';
                              }
                            } else if (postcode.isEmpty) {
                              cityController.clear();
                              stateController.clear();
                              countryController.clear();
                            }
                            widget.formKey.currentState!.validateFormButton();
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
                          isEnabled: widget.isEnabled,
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
                          isEnabled: widget.isEnabled,
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
                            enabled: widget.isEnabled,
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
                AppResidentialStatusFormField(
                  formKey: widget.formKey,
                  initialValue: widget.beneficiary?.residentialStatus ??
                      widget.guardian.residentialStatusDisplay,
                  enabled: widget.isEnabled,
                  textController: residentialController,
                ),
                AppMartialStatusFormField(
                  formKey: widget.formKey,
                  initialValue: widget.beneficiary?.maritalStatus ??
                      widget.guardian.maritalStatusDisplay,
                  enabled: widget.isEnabled,
                  textController: maritalController,
                ),
                AppMobileFormField(
                  formKey: widget.formKey,
                  country: countryCodeNotifier
                          .getObjectByDialCode(
                              dialCode: widget.beneficiary?.mobileCountryCode ??
                                  widget.guardian.mobileCountryCodeDisplay)
                          ?.countryName ??
                      '',
                  initialValue: widget.beneficiary?.mobileNumber ??
                      widget.guardian.mobileNumberDisplay,
                  enabled: widget.isEnabled,
                ),
                AppTextFormField(
                    initialValue: widget.beneficiary?.email ??
                        widget.guardian.emailDisplay,
                    formKey: widget.formKey,
                    label: 'Email',
                    isRequired: false,
                    isEnabled: widget.isEnabled,
                    fieldKey: AppFormFieldKey.emailKey),
                gapHeight16,
                if ((widget.beneficiary == null && widget.guardian == null) ||
                    widget.isEnabled == false)
                  AppDocumentImageFormField(
                    documentType: microblinkState?.docType ?? 'MYKAD',
                    frontImage: front.value ?? (microblinkState?.frontImage?.isNotEmpty == true
                        ? base64Decode(microblinkState!.frontImage!)
                        : null),
                    backImage: back.value ?? (microblinkState?.backImage?.isNotEmpty == true
                        ? base64Decode(microblinkState!.backImage!)
                        : null),
                    enabled: widget.isEnabled,
                    onRescanComplete: (result) {
                      setState(() {
                        nameController.text =
                            result.getResultAsClientPersonalDetails.nameDisplay;
                        documentNumberController.text = result
                            .getResultAsClientPersonalDetails
                            .identityCardNumberDisplay;
                        dobController.text =
                            result.getResultAsClientPersonalDetails.dobDisplay;
                        genderController.text = result
                            .getResultAsClientPersonalDetails.genderDisplay;
                        genderController.text = genderController.text;
                        nationalityController.text = result
                            .getResultAsClientPersonalDetails
                            .nationalityDisplay;
                        addressController.text = result
                            .getResultAsClientPersonalDetails.addressDisplay;
                        postcodeController.text = result
                            .getResultAsClientPersonalDetails.postcodeDisplay;
                        cityController.text =
                            result.getResultAsClientPersonalDetails.cityDisplay;
                        stateController.text = result
                            .getResultAsClientPersonalDetails.stateDisplay;
                        countryController.text = result
                            .getResultAsClientPersonalDetails.countryDisplay;
                        widget.formKey.currentState!.validateFormButton();
                      });
                    },
                  ),
                gapHeight48,
                PrimaryButton(
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  onTap: () async =>
                      (widget.beneficiary != null || widget.guardian != null) &&
                              widget.isEdit == true
                          ? await widget.onEdit(context, ref, widget.formKey)
                          : await widget.onCreate(context, ref, widget.formKey),
                  title: 'Confirm',
                ),
                gapHeight16,
                widget.onDelete?.call(context, ref, widget.formKey) ??
                    const SizedBox.shrink(),
                gapHeight16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
