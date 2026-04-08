import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/state/update_state.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
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

class AddEditPepPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final ClientProfileResponseVo? user;

  AddEditPepPage({super.key, required this.user});

  @override
  PepDeclarationPageState createState() => PepDeclarationPageState();
}

class PepDeclarationPageState extends ConsumerState<AddEditPepPage> {
  late final TextEditingController nameController;
  late final TextEditingController positionController;
  late final TextEditingController organisationController;

  @override
  void initState() {
    nameController = TextEditingController(
        text: widget.user?.pepDeclaration?.pepDeclarationOptions?.name ?? '');
    positionController = TextEditingController(
        text:
            widget.user?.pepDeclaration?.pepDeclarationOptions?.position ?? '');
    organisationController = TextEditingController(
        text:
            widget.user?.pepDeclaration?.pepDeclarationOptions?.organization ??
                '');
    super.initState();
  }

  String getPepRelationship() {
    final relationship =
        widget.user?.pepDeclaration?.pepDeclarationOptions?.relationship;

    switch (relationship) {
      case 'SELF':
        return 'Self';
      case 'FAMILY':
        return 'Immediate Family Member';
      case 'ASSOCIATE':
        return 'Close Associate';
      default:
        return '';
    }
  }

  int? getPepRelationshipIndex(RelationshipWithPep? relationship) {
    switch (relationship) {
      case RelationshipWithPep.self:
        return 0;
      case RelationshipWithPep.familyMember:
        return 1;
      case RelationshipWithPep.closeAssociate:
        return 2;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pepState = ref.watch(updateProvider);
    final pepNotifier = ref.watch(updateProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pepNotifier.setPEPDeclarationPoliticalRelated(
            widget.user?.pepDeclaration?.isPep ?? false);

        switch (getPepRelationship()) {
          case 'Self':
            pepNotifier.setPepDeclarationRelationship(RelationshipWithPep.self);
            break;
          case 'Immediate Family Member':
            pepNotifier.setPepDeclarationRelationship(
                RelationshipWithPep.familyMember);
            break;
          case 'Close Associate':
            pepNotifier.setPepDeclarationRelationship(
                RelationshipWithPep.closeAssociate);
            break;
        }

        widget.formKey.currentState?.validateFormButton();
      });
      return null;
    }, []);

    return AppForm(
      key: widget.formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.pureBlack,
          appBar: const CitadelAppBar(title: 'Declaration of PEP'),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you a politically exposed person? (PEP)',
                  style: AppTextStyle.header1,
                ),
                gapHeight16,
                Text(
                  'A senior military, government or political official of any country? A senior executive of a state-owned corporation, or an immediate family member or close associate of such a person?',
                  style: AppTextStyle.bodyText,
                ),
                gapHeight32,
                DualHorizontalTileSelection(
                  items: const ['Yes', 'No'],
                  initialSelectedIndex:
                      (pepState.politicalRelated ?? false) ? 0 : 1,
                  onSelected: (index) {
                    final isPep = index == 0;
                    pepNotifier.setPEPDeclarationPoliticalRelated(isPep);
                    if (!isPep) {
                      pepNotifier.setPepDeclarationRelationship(
                          RelationshipWithPep.self);
                      nameController.clear();
                      positionController.clear();
                      organisationController.clear();
                    }
                  },
                ),
                gapHeight32,
                if (pepState.politicalRelated ?? false)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select the option below',
                          style: AppTextStyle.header3),
                      gapHeight16,
                      AppListTileSelection(
                        items: getPepRelationshipList,
                        initialSelectedIndex: getPepRelationshipIndex(
                            pepState.relationshipWithPep),
                        onSelected: (index) {
                          switch (index) {
                            case 0:
                              pepNotifier.setPepDeclarationRelationship(
                                  RelationshipWithPep.self);
                              nameController.clear();
                              break;
                            case 1:
                              pepNotifier.setPepDeclarationRelationship(
                                  RelationshipWithPep.familyMember);
                              break;
                            case 2:
                              pepNotifier.setPepDeclarationRelationship(
                                  RelationshipWithPep.closeAssociate);
                              break;
                          }
                        },
                      ),
                      gapHeight16,
                      if (pepState.relationshipWithPep != null &&
                          pepState.relationshipWithPep !=
                              RelationshipWithPep.self)
                        AppTextFormField(
                          key: const Key('name'),
                          formKey: widget.formKey,
                          label:
                              'Full Name of ${pepState.relationshipWithPep == RelationshipWithPep.familyMember ? 'Immediate Family' : 'Close Associate'}',
                          controller: nameController,
                          fieldKey: AppFormFieldKey.immediateFamilyNameKey,
                        ),
                      AppTextFormField(
                        key: const Key('current position'),
                        formKey: widget.formKey,
                        label: 'Current Position / Designation',
                        controller: positionController,
                        fieldKey: AppFormFieldKey.designationKey,
                      ),
                      AppTextFormField(
                        key: const Key('Organisation'),
                        formKey: widget.formKey,
                        label: 'Organisation / Entity',
                        controller: organisationController,
                        fieldKey: AppFormFieldKey.organisationKey,
                      ),
                      gapHeight12,
                      AppUploadDocumentWidget(
                        formKey: widget.formKey,
                        fieldKey: AppFormFieldKey.proofDocKey,
                        initialFiles: widget
                                    .user
                                    ?.pepDeclaration
                                    ?.pepDeclarationOptions
                                    ?.supportingDocument !=
                                null
                            ? [
                                NetworkFile(
                                    url: widget
                                        .user!
                                        .pepDeclaration!
                                        .pepDeclarationOptions!
                                        .supportingDocument!)
                              ]
                            : [],
                        label: 'Supporting Document',
                      )
                    ],
                  ),
                gapHeight48,
                PrimaryButton(
                    key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                    title: 'Continue',
                    onTap: () async {
                      await update(context, ref);
                    }),
                gapHeight24,
              ],
            ),
          )),
    );
  }

  Future<void> update(BuildContext context, WidgetRef ref) async {
    await widget.formKey.currentState!.validate(onSuccess: (formData) async {
      final isPep = ref.read(updateProvider).politicalRelated;
      final relationship =
          ref.read(updateProvider).relationshipWithPep?.toKeyword;
      final req = ParameterHelper()
          .editPepParam(widget.user!, formData, isPep, relationship);
      final clientRepository = ClientRepository();

      EasyLoadingHelper.show();
      await clientRepository.editClientPep(req).baseThen(
        context,
        onResponseSuccess: (_) {
          final latestContext = (getAppContext() ?? context);
          latestContext.showSuccessSnackBar('Successfully Updated');
          ref.invalidate(profileProvider);
          Navigator.pop(latestContext);
        },
        onResponseError: (e, s) {
          if (e.message.contains('validation')) {
            FormValidationHelper()
                .resolveValidationError(widget.formKey, e.message);
          } else {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
                SnackBar(
                    backgroundColor: AppColor.errorRed,
                    content: Text(e.message)));
          }
        },
      ).whenComplete(() => EasyLoadingHelper.dismiss());
    });
  }
}
