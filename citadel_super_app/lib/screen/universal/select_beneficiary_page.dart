import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/beneficiary_distribution_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/fund_beneficiary_details_vo.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/project_widget/selection/multiple_option_tile_selection.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectBeneficiaryPage extends StatefulHookConsumerWidget {
  final Function? onConfirm;
  final Function? onSaveDraft;
  final String? clientId;

  List<FundBeneficiaryDetailsVo>? fundBeneficiaries;
  final bool showSaveDraft;

  SelectBeneficiaryPage(
      {super.key,
      this.onConfirm,
      this.onSaveDraft,
      this.fundBeneficiaries,
      this.showSaveDraft = true,
      this.clientId});

  @override
  ConsumerState<SelectBeneficiaryPage> createState() {
    return SelectBeneficiaryState();
  }
}

class SelectBeneficiaryState extends ConsumerState<SelectBeneficiaryPage> {
  List<IndividualBeneficiaryVo>? selectedBeneficiaries;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final beneficiariesList = ref.watch(beneficiariesProvider(widget.clientId));
    final beneficiaryDistributionNotifier =
        ref.watch(beneficiaryDistributionProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        if (widget.fundBeneficiaries != null) {
          final existingList =
              await ref.watch(beneficiariesProvider(widget.clientId).future);
          appDebugPrint('get the list ${existingList.length}');

          selectedBeneficiaries = widget.fundBeneficiaries!
              .map((fundBeneficiary) {
                return existingList.firstWhereOrNull(
                  (beneficiary) =>
                      beneficiary.individualBeneficiaryId ==
                      fundBeneficiary.beneficiaryId,
                );
              })
              .whereType<IndividualBeneficiaryVo>()
              .toList();

          appDebugPrint('Done mapping ${selectedBeneficiaries?.length}');
        }
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Purchase Trust Product'),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              title: 'Proceed',
              onTap: ((selectedBeneficiaries ?? []).isNotEmpty)
                  ? () {
                      beneficiaryDistributionNotifier
                          .setSelectedBeneficiaries(selectedBeneficiaries!);

                      if (widget.onConfirm != null) {
                        setState(() {
                          widget.onConfirm!();
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  : null,
            ),
            gapHeight16,
            SecondaryButton(
              title: 'Save draft & add later',
              onTap: () {
                beneficiaryDistributionNotifier.setSelectedBeneficiaries([]);

                setState(() {
                  if (widget.onSaveDraft != null) {
                    setState(() {
                      widget.onSaveDraft!();
                    });
                  } else {
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add beneficiaries for this trust product',
              style: AppTextStyle.header1,
            ),
            gapHeight16,
            ...beneficiariesList.maybeWhen(
                data: (beneficiaryList) {
                  return [
                    Text(
                      '${beneficiaryList.length} beneficiaries available.',
                      style: AppTextStyle.description,
                    ),
                    gapHeight32,
                    MultipleOptionTileSelection(
                      items: beneficiaryList.map((e) {
                        return ListTileSelection(
                          text: e.fullName ?? '',
                          description:
                              '${getValueForKey(e.relationshipToSettlor ?? '', ref)}${e.guardian != null ? '\nGuardian: ${e.guardian.nameDisplay} ' : ''}',
                        );
                      }).toList(),
                      initialSelectedIndexes: (selectedBeneficiaries ?? [])
                          .map((element) => beneficiaryList.indexOf(element))
                          .where((index) => index >= 0)
                          .toList(),
                      onSelected: (selectedIndexes) {
                        setState(() {
                          selectedBeneficiaries = selectedIndexes.map((index) {
                            return beneficiaryList[index];
                          }).toList();
                        });
                      },
                    ),
                    gapHeight32,
                    Visibility(
                      visible: beneficiaryList.length < 5,
                      child: SecondaryButton(
                        height: 32.h,
                        onTap: () {
                          Navigator.pushNamed(context, CustomRouter.document,
                              arguments: DocumentPage(
                                title: 'Scan Beneficiary ID',
                                onConfirm: () {
                                  Navigator.pushReplacementNamed(
                                      context, CustomRouter.addEditBeneficiary,
                                      arguments: AddEditBeneficiaryPage(
                                        clientId: widget.clientId,
                                      ));
                                },
                              ));
                        },
                        title: 'Add',
                        icon: Image.asset(
                          Assets.images.icons.plus.path,
                          width: 16.w,
                        ),
                      ),
                    ),
                    gapHeight100,
                  ];
                },
                orElse: () =>
                    [const Center(child: CircularProgressIndicator())]),
            gapHeight32,
          ],
        ),
      ),
    );
  }
}
