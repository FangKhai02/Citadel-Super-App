import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/sign_up/pep_declaration.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/corporate_shareholder_state.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_vo.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/project_widget/selection/dual_horizontal_tile_selection.dart';
import 'package:citadel_super_app/screen/sign_up/component/pep_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShareHolderPepDeclarationPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  final CorporateShareholderVo? editShareHolder;
  final bool addNewShareholderForCorporate;

  ShareHolderPepDeclarationPage(
      {super.key,
      this.editShareHolder,
      this.addNewShareholderForCorporate = false});

  @override
  ShareHolderPepDeclarationPageState createState() =>
      ShareHolderPepDeclarationPageState();
}

class ShareHolderPepDeclarationPageState
    extends ConsumerState<ShareHolderPepDeclarationPage> {
  @override
  Widget build(BuildContext context) {
    final shareholder = ref.watch(corporateShareholderProvider);
    final shareholderNotifier =
        ref.watch(corporateShareholderProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.editShareHolder != null) {}
        shareholderNotifier.setCorporateShareholderPep(
            widget.editShareHolder!.pepDeclaration!);
        widget.formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState?.validateFormButton();
      });
      return null;
    }, [shareholder.pepDeclaration]);

    return AppForm(
      key: widget.formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.pureBlack,
          appBar: const CitadelAppBar(title: 'Declaration of PEP'),
          bottomNavigationBar: shareholder.pepDeclaration?.isPep != null &&
                  shareholder.pepDeclaration?.isPep == false
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w)
                      .copyWith(bottom: 16.h),
                  child: PrimaryButton(
                    key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                    title: 'Continue',
                    onTap: () async => widget.editShareHolder != null
                        ? await editNotPep(context)
                        : await createNotPep(context),
                  ),
                )
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Is your share holder a politically exposed person? (PEP)',
                  style: AppTextStyle.header1,
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
                  onSelected: (index) {
                    shareholderNotifier
                        .setPEPDeclarationPoliticalRelated(index == 0);
                  },
                  initialSelectedIndex: widget.editShareHolder != null
                      ? widget.editShareHolder?.pepDeclaration?.isPep == true
                          ? 0
                          : 1
                      : null,
                ),
                gapHeight32,
                Visibility(
                    visible: (shareholder.pepDeclaration?.isPep != null &&
                        shareholder.pepDeclaration?.isPep == true),
                    child: Column(
                      children: [
                        Text(
                          'Select the option below',
                          style: AppTextStyle.header3,
                        ),
                        gapHeight16,
                        AppListTileSelection(
                            items: [
                              ListTileSelection(
                                text: 'Self',
                              ),
                              ListTileSelection(
                                text: 'Immediate Family Member',
                              ),
                              ListTileSelection(
                                text: 'Close Associate',
                              ),
                            ],
                            onSelected: (index) {
                              switch (index) {
                                case 0:
                                  shareholderNotifier
                                      .setPepDeclarationRelationship(
                                          RelationshipWithPep.self);
                                  break;
                                case 1:
                                  shareholderNotifier
                                      .setPepDeclarationRelationship(
                                          RelationshipWithPep.familyMember);
                                  break;
                                case 2:
                                  shareholderNotifier
                                      .setPepDeclarationRelationship(
                                          RelationshipWithPep.closeAssociate);
                                  break;
                              }
                            },
                            initialSelectedIndex: shareholder.pepDeclaration
                                        ?.pepDeclarationOptions?.relationship ==
                                    'SELF'
                                ? 0
                                : shareholder
                                            .pepDeclaration
                                            ?.pepDeclarationOptions
                                            ?.relationship ==
                                        'FAMILY'
                                    ? 1
                                    : shareholder
                                                .pepDeclaration
                                                ?.pepDeclarationOptions
                                                ?.relationship ==
                                            'ASSOCIATE'
                                        ? 2
                                        : null)
                      ],
                    )),
                Visibility(
                    visible: shareholder.pepDeclaration?.pepDeclarationOptions
                                ?.relationship !=
                            null &&
                        shareholder.pepDeclaration?.isPep == true,
                    child: PepDetailsWidget(
                      pepDetail:
                          shareholder.pepDeclaration?.pepDeclarationOptions,
                      formKey: widget.formKey,
                      relationship: shareholder.pepDeclaration
                              ?.pepDeclarationOptions?.relationship ??
                          '',
                    )),
                gapHeight48,
                Visibility(
                  visible: shareholder.pepDeclaration?.isPep != null &&
                      shareholder.pepDeclaration?.isPep == true &&
                      shareholder.pepDeclaration?.pepDeclarationOptions
                              ?.relationship !=
                          null &&
                      shareholder.pepDeclaration?.isPep == true,
                  child: PrimaryButton(
                    key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                    title: 'Continue',
                    onTap: () async => widget.editShareHolder != null
                        ? await editPep(context)
                        : await createIsPep(context),
                  ),
                ),
                gapHeight24,
              ],
            ),
          )),
    );
  }

  Future<void> editNotPep(BuildContext context) async {
    ValidationRepository repo = ValidationRepository();

    final shareholder = ref.watch(corporateShareholderProvider);
    EasyLoadingHelper.show();
    await repo.pepValidation(shareholder.pepDeclaration!).baseThen(context,
        onResponseSuccess: (resp) async {
      CorporateRepository repo = CorporateRepository();

      final referenceNumber = ref.read(corporateRefProvider);
      await repo
          .editCorporateShareholderPep(shareholder.pepDeclaration!,
              widget.editShareHolder?.id, referenceNumber ?? '')
          .baseThen(context, onResponseSuccess: (resp) {
        ref.invalidate(corporateShareholderProvider);

        Navigator.popUntil(context, (routes) {
          if ([
            CustomRouter.corporateProfile,
            CustomRouter.shareHolderDetails,
          ].contains(routes.settings.name)) {
            return true;
          }
          return false;
        });
      }, onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper()
              .resolveValidationError(widget.formKey, e.message);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColor.errorRed, content: Text(e.message)));
        }
      });
    }, onResponseError: (e, s) {
      if (e.message.contains('validation')) {
        FormValidationHelper()
            .resolveValidationError(widget.formKey, e.message);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      }
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  Future<void> editPep(BuildContext context) async {
    await widget.formKey.currentState!.validate(onSuccess: (formData) async {
      FocusScope.of(context).unfocus();
      final shareholderNotifier =
          ref.watch(corporateShareholderProvider.notifier);

      final pep = shareholderNotifier.setPepDeclarationDetails(
          formData, widget.editShareHolder?.name);

      CorporateRepository corporateRepository = CorporateRepository();
      ValidationRepository repo = ValidationRepository();
      final referenceNumber = ref.read(corporateRefProvider);
      EasyLoadingHelper.show();
      await repo.pepValidation(pep!).baseThen(context,
          onResponseSuccess: (_) async {
        await corporateRepository
            .editCorporateShareholderPep(
                pep, widget.editShareHolder?.id, referenceNumber ?? '')
            .baseThen(context, onResponseSuccess: (resp) {
          ref.invalidate(corporateShareholderProvider);

          Navigator.popUntil(context, (routes) {
            if ([
              CustomRouter.corporateProfile,
              CustomRouter.shareHolderDetails,
            ].contains(routes.settings.name)) {
              return true;
            }
            return false;
          });
        }, onResponseError: (e, s) {
          if (e.message.contains('validation')) {
            FormValidationHelper()
                .resolveValidationError(widget.formKey, e.message);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.errorRed, content: Text(e.message)));
          }
        });
      }, onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper()
              .resolveValidationError(widget.formKey, e.message);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColor.errorRed, content: Text(e.message)));
        }
      }).whenComplete(() => EasyLoadingHelper.dismiss());
    });
  }

  Future<void> createNotPep(BuildContext context) async {
    ValidationRepository repo = ValidationRepository();

    final shareholder = ref.watch(corporateShareholderProvider);
    final corporateRef = ref.watch(corporateRefProvider);

    EasyLoadingHelper.show();
    await repo.pepValidation(shareholder.pepDeclaration!).baseThen(context,
        onResponseSuccess: (resp) async {
      CorporateRepository repo = CorporateRepository();

      await repo.createShareholder(shareholder, corporateRef!).baseThen(context,
          onResponseSuccess: (resp) {
        ref.invalidate(corporateShareholderProvider);
        ref.invalidate(shareholdersProvider);

        Navigator.popUntil(context, (routes) {
          if ([
            CustomRouter.corporateProfile,
            CustomRouter.shareHolderDetails,
          ].contains(routes.settings.name)) {
            return true;
          }
          return false;
        });
      }, onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper()
              .resolveValidationError(widget.formKey, e.message);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColor.errorRed, content: Text(e.message)));
        }
      });
    }, onResponseError: (e, s) {
      if (e.message.contains('validation')) {
        FormValidationHelper()
            .resolveValidationError(widget.formKey, e.message);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      }
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  Future<void> createIsPep(BuildContext context) async {
    await widget.formKey.currentState!.validate(
      onSuccess: (formData) async {
        ValidationRepository repo = ValidationRepository();

        final shareholder = ref.read(corporateShareholderProvider);
        final corporateRef = ref.read(corporateRefProvider);
        final shareholderNotifier =
            ref.watch(corporateShareholderProvider.notifier);

        if (shareholder.pepDeclaration?.pepDeclarationOptions?.relationship ==
            null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColor.errorRed,
              content: Text('Please select the relationship'),
            ),
          );
          return;
        }

        final pep =
            shareholderNotifier.setPepDeclarationDetails(formData, null);
        EasyLoadingHelper.show();
        await repo.pepValidation(pep!).baseThen(context,
            onResponseSuccess: (resp) async {
          CorporateRepository repo = CorporateRepository();

          final result = ref.read(corporateShareholderProvider);

          await repo.createShareholder(result, corporateRef!).baseThen(context,
              onResponseSuccess: (resp) {
            ref.invalidate(corporateShareholderProvider);
            ref.invalidate(shareholdersProvider);

            Navigator.popUntil(context, (routes) {
              if ([
                CustomRouter.shareHolderDetails,
              ].contains(routes.settings.name)) {
                return true;
              }
              return false;
            });
          }, onResponseError: (e, s) {
            if (e.message.contains('validation')) {
              FormValidationHelper()
                  .resolveValidationError(widget.formKey, e.message);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColor.errorRed,
                  content: Text(e.message)));
            }
          });
        }, onResponseError: (e, s) {
          if (e.message.contains('validation')) {
            FormValidationHelper()
                .resolveValidationError(widget.formKey, e.message);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.errorRed, content: Text(e.message)));

            return;
          }
        }).whenComplete(() => EasyLoadingHelper.dismiss());
      },
    );
  }
}
