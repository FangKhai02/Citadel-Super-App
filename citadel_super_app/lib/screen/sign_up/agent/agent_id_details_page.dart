import 'dart:convert';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/sign_up_repository.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/state/existing_agent_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_document_image_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentIdDetailsPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  AgentIdDetailsPage({
    super.key,
  });

  @override
  ConsumerState<AgentIdDetailsPage> createState() => AgentIdDetailsPageState();
}

class AgentIdDetailsPageState extends ConsumerState<AgentIdDetailsPage> {
  late final TextEditingController nameController;
  late final TextEditingController documentNumberController;
  late final TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    documentNumberController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(agentSignUpProvider);
    final microblinkResultState = ref.watch(microblinkResultProvider);

    void checkForExistingAgentData() {
      SignUpRepository()
          .checkExistingAgent(microblinkResultState
              .getResultAsClientPersonalDetails.identityCardNumberDisplay)
          .baseThen(
        context,
        onResponseSuccess: (response) {
          if (response.identityDetails != null) {
            ref
                .read(existingAgentProvider.notifier)
                .setExistingClient(response);
          }

          nameController.text =
              response.identityDetails?.fullName ?? nameController.text;
          documentNumberController.text =
              response.identityDetails?.identityCardNumber ??
                  documentNumberController.text;
          dobController.text =
              response.identityDetails?.dob?.toDDMMYYY ?? dobController.text;

          widget.formKey.currentState!.validateFormButton();
        },
        onResponseError: (e, s) {
          if (e.message.equalsIgnoreCase(
              'api.account.registered.with.identity.card.number')) {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AppDialog(
                    title: 'Identity Card Used',
                    message:
                        'This identity card number is already registered. Please contact our support team for assistance.',
                    isRounded: true,
                    positiveOnTap: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (routes) {
                        if ([
                          CustomRouter.signUp,
                        ].contains(routes.settings.name)) {
                          return true;
                        }

                        return false;
                      });
                    },
                    showNegativeButton: false,
                  );
                });
          }
        },
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nameController.text =
            microblinkResultState.getResultAsClientPersonalDetails.nameDisplay;
        documentNumberController.text = microblinkResultState
            .getResultAsClientPersonalDetails.identityCardNumberDisplay;
        dobController.text =
            microblinkResultState.getResultAsClientPersonalDetails.dobDisplay;

        checkForExistingAgentData();
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Identity Verification'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: widget.formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Confirm ID Details', style: AppTextStyle.header1.copyWith(
                fontSize: 28.spMin,
                height: 1.3,
                letterSpacing: -0.5,
              )),
              AppTextFormField(
                formKey: widget.formKey,
                label: 'Full Name (same as User ID)',
                controller: nameController,
                fieldKey: AppFormFieldKey.nameKey,
                hint: 'eg. John Doe',
              ),
              AppTextFormField(
                formKey: widget.formKey,
                label: '${microblinkResultState?.docType ?? 'MYKAD'} Number',
                isEnabled: false,
                controller: documentNumberController,
                fieldKey: AppFormFieldKey.documentNumberKey,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: microblinkResultState?.isMyKad == true ? 12 : null,
                validator: (value) {
                  if (microblinkResultState?.isMyKad == true) {
                    if (value.length < 12) {
                      return 'Invalid MyKad number';
                    }
                  }
                  return '';
                },
                hint: 'eg. 123456789012',
              ),
              AppDatePickerFormField(
                formKey: widget.formKey,
                label: 'Date of Birth',
                controller: dobController,
                isEnabled: false,
              ),
              gapHeight32,
              AppDocumentImageFormField(
                documentType: microblinkResultState?.docType ?? 'MYKAD',
                frontImage: microblinkResultState?.frontImage?.isNotEmpty == true
                    ? base64Decode(microblinkResultState!.frontImage!)
                    : null,
                backImage: microblinkResultState?.backImage?.isNotEmpty == true
                    ? base64Decode(microblinkResultState!.backImage!)
                    : null,
                onRescanComplete: (result) {
                  setState(() {
                    nameController.text =
                        result.getResultAsClientPersonalDetails.nameDisplay;
                    documentNumberController.text = result
                        .getResultAsClientPersonalDetails
                        .identityCardNumberDisplay;
                    dobController.text =
                        result.getResultAsClientPersonalDetails.dobDisplay;

                    widget.formKey.currentState!.validateFormButton();
                  });
                },
              ),
              gapHeight48,
              PrimaryButton(
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                onTap: (() async {
                  await widget.formKey.currentState!.validate(
                      onSuccess: (formData) async {
                    await validateAgentIdentity(context, ref, formData);
                  });
                }),
                title: 'Continue',
              ),
              gapHeight16,
            ]),
          ),
        ));
  }

  Future<void> validateAgentIdentity(
      BuildContext context, WidgetRef ref, formData) async {
    final microblinkResultState = ref.read(microblinkResultProvider);

    SignUpRepository repo = SignUpRepository();
    final req = ParameterHelper().agentIdentifyValidationParam(
        microblinkResultState.docTypeConstant(), formData);

    await repo.agentIdentityValidation(req).baseThen(
      context,
      onResponseSuccess: (response) {
        globalRef
            .read(agentSignUpProvider.notifier)
            .setSignUpBaseIdentityDetailsVo(req);
        Navigator.pushNamed(context, CustomRouter.contactDetails);
      },
      onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper()
              .resolveValidationError(widget.formKey, e.message);
        } else {
          if (e.message.equalsIgnoreCase(
              'api.account.registered.with.identity.card.number')) {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AppDialog(
                    title: 'Identity Card Used',
                    message:
                        'This identity card number is already registered. Please contact our support team for assistance.',
                    isRounded: true,
                    positiveOnTap: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (routes) {
                        if ([
                          CustomRouter.signUp,
                        ].contains(routes.settings.name)) {
                          return true;
                        }

                        return false;
                      });
                    },
                    showNegativeButton: false,
                  );
                });
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
