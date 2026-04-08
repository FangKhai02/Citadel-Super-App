import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
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
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/employment_details_form.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddEditEmploymentDetailPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  AddEditEmploymentDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider(null));
    final employmentType = useState('');

    bool noNeedEmploymentDetails() {
      appDebugPrint(employmentType.value);
      return (employmentType.value.equalsIgnoreCase("HOUSEWIFE") ||
          employmentType.value.equalsIgnoreCase("RETIRED") ||
          employmentType.value.equalsIgnoreCase("UNEMPLOYED"));
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: profile.maybeWhen(
        data: (data) {
          return CitadelAppBar(
              title: data.employmentDetails != null
                  ? 'Edit your details'
                  : 'Add Employment');
        },
        orElse: () => const CitadelAppBar(),
      ),
      child: profile.maybeWhen(
        data: (data) {
          final constants = ref.read(appProvider).constants ?? [];
          final employmentTypeConstants = constants.firstWhere(
              (element) => element.category == AppConstantsKey.employmentType);
          if (employmentType.value.isEmpty) {
            employmentType.value = data.employmentDetails?.employmentType ?? '';
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppForm(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Employment Details', style: AppTextStyle.header1),
                  gapHeight32,
                  AppDropdown(
                    formKey: formKey,
                    fieldKey: AppFormFieldKey.employmentTypeKey,
                    label: 'Employment Type',
                    hintText: 'Select Employment Type',
                    options: employmentTypeConstants.list!
                        .map((e) =>
                            AppDropDownItem(value: e.key!, text: e.value!))
                        .toList(),
                    initialValue: getValueForKey(
                        data.employmentDetails.employmentTypeDisplay, ref),
                    // employmentTypeConstants.list!
                    //         .map((e) => e.key)
                    //         .firstWhereOrNull((item) =>
                    //             item ==
                    //             data.employmentDetails?.employmentType) ??
                    //     ''

                    onSelected: (item) {
                      employmentType.value = item.value;

                      formKey.currentState?.validateFormButton();
                    },
                  ),
                  Visibility(
                    visible: !noNeedEmploymentDetails(),
                    child: EmploymentDetailsForm(
                      formKey: formKey,
                      fieldKey: AppFormFieldKey.employmentAddressDetailsFormKey,
                      clientEmploymentDetails: data.employmentDetails,
                    ),
                  ),
                  gapHeight48,
                  PrimaryButton(
                    key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                    onTap: () async => await update(context, ref, data),
                    title: 'Confirm',
                  ),
                  gapHeight16,
                ],
              ),
            ),
          );
        },
        orElse: () => const Text('Something Went Wrong'),
      ),
    );
  }

  Future<void> update(
      BuildContext context, WidgetRef ref, ClientProfileResponseVo user) async {
    await formKey.currentState!.validate(onSuccess: (formData) async {
      final ClientRepository clientRepository = ClientRepository();

      EasyLoadingHelper.show();
      await clientRepository
          .editProfile(ParameterHelper().editProfileParam(formData, user))
          .baseThen(
        context,
        onResponseSuccess: (_) async {
          final latestContext = getAppContext() ?? context;
          latestContext.showSuccessSnackBar('Successfully Updated');
          // ignore: unused_result
          await ref.refresh(profileProvider(null).future);
          Navigator.pop(getAppContext() ?? context);
        },
        onResponseError: (e, s) {
          if (e.message.contains('validation')) {
            FormValidationHelper().resolveValidationError(formKey, e.message);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColor.errorRed,
                content: Text(e.message),
              ),
            );
          }
        },
      ).whenComplete(() => EasyLoadingHelper.dismiss());
    });
  }
}
