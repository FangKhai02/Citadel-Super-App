import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/response/agent_profile_response_vo.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/state/agent_profile_state.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/niu_application_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuPersonalDetailsPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  NiuPersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoginAsAgent = ref.watch(bottomNavigationProvider).isLoginAsAgent;
    final profile = ref.watch(
        isLoginAsAgent ? agentProfileFutureProvider : profileProvider(null));
    final niuApplicationNotifier = ref.watch(niuApplicationProvider.notifier);

    final constants = ref.read(appProvider).constants ?? [];
    final businessType = constants
            .firstWhere(
                (element) => element.category == AppConstantsKey.industryType)
            .list ??
        [];

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(
          title: 'Niu Application',
        ),
        child: profile.maybeWhen(
          data: (data) {
            ClientPersonalDetailsVo user;
            if (data is AgentProfileResponseVo) {
              final agentProfile = data.personalDetails;
              user = ClientPersonalDetailsVo(
                name: agentProfile?.name ?? '',
                identityCardNumber: agentProfile?.identityCardNumber ?? '',
                mobileCountryCode: agentProfile?.mobileCountryCode ?? '',
                mobileNumber: agentProfile?.mobileNumber ?? '',
                email: agentProfile?.email ?? '',
                address: agentProfile?.address ?? '',
                postcode: agentProfile?.postcode ?? '',
                city: agentProfile?.city ?? '',
                state: agentProfile?.state ?? '',
                country: agentProfile?.country ?? '',
              );
            } else {
              user = (data as ClientProfileResponseVo).personalDetails!;
            }

            return AppForm(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal Details', style: AppTextStyle.header1),
                    gapHeight32,
                    AppTextFormField(
                      formKey: formKey,
                      label: 'Full Name',
                      initialValue: user.nameDisplay,
                      fieldKey: AppFormFieldKey.nameKey,
                      hint: 'eg. John Doe',
                    ),
                    AppTextFormField(
                      formKey: formKey,
                      label: 'User ID',
                      initialValue: user.identityCardNumberDisplay,
                      fieldKey: AppFormFieldKey.documentNumberKey,
                      hint: 'eg. 123456789012',
                    ),
                    UserContactForm(formKey: formKey, user: user),
                    AppDropdown(
                      label: 'Nature of Business',
                      fieldKey: AppFormFieldKey.natureOfBusinessKey,
                      formKey: formKey,
                      options: businessType
                          .map((e) =>
                              AppDropDownItem(value: e.key!, text: e.value!))
                          .toList(),
                    ),
                    AppTextFormField(
                      formKey: formKey,
                      label: 'Purpose of Advances',
                      fieldKey: AppFormFieldKey.purposeOfAdvanceKey,
                    ),
                    gapHeight48,
                    PrimaryButton(
                      key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                      title: 'Next',
                      onTap: () async {
                        await formKey.currentState?.validate(
                            onSuccess: (formData) {
                          Address address =
                              formData[AppFormFieldKey.addressDetailsFormKey];

                          niuApplicationNotifier
                              .setName(formData[AppFormFieldKey.nameKey]);
                          niuApplicationNotifier.setDocumentNumber(
                              formData[AppFormFieldKey.documentNumberKey]);
                          niuApplicationNotifier.setAddress(address);
                          niuApplicationNotifier.setMobileNumber(
                              formData[AppFormFieldKey.countryCodeKey],
                              formData[AppFormFieldKey.mobileNumberKey]);
                          niuApplicationNotifier
                              .setEmail(formData[AppFormFieldKey.emailKey]);
                          niuApplicationNotifier.setNatureOfBusiness(
                              formData[AppFormFieldKey.natureOfBusinessKey]);
                          niuApplicationNotifier.setPurposeOfAdvances(
                              formData[AppFormFieldKey.purposeOfAdvanceKey]);

                          Navigator.pushNamed(
                              context, CustomRouter.niuDocument);
                        });
                      },
                    )
                  ],
                ),
              ),
            );
          },
          orElse: () {
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
