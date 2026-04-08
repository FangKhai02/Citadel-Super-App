import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddEditWealthSourceDetailPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  AddEditWealthSourceDetailPage({super.key});

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
                  : 'Add Wealth Source');
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
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppForm(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wealth Source Details', style: AppTextStyle.header1),
                    gapHeight32,
                    AppTextFormField(
                      formKey: formKey,
                      label: 'Annual Income Declared',
                      initialValue: data
                          .wealthSourceDetails.annualIncomeDeclarationDisplay,
                      fieldKey: AppFormFieldKey.annualIncomeKey,
                    ),
                    gapHeight32,
                    AppTextFormField(
                      formKey: formKey,
                      label: 'Source of Income',
                      initialValue:
                          data.wealthSourceDetails.sourceOfIncomeDisplay,
                      fieldKey: AppFormFieldKey.sourceOfIncomeKey,
                    ),
                    gapHeight48,
                    PrimaryButton(
                      key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                      onTap: (() async {
                        await formKey.currentState!.validate(
                            onSuccess: (formData) {
                          Navigator.pop(context);
                        });
                      }),
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
      ),
    );
  }
}
