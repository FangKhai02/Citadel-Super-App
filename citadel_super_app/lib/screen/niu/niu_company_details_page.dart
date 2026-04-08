import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/niu_application_state.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuCompanyDetailsPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  NiuCompanyDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final niuApplicationNotifier = ref.watch(niuApplicationProvider.notifier);
    final constants = ref.read(appProvider).constants ?? [];
    final businessType = constants
            .firstWhere(
                (element) => element.category == AppConstantsKey.industryType)
            .list ??
        [];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(
          title: 'Niu Application',
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Company Details',
                  style: AppTextStyle.header1,
                ),
                AppTextFormField(
                  formKey: formKey,
                  label: 'Company Name',
                  fieldKey: AppFormFieldKey.nameKey,
                ),
                AppTextFormField(
                  formKey: formKey,
                  label: 'Company Registration Number',
                  fieldKey: AppFormFieldKey.registrationNumberKey,
                ),
                AppDropdown(
                  label: 'Nature of Business',
                  fieldKey: AppFormFieldKey.natureOfBusinessKey,
                  formKey: formKey,
                  options: businessType
                      .map(
                          (e) => AppDropDownItem(value: e.key!, text: e.value!))
                      .toList(),
                ),
                AppTextFormField(
                  formKey: formKey,
                  label: 'Purpose of Advances',
                  fieldKey: AppFormFieldKey.purposeOfAdvanceKey,
                ),
                AddressDetailsForm(
                  addressLabel: 'Business Address',
                  formKey: formKey,
                  fieldKey: AppFormFieldKey.businessAddressDetailsFormKey,
                ),
                AppMobileFormField(
                  formKey: formKey,
                  label: 'Office Number',
                ),
                AppTextFormField(
                  formKey: formKey,
                  label: 'Email',
                  fieldKey: AppFormFieldKey.emailKey,
                  keyboardType: TextInputType.emailAddress,
                ),
                gapHeight48,
                PrimaryButton(
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  title: 'Next',
                  onTap: () async {
                    await formKey.currentState?.validate(onSuccess: (formData) {
                      Address address = formData[
                          AppFormFieldKey.businessAddressDetailsFormKey];

                      niuApplicationNotifier
                          .setName(formData[AppFormFieldKey.nameKey]);
                      niuApplicationNotifier.setDocumentNumber(
                          formData[AppFormFieldKey.registrationNumberKey]);
                      niuApplicationNotifier.setNatureOfBusiness(
                          formData[AppFormFieldKey.natureOfBusinessKey]);
                      niuApplicationNotifier.setPurposeOfAdvances(
                          formData[AppFormFieldKey.purposeOfAdvanceKey]);
                      niuApplicationNotifier.setAddress(address);
                      niuApplicationNotifier.setMobileNumber(
                          formData[AppFormFieldKey.countryCodeKey],
                          formData[AppFormFieldKey.mobileNumberKey]);
                      niuApplicationNotifier
                          .setEmail(formData[AppFormFieldKey.emailKey]);

                      Navigator.pushNamed(context, CustomRouter.niuDocument);
                    });
                  },
                ),
                gapHeight16,
              ],
            ),
          ),
        ));
  }
}
