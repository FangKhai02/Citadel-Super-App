import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/agency_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddEditAgentDetailPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  AddEditAgentDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider(null));

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
              title: data.agentDetails != null
                  ? 'Edit your details'
                  : 'Add Agent');
        },
        orElse: () => const CitadelAppBar(),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        child: PrimaryButton(
          key: const Key(AppFormFieldKey.primaryButtonValidateKey),
          onTap: profile.whenOrNull(data: (data) {
            return () async {
              await formKey.currentState!.validate(onSuccess: (formData) {
                Navigator.pop(context);
              });
            };
          }),
          title: 'Confirm',
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: profile.maybeWhen(
          data: (data) {
            return AppForm(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Agency Details', style: AppTextStyle.header1),
                  gapHeight32,
                  AgencyDetailsForm(formKey: formKey),
                  AppDropdown(
                    formKey: formKey,
                    label: 'Recruitment Manager',
                    fieldKey: AppFormFieldKey.recruitmentManagerKey,
                    hintText: 'Recruitment Manager',
                    options: [
                      AppDropDownItem(value: 'Alan Kua', text: 'Alan Kua'),
                      AppDropDownItem(
                          value: 'Josephine Tan', text: 'Josephine Tan'),
                      AppDropDownItem(value: 'Siti Nur', text: 'Siti Nur'),
                      AppDropDownItem(
                          value: 'Mohamaad Ali', text: 'Mohammad Ali'),
                      AppDropDownItem(value: 'Monalisa', text: 'Monalisa'),
                      AppDropDownItem(value: 'Roxanne', text: 'Roxanne'),
                      AppDropDownItem(value: 'Abang', text: 'Abang'),
                      AppDropDownItem(value: 'Adik', text: 'Adik'),
                    ],
                    onSelected: (item) {},
                  ),
                ],
              ),
            );
          },
          orElse: () => const Text('Something Went Wrong'),
        ),
      ),
    );
  }
}
