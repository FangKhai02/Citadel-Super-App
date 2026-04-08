import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/state/agent_profile_state.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/agent_details_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_details_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddEditAgentProfilePage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  AddEditAgentProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(agentProfileFutureProvider);

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
              title: data.personalDetails != null
                  ? 'Edit your details'
                  : 'Add Personal Details');
        },
        orElse: () => const CitadelAppBar(),
      ),
      child: profile.maybeWhen(
        data: (data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppForm(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Personal Details', style: AppTextStyle.header1),
                  gapHeight32,
                  AgentDetailsForm(
                    formKey: formKey,
                    agent: data.personalDetails,
                    disabledFields: const [
                      DisabledField.myKadNumber,
                      DisabledField.dob,
                      DisabledField.name,
                      DisabledField.email,
                    ],
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
          );
        },
        orElse: () => const Text('Something Went Wrong'),
      ),
    );
  }

  Future<void> update(BuildContext context, WidgetRef ref) async {
    await formKey.currentState!.validate(onSuccess: (formData) async {
      final AgentRepository repo = AgentRepository();

      final req = ParameterHelper().agentProfileUpdateParam(formData);

      EasyLoadingHelper.show();
      await repo.updateAgentProfile(req).baseThen(
        context,
        onResponseSuccess: (_) {
          final latestContext = (getAppContext() ?? context);

          latestContext.showSuccessSnackBar('Successfully Updated');
          ref.invalidate(agentProfileFutureProvider);
          Navigator.pop(latestContext);
        },
      ).whenComplete(() => EasyLoadingHelper.dismiss());
    });
  }
}
