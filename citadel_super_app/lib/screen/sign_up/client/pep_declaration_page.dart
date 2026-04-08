import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/state/existing_client_state.dart';
import 'package:citadel_super_app/data/state/sign_up_state.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_options_vo.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_vo.dart';
import 'package:citadel_super_app/extension/existing_client_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/project_widget/selection/dual_horizontal_tile_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PepDeclarationPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  PepDeclarationPage({super.key});

  @override
  PepDeclarationPageState createState() => PepDeclarationPageState();
}

class PepDeclarationPageState extends ConsumerState<PepDeclarationPage> {
  late final TextEditingController nameController;
  late final TextEditingController positionController;
  late final TextEditingController organisationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    positionController = TextEditingController();
    organisationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.watch(signUpProvider.notifier);
    final existingClientState = ref.watch(existingClientProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (existingClientState?.pepDeclaration != null) {
          signUpNotifier.setPEPDeclarationPoliticalRelated(
              existingClientState?.pepDeclaration?.isPep);

          switch (existingClientState?.getPepRelationship()) {
            case 'Self':
              signUpNotifier
                  .setPepDeclarationRelationship(RelationshipWithPep.self);
              break;
            case 'Immediate Family Member':
              signUpNotifier.setPepDeclarationRelationship(
                  RelationshipWithPep.familyMember);
              break;
            case 'Close Associate':
              signUpNotifier.setPepDeclarationRelationship(
                  RelationshipWithPep.closeAssociate);
              break;
          }

          nameController.text = existingClientState
                  ?.pepDeclaration?.pepDeclarationOptions?.name ??
              '';
          positionController.text = existingClientState
                  ?.pepDeclaration?.pepDeclarationOptions?.position ??
              '';
          organisationController.text = existingClientState
                  ?.pepDeclaration?.pepDeclarationOptions?.organization ??
              '';
        }

        widget.formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState?.validateFormButton();
      });
      return null;
    }, [signUpState.getPepDeclarationModel]);

    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          signUpNotifier.setPEPDeclarationPoliticalRelated(null);
        }
      },
      child: AppForm(
        key: widget.formKey,
        child: CitadelBackground(
            backgroundType: BackgroundType.pureBlack,
            appBar: const CitadelAppBar(title: 'Declaration of PEP'),
            bottomNavigationBar: signUpState
                            .getPepDeclarationModel.politicalRelated !=
                        null &&
                    !signUpState.getPepDeclarationModel.getPoliticalRelated
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(bottom: 16.h),
                    child: PrimaryButton(
                      key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                      title: 'Continue',
                      onTap: () async {
                        await validateNotPep(ref);
                      },
                    ),
                  )
                : null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you a politically exposed person? (PEP)',
                    style: AppTextStyle.header1.copyWith(
                      fontSize: 28.spMin,
                      height: 1.3,
                      letterSpacing: -0.5,
                    ),
                  ),
                  gapHeight16,
                  Text(
                    'A senior military, government or political official of any country? A senior executive of a state-owned corporation, or an immediate family member or close associate of such a person?',
                    style: AppTextStyle.bodyText,
                  ),
                  gapHeight32,
                  DualHorizontalTileSelection(
                    items: const [
                      'Yes',
                      'No',
                    ],
                    initialSelectedIndex:
                        (existingClientState?.pepDeclaration?.isPep != null)
                            ? (existingClientState!.pepDeclaration!.isPep!
                                ? 0
                                : 1)
                            : null,
                    onSelected: (index) {
                      signUpNotifier
                          .setPEPDeclarationPoliticalRelated(index == 0);
                      widget.formKey.currentState?.validateFormButton();
                    },
                  ),
                  gapHeight32,
                  Visibility(
                      visible: signUpState
                          .getPepDeclarationModel.getPoliticalRelated,
                      child: Column(
                        children: [
                          Text(
                            'Select the option below',
                            style: AppTextStyle.header3,
                          ),
                          gapHeight16,
                          AppListTileSelection(
                            items: getPepRelationshipList,
                            initialSelectedIndex: getPepRelationshipIndex(
                                existingClientState?.getPepRelationship() ??
                                    ''),
                            onSelected: (index) {
                              switch (index) {
                                case 0:
                                  signUpNotifier.setPepDeclarationRelationship(
                                      RelationshipWithPep.self);
                                  setState(() {
                                    nameController.clear();
                                  });

                                  break;
                                case 1:
                                  signUpNotifier.setPepDeclarationRelationship(
                                      RelationshipWithPep.familyMember);
                                  break;
                                case 2:
                                  signUpNotifier.setPepDeclarationRelationship(
                                      RelationshipWithPep.closeAssociate);
                                  break;
                              }
                            },
                          )
                        ],
                      )),
                  Visibility(
                      visible: signUpState
                              .getPepDeclarationModel.getPoliticalRelated &&
                          signUpState.getPepDeclarationModel
                                  .getRelationshipWithPep !=
                              null,
                      child: Column(
                        children: [
                          if (signUpState.getPepDeclarationModel
                                  .getRelationshipWithPep !=
                              RelationshipWithPep.self)
                            AppTextFormField(
                                key: const Key('name'),
                                formKey: widget.formKey,
                                label:
                                    'Full Name of ${signUpState.getPepDeclarationModel.getRelationshipWithPep == RelationshipWithPep.familyMember ? 'Immediate Family' : 'Close Associate'}',
                                controller: nameController,
                                fieldKey:
                                    AppFormFieldKey.immediateFamilyNameKey),
                          AppTextFormField(
                              key: const Key('current position'),
                              formKey: widget.formKey,
                              label: 'Current Postition / Designation',
                              controller: positionController,
                              fieldKey: AppFormFieldKey.designationKey),
                          AppTextFormField(
                              key: const Key('Organisation'),
                              formKey: widget.formKey,
                              label: 'Organisation / Entity',
                              controller: organisationController,
                              fieldKey: AppFormFieldKey.organisationKey),
                          gapHeight16,
                          AppUploadDocumentWidget(
                            formKey: widget.formKey,
                            fieldKey: AppFormFieldKey.proofDocKey,
                            initialFiles: existingClientState?.pepDocFile !=
                                    null
                                ? [
                                    NetworkFile(
                                        url: existingClientState!.pepDocFile!)
                                  ]
                                : [],
                            label: 'Supporting Document',
                          ),
                        ],
                      )),
                  gapHeight48,
                  Visibility(
                    visible: signUpState
                            .getPepDeclarationModel.getPoliticalRelated &&
                        signUpState.getPepDeclarationModel
                                .getRelationshipWithPep !=
                            null,
                    child: PrimaryButton(
                      key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                      title: 'Continue',
                      onTap: () async {
                        await widget.formKey.currentState!.validate(
                            onSuccess: (formData) async {
                          await validateIsPep(ref, formData);
                        });
                      },
                    ),
                  ),
                  gapHeight24,
                ],
              ),
            )),
      ),
    );
  }

  Future<void> validateNotPep(WidgetRef ref) async {
    final signUpState = ref.watch(signUpProvider);
    ValidationRepository repo = ValidationRepository();

    final req = PepDeclarationVo(
      isPep: signUpState.getPepDeclarationModel.getPoliticalRelated,
      pepDeclarationOptions: null,
    );

    EasyLoadingHelper.show();
    await repo.pepValidation(req).baseThen(context, onResponseSuccess: (resp) {
      ref.read(clientSignUpProvider.notifier).setPepDeclarationVo(
            req,
          );

      Navigator.pushNamed(context, CustomRouter.employmentDetails);
    }, onResponseError: (e, s) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColor.errorRed,
          content: Text('Unable to get recruitment manager list')));
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  Future<void> validateIsPep(WidgetRef ref, formData) async {
    final signUpState = ref.watch(signUpProvider);
    ValidationRepository repo = ValidationRepository();

    final req = PepDeclarationVo(
      isPep: signUpState.getPepDeclarationModel.getPoliticalRelated,
      pepDeclarationOptions:
          signUpState.getPepDeclarationModel.getPoliticalRelated != false
              ? PepDeclarationOptionsVo(
                  relationship: signUpState
                      .getPepDeclarationModel.getRelationshipWithPep!.toKeyword,
                  name: formData[AppFormFieldKey.immediateFamilyNameKey] ??
                      ref
                          .read(clientSignUpProvider)
                          .clientIdentityDetailsRequestVo
                          ?.fullName,
                  position: formData[AppFormFieldKey.designationKey],
                  organization: formData[AppFormFieldKey.organisationKey],
                  supportingDocument:
                      (formData[AppFormFieldKey.proofDocKey] as List<Document>)
                          .first
                          .base64EncodeStr,
                )
              : null,
    );
    EasyLoadingHelper.show();
    await repo.pepValidation(req).baseThen(
      context,
      onResponseSuccess: (resp) {
        ref.read(clientSignUpProvider.notifier).setPepDeclarationVo(
              req,
            );

        Navigator.pushNamed(context, CustomRouter.employmentDetails);
      },
      onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColor.errorRed,
            content: Text('Unable to get recruitment manager list')));
      },
    ).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
