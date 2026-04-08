import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/vo/sign_up_agent_agency_details_request_vo.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/agency_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgencyDetailsPage extends HookWidget {
  AgencyDetailsPage({super.key});

  final formKey = GlobalKey<AppFormState>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.darkToBright2,
          appBar: const CitadelAppBar(title: 'Enter your details'),
          bottomNavigationBar: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
              child: PrimaryButton(
                title: 'Continue',
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                onTap: () async {
                  await formKey.currentState?.validate(
                      onSuccess: (formData) async {
                    ValidationRepository validationRepository =
                        ValidationRepository();
                    validationRepository
                        .recruitmentManagerValidation(
                            formData[AppFormFieldKey.agencyIDKey],
                            formData[AppFormFieldKey.recruitmentManagerKey])
                        .baseThen(
                      context,
                      onResponseSuccess: (data) {
                        globalRef
                            .read(agentSignUpProvider.notifier)
                            .setSignUpAgentAgencyDetailsRequestVo(
                                SignUpAgentAgencyDetailsRequestVo(
                              agencyId: formData[AppFormFieldKey.agencyIDKey],
                              recruitManagerCode: formData[
                                  AppFormFieldKey.recruitmentManagerKey],
                            ));
                        Navigator.pushNamed(context, CustomRouter.bankDetails);
                      },
                      onResponseError: (e, s) {
                        if (e.message
                            .equalsIgnoreCase('api.invalid.agent.code')) {
                          context.showErrorSnackBar(
                              'Agent code does not exist. Kindly contact your agency to get the recruiting manager code.');
                        } else {
                          context.showErrorSnackBar(e.message);
                        }
                      },
                    );
                  });
                },
              )),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Agency Details', style: AppTextStyle.header1.copyWith(
                      fontSize: 28.spMin,
                      height: 1.3,
                      letterSpacing: -0.5,
                    )),
                    gapHeight32,
                    AgencyDetailsForm(formKey: formKey),
                  ]))),
    );
  }
}
