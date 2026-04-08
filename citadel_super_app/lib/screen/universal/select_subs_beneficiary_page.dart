import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
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
import 'package:citadel_super_app/project_widget/bottom_sheet/beneficiary_distribution_bottom_sheet.dart';
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

class SelectSubsBeneficiaryPage extends StatefulHookConsumerWidget {
  // List<IndividualBeneficiaryVo>? selectedSubBeneficiaries;
  List<FundBeneficiaryDetailsVo>? selectedSubFundBeneficiaries;
  final Function(List<IndividualBeneficiaryVo>)? onConfirm;
  final String? clientId;

  SelectSubsBeneficiaryPage(
      {super.key,
      this.onConfirm,
      this.selectedSubFundBeneficiaries,
      this.clientId});

  @override
  ConsumerState<SelectSubsBeneficiaryPage> createState() {
    return SelectBeneficiaryState();
  }
}

class SelectBeneficiaryState extends ConsumerState<SelectSubsBeneficiaryPage> {
  List<IndividualBeneficiaryVo>? selectedSubBeneficiaries;
  List<IndividualBeneficiaryVo> filteredList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final beneficiaryList = ref.watch(beneficiariesProvider(widget.clientId));
    final selectedBeneficiary = ref.read(beneficiaryDistributionProvider);
    final beneficiary = selectedBeneficiary.beneficiary
        ?.map((e) => e.individualBeneficiaryId ?? 0);
    final beneficiaryDistributionNotifier =
        ref.watch(beneficiaryDistributionProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        if (widget.selectedSubFundBeneficiaries != null) {
          final existingList =
              await ref.watch(beneficiariesProvider(widget.clientId).future);
          appDebugPrint('get the list ${existingList.length}');

          selectedSubBeneficiaries = widget.selectedSubFundBeneficiaries!
              .map((fundBeneficiary) {
                return existingList.firstWhereOrNull(
                  (beneficiary) =>
                      beneficiary.individualBeneficiaryId ==
                      fundBeneficiary.beneficiaryId,
                );
              })
              .whereType<IndividualBeneficiaryVo>()
              .toList();

          appDebugPrint('Done mapping ${selectedSubBeneficiaries?.length}');
        }
      });
      return;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Purchase Trust Product'),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                title: 'Proceed',
                onTap: selectedSubBeneficiaries != null &&
                        selectedSubBeneficiaries!.length <= 2
                    ? () {
                        beneficiaryDistributionNotifier
                            .setSelectedSubBeneficiaries(
                                selectedSubBeneficiaries!);
                        if (widget.onConfirm != null) {
                          showDistributionBottomSheet(
                            getAppContext() ?? context,
                          ).then((beneficiariesList) {
                            setState(() {
                              widget.onConfirm!(selectedSubBeneficiaries!);
                            });
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      }
                    : null,
              ),
              gapHeight16,
              SecondaryButton(
                title: 'Skip',
                onTap: () {
                  if (widget.onConfirm != null) {
                    setState(() {
                      widget.onConfirm!([]);
                    });
                  } else {
                    Navigator.pop(context);
                  }
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
                'Add a Substitute Beneficiary',
                style: AppTextStyle.header1,
              ),
              gapHeight16,
              Text(
                'You can add a substitute beneficiary if you have 1 main beneficiary.',
                style: AppTextStyle.description,
              ),
              gapHeight32,
              ...beneficiaryList.maybeWhen(
                  data: (data) {
                    filteredList = List.from(data);
                    filteredList.removeWhere((e) =>
                        beneficiary!.contains(e.individualBeneficiaryId));
                    return [
                      MultipleOptionTileSelection(
                        items: [
                          ...List.generate(
                              filteredList.length,
                              (index) => ListTileSelection(
                                    text: filteredList[index]
                                        .fullName
                                        .defaultDisplay,
                                    description:
                                        '${getValueForKey(filteredList[index].relationshipToSettlor.defaultDisplay, ref)}${filteredList[index].guardian != null ? '\nGuardian: ${filteredList[index].guardian.nameDisplay} ' : ''}',
                                  ))
                        ],
                        onSelected: (selectedIndexes) {
                          setState(() {
                            selectedSubBeneficiaries =
                                selectedIndexes.map((index) {
                              return filteredList[index];
                            }).toList();
                          });
                        },
                      ),
                      gapHeight32,
                      Visibility(
                        visible: data.length < 5,
                        child: SecondaryButton(
                          height: 32.h,
                          onTap: () {
                            Navigator.pushNamed(context, CustomRouter.document,
                                arguments: DocumentPage(
                                  title: 'Scan Beneficiary ID',
                                  onConfirm: () {
                                    Navigator.pushReplacementNamed(context,
                                        CustomRouter.addEditBeneficiary,
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
                    ];
                  },
                  orElse: () =>
                      [const Center(child: CircularProgressIndicator())]),
              gapHeight100,
            ],
          ),
        ));
  }
}
