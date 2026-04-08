import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/sign_up_repository.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/state/existing_agent_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_vo.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactDetailsPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  ContactDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final microblinkResultState = ref.watch(microblinkResultProvider);
    final existingAgentState = ref.watch(existingAgentProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Identity Verification'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Contact Details', style: AppTextStyle.header1.copyWith(
                fontSize: 28.spMin,
                height: 1.3,
                letterSpacing: -0.5,
              )),
              UserContactForm(
                formKey: formKey,
                user: existingAgentState != null
                    ? ClientPersonalDetailsVo(
                        email: existingAgentState.contactDetails?.email,
                        mobileNumber:
                            existingAgentState.contactDetails?.mobileNumber,
                        mobileCountryCode: existingAgentState
                            .contactDetails?.mobileCountryCode,
                        address: existingAgentState.contactDetails?.address,
                        postcode: existingAgentState.contactDetails?.postcode,
                        city: existingAgentState.contactDetails?.city,
                        state: existingAgentState.contactDetails?.state,
                        country: existingAgentState.contactDetails?.country,
                        correspondingAddress: existingAgentState
                            .contactDetails?.correspondingAddress,
                      )
                    : microblinkResultState.getResultAsClientPersonalDetails,
              ),
              gapHeight32,
              AppUploadDocumentWidget(
                formKey: formKey,
                label: 'Proof of Address',
                initialFiles:
                    existingAgentState?.contactDetails?.proofOfAddressFile !=
                            null
                        ? [
                            NetworkFile(
                                url: existingAgentState
                                        ?.contactDetails?.proofOfAddressFile ??
                                    '')
                          ]
                        : [],
                fieldKey: AppFormFieldKey.proofDocKey,
                type: DocumentType.proofOfAddress,
              ),
              gapHeight48,
              PrimaryButton(
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                onTap: (() async {
                  await formKey.currentState!.validate(
                      onSuccess: (formData) async {
                    await agentContactValidate(context, formData);
                  });
                }),
                title: 'Continue',
              ),
              gapHeight16,
            ]),
          ),
        ));
  }

  Future<void> agentContactValidate(BuildContext context, formData) async {
    SignUpRepository repo = SignUpRepository();
    final req = ParameterHelper().agentContactValidationParam(formData);
    await repo.agentContactValidation(req).baseThen(
      context,
      onResponseSuccess: (response) {
        globalRef
            .read(agentSignUpProvider.notifier)
            .setSignUpBaseContactDetailsVo(req);
        Navigator.pushNamed(context, CustomRouter.selfie);
      },
      onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper().resolveValidationError(formKey, e.message);
        } else {
          if (e.message == 'api.email.has.been.taken') {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                content:
                    Text('The email address you entered is already in use'),
                backgroundColor: AppColor.errorRed,
              ),
            );
          } else {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              SnackBar(
                content: Text(e.message),
                backgroundColor: AppColor.errorRed,
              ),
            );
          }
        }
      },
    );
  }
}
