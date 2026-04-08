import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/postcode_state.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';

import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:citadel_super_app/project_widget/selection/app_checkbox.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddressDetailsForm extends StatefulHookWidget {
  final GlobalKey<AppFormState> formKey;
  final String? addressLabel;
  final String? fieldKey;
  final Address? address;
  final bool isRequired;
  final bool requiredCorrespondingAddress;
  final bool? isEnabled;

  const AddressDetailsForm({
    super.key,
    required this.formKey,
    this.addressLabel,
    this.fieldKey = AppFormFieldKey.addressDetailsFormKey,
    this.address,
    this.isRequired = true,
    this.isEnabled = true,
    this.requiredCorrespondingAddress = false,
  });

  @override
  AddressDetailsFormState createState() {
    return AddressDetailsFormState();
  }
}

class AddressDetailsFormState extends BaseFormFieldState<AddressDetailsForm> {
  bool hasCorrespondingAddress = false;
  late final TextEditingController addressController;
  late final TextEditingController postcodeController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController countryController;

  late final TextEditingController correspondAddressController;
  late final TextEditingController correspondPostcodeController;
  late final TextEditingController correspondCityController;
  late final TextEditingController correspondStateController;
  late final TextEditingController correspondCountryController;

  void isCorrespondingValid() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (addressController.text.isEmpty ||
            postcodeController.text.isEmpty ||
            cityController.text.isEmpty ||
            stateController.text.isEmpty ||
            countryController.text.isEmpty) {
          hasCorrespondingAddress = false;
          return;
        }
        hasCorrespondingAddress =
            correspondAddressController.text == addressController.text &&
                correspondPostcodeController.text == postcodeController.text &&
                correspondCityController.text == cityController.text &&
                correspondStateController.text == stateController.text &&
                correspondCountryController.text == countryController.text;
      });
    });
  }

  @override
  void initState() {
    addressController = TextEditingController(text: widget.address?.street);
    postcodeController = TextEditingController(text: widget.address?.postCode);
    cityController = TextEditingController(text: widget.address?.city);
    stateController = TextEditingController(text: widget.address?.state);
    countryController = TextEditingController(text: widget.address?.country);

    if (widget.requiredCorrespondingAddress) {
      if (widget.address?.isSameCorrespondingAddress ?? false) {
        correspondAddressController =
            TextEditingController(text: widget.address?.street);
        correspondPostcodeController =
            TextEditingController(text: widget.address?.postCode);
        correspondCityController =
            TextEditingController(text: widget.address?.city);
        correspondStateController =
            TextEditingController(text: widget.address?.state);
        correspondCountryController =
            TextEditingController(text: widget.address?.country);
      } else {
        correspondAddressController = TextEditingController(
            text: widget.address?.correspondAddress?.street);
        correspondPostcodeController = TextEditingController(
            text: widget.address?.correspondAddress?.postCode);
        correspondCityController = TextEditingController(
            text: widget.address?.correspondAddress?.city);
        correspondStateController = TextEditingController(
            text: widget.address?.correspondAddress?.state);
        correspondCountryController = TextEditingController(
            text: widget.address?.correspondAddress?.country);
      }
      isCorrespondingValid();
    }

    super.initState();
  }

  @override
  Address onSaved() {
    return Address(
        street: addressController.text,
        postCode: postcodeController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        correspondAddress: widget.requiredCorrespondingAddress
            ? Address(
                street: correspondAddressController.text,
                postCode: correspondPostcodeController.text,
                city: correspondCityController.text,
                state: correspondStateController.text,
                country: correspondCountryController.text)
            : null,
        isSameCorrespondingAddress: widget.requiredCorrespondingAddress
            ? hasCorrespondingAddress
            : false);
  }

  @override
  bool validate() {
    return addressController.text.isNotEmpty &&
        postcodeController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        (widget.requiredCorrespondingAddress
            ? correspondAddressController.text.isNotEmpty &&
                correspondPostcodeController.text.isNotEmpty &&
                correspondCityController.text.isNotEmpty &&
                correspondStateController.text.isNotEmpty &&
                correspondCountryController.text.isNotEmpty
            : true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
            label: widget.addressLabel ?? 'Address',
            controller: addressController,
            fieldKey: AppFormFieldKey.addressKey,
            isRequired: widget.isRequired,
            isEnabled: widget.isEnabled ?? true,
            onChanged: (value) {
              if (widget.requiredCorrespondingAddress &&
                  hasCorrespondingAddress) {
                correspondAddressController.text = addressController.text;
              }
            },
            formKey: widget.formKey),
        Row(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return AppTextFormField(
                  maxLength: 5,
                  isEnabled: widget.isEnabled ?? true,
                  formKey: widget.formKey,
                  label: 'Postcode',
                  isRequired: widget.isRequired,
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

                    if (widget.requiredCorrespondingAddress &&
                        hasCorrespondingAddress) {
                      correspondPostcodeController.text = postcode;
                      correspondCityController.text = cityController.text;
                      correspondStateController.text = stateController.text;
                      correspondCountryController.text = countryController.text;
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
                  isRequired: widget.isRequired,
                  controller: cityController,
                  isEnabled: widget.isEnabled ?? true,
                  onChanged: (_) {
                    if (widget.requiredCorrespondingAddress &&
                        hasCorrespondingAddress) {
                      correspondCityController.text = cityController.text;
                    }
                  },
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
                  isRequired: widget.isRequired,
                  isEnabled: widget.isEnabled ?? true,
                  controller: stateController,
                  onChanged: (_) {
                    if (widget.requiredCorrespondingAddress &&
                        hasCorrespondingAddress) {
                      correspondStateController.text = stateController.text;
                    }
                  },
                  fieldKey: AppFormFieldKey.stateKey),
            ),
            gapWidth24,
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final countries =
                    ref.read(countryCodeProvider).countryCodes ?? [];

                return AppDropdown(
                    label: 'Country',
                    isRequired: widget.isRequired,
                    textController: countryController,
                    formKey: widget.formKey,
                    fieldKey: AppFormFieldKey.countryKey,
                    hintText: 'Country',
                    onSelected: (_) {
                      if (widget.requiredCorrespondingAddress &&
                          hasCorrespondingAddress) {
                        correspondCountryController.text =
                            countryController.text;
                      }
                    },
                    options: countries
                        .map((country) => AppDropDownItem(
                            value: country.countryName ?? '',
                            text: country.countryName ?? ''))
                        .toList());
              }),
            )
          ],
        ),
        if (widget.requiredCorrespondingAddress)
          Column(
            children: [
              gapHeight24,
              AppCheckbox(
                formKey: widget.formKey,
                label:
                    'My corresponding address is same with my permanent address',
                fieldKey: AppFormFieldKey.sameRegisteredAddressKey,
                isTick: hasCorrespondingAddress,
                onCheck: (checked) {
                  if (checked) {
                    correspondAddressController.text = addressController.text;
                    correspondPostcodeController.text = postcodeController.text;
                    correspondCityController.text = cityController.text;
                    correspondStateController.text = stateController.text;
                    correspondCountryController.text = countryController.text;
                  } else {
                    correspondAddressController.clear();
                    correspondPostcodeController.clear();
                    correspondCityController.clear();
                    correspondStateController.clear();
                    correspondCountryController.clear();
                  }
                  setState(() {
                    hasCorrespondingAddress = checked;
                  });
                  widget.formKey.currentState!.validateFormButton();
                },
              ),
              AppTextFormField(
                  label: 'Corresponding Address',
                  controller: correspondAddressController,
                  isEnabled: !hasCorrespondingAddress,
                  fieldKey: AppFormFieldKey.correspondingAddressKey,
                  formKey: widget.formKey),
              Row(
                children: [
                  Expanded(
                    child: Consumer(builder: (context, ref, child) {
                      return AppTextFormField(
                        maxLength: 5,
                        formKey: widget.formKey,
                        label: 'Postcode',
                        isEnabled: !hasCorrespondingAddress,
                        controller: correspondPostcodeController,
                        fieldKey: AppFormFieldKey.correspondingPostcodeKey,
                        keyboardType: TextInputType.number,
                        onChanged: (postcode) {
                          if (postcode.isNotEmpty && postcode.length == 5) {
                            Map<String, String> autoPopulateResult = ref
                                .read(postcodeProvider.notifier)
                                .autoPopulateFromPostCode(postcode: postcode);
                            correspondCityController.text =
                                autoPopulateResult['city'] ?? '';
                            correspondStateController.text =
                                autoPopulateResult['state'] ?? '';

                            if (correspondCityController.text.isNotEmpty &&
                                correspondStateController.text.isNotEmpty) {
                              correspondCountryController.text = ref
                                      .read(countryCodeProvider.notifier)
                                      .getObjectByCountryName(
                                          country: 'MALAYSIA')
                                      ?.countryName ??
                                  '';
                            }
                          } else if (postcode.isEmpty) {
                            correspondCityController.clear();
                            correspondStateController.clear();
                            correspondCountryController.clear();
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
                        isEnabled: !hasCorrespondingAddress,
                        controller: correspondCityController,
                        fieldKey: AppFormFieldKey.correspondingCityKey),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                        formKey: widget.formKey,
                        label: 'State',
                        isEnabled: !hasCorrespondingAddress,
                        controller: correspondStateController,
                        fieldKey: AppFormFieldKey.correspondingStateKey),
                  ),
                  gapWidth24,
                  Expanded(
                    child: Consumer(builder: (context, ref, child) {
                      final countries =
                          ref.read(countryCodeProvider).countryCodes ?? [];

                      return AppDropdown(
                          label: 'Country',
                          textController: correspondCountryController,
                          formKey: widget.formKey,
                          enabled: !hasCorrespondingAddress,
                          fieldKey: AppFormFieldKey.correspondingCountryKey,
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
          )
      ],
    );
  }
}
