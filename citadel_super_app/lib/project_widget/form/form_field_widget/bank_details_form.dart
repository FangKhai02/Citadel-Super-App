import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/postcode_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/bank_selection_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BankDetailsForm extends StatefulHookConsumerWidget {
  final GlobalKey<AppFormState> formKey;
  final CommonBankDetails? bank;

  const BankDetailsForm({super.key, required this.formKey, this.bank});

  @override
  BankDetailsFormState createState() => BankDetailsFormState();
}

class BankDetailsFormState extends ConsumerState<BankDetailsForm> {
  late final TextEditingController bankNameController;
  late final TextEditingController swiftCodeController;
  late final TextEditingController addressController;
  late final TextEditingController postcodeController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController countryController;

  @override
  void initState() {
    bankNameController = TextEditingController(text: widget.bank?.bankName);
    swiftCodeController = TextEditingController(text: widget.bank?.swiftCode);
    addressController = TextEditingController(text: widget.bank?.bankAddress);
    postcodeController = TextEditingController(text: widget.bank?.bankPostcode);
    cityController = TextEditingController(text: widget.bank?.bankCity);
    stateController = TextEditingController(text: widget.bank?.bankState);
    countryController = TextEditingController(text: widget.bank?.bankCountry);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      bankNameController.text = widget.bank?.bankName ?? '';
      swiftCodeController.text = widget.bank?.swiftCode ?? '';
      addressController.text = widget.bank?.bankAddress ?? '';
      postcodeController.text = widget.bank?.bankPostcode ?? '';
      cityController.text = widget.bank?.bankCity ?? '';
      stateController.text = widget.bank?.bankState ?? '';
      countryController.text = widget.bank?.bankCountry ?? '';
      return;
    }, [widget.bank]);

    return Column(children: [
      AppTextFormField(
        label: 'Bank Name',
        controller: bankNameController,
        fieldKey: AppFormFieldKey.bankNameKey,
        formKey: widget.formKey,
        suffix: Assets.images.icons.dropdown.image(scale: 3),
        readOnly: true,
        validator: (value) {
          if (value.isEmpty || value.contains(RegExp(r'[!@#$%^*,.?":{}|<>]'))) {
            return 'Invalid Bank Name';
          }
          return '';
        },
        onTap: () async {
          final result = await showBankSelectionBottomSheet(context);
          if (result != null) {
            bankNameController.text = result.bankName!;
            addressController.text = result.bankAddress ?? '';
            postcodeController.text = result.bankPostcode ?? '';
            cityController.text = result.bankCity ?? '';
            stateController.text = result.bankState ?? '';
            countryController.text = result.bankCountry ?? '';
            swiftCodeController.text = result.swiftCode ?? '';
          }
          return null;
        },
      ),
      AppTextFormField(
        label: 'Bank Account Number',
        initialValue: widget.bank?.bankAccountNumber ?? '',
        fieldKey: AppFormFieldKey.bankAccountNumberKey,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        formKey: widget.formKey,
      ),
      AppTextFormField(
        label: 'Account Holder Name',
        initialValue: widget.bank?.bankAccountHolderName ?? '',
        fieldKey: AppFormFieldKey.accountBankHolderNameKey,
        validator: (value) {
          if (value.isEmpty ||
              value.length < 2 ||
              value.length > 100 ||
              !RegExp(r'^[^0-9]*$').hasMatch(value)) {
            return 'Invalid Account Holder Name';
          }
          return '';
        },
        formKey: widget.formKey,
        maxLength: 100,
      ),
      AppTextFormField(
        label: 'Bank Address (optional)',
        formKey: widget.formKey,
        isRequired: false,
        controller: addressController,
        fieldKey: AppFormFieldKey.addressKey,
      ),
      Row(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              return AppTextFormField(
                maxLength: 5,
                label: 'Postcode',
                formKey: widget.formKey,
                isRequired: false,
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
                  widget.formKey.currentState?.validateFormButton();
                },
              );
            }),
          ),
          gapWidth24,
          Expanded(
            child: AppTextFormField(
                label: 'City',
                formKey: widget.formKey,
                isRequired: false,
                controller: cityController,
                fieldKey: AppFormFieldKey.cityKey),
          )
        ],
      ),
      Row(
        children: [
          Expanded(
            child: AppTextFormField(
                isRequired: false,
                label: 'State',
                formKey: widget.formKey,
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
                  formKey: widget.formKey,
                  textController: countryController,
                  isRequired: false,
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
      AppTextFormField(
          isRequired: false,
          label: 'SWIFT Code (optional)',
          formKey: widget.formKey,
          controller: swiftCodeController,
          fieldKey: AppFormFieldKey.swiftCodeKey),
    ]);
  }
}
