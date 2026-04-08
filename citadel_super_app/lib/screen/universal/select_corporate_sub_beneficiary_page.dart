import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/beneficiary_distribution_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';
import 'package:citadel_super_app/data/vo/fund_beneficiary_details_vo.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/corporate_beneficiary_distribution_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/project_widget/selection/multiple_option_tile_selection.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectCorporateSubsBeneficiaryPage extends StatefulHookConsumerWidget {
  List<FundBeneficiaryDetailsVo>? selectedSubFundBeneficiaries;
  final Function(List<CorporateBeneficiaryBaseVo>)? onConfirm;
  final String? corporateClientId;

  SelectCorporateSubsBeneficiaryPage({
    super.key,
    this.onConfirm,
    this.corporateClientId,
    this.selectedSubFundBeneficiaries,
  });

  @override
  ConsumerState<SelectCorporateSubsBeneficiaryPage> createState() {
    return SelectBeneficiaryState();
  }
}

class SelectBeneficiaryState
    extends ConsumerState<SelectCorporateSubsBeneficiaryPage> {
  List<CorporateBeneficiaryBaseVo>? selectedSubBeneficiaries;
  List<CorporateBeneficiaryBaseVo> filteredList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final corporateBeneficiaryList =
        ref.watch(corporateBeneficiaryProvider(widget.corporateClientId));
    final selectedBeneficiary =
        ref.read(corporateBeneficiaryDistributionProvider);
    final beneficiary = selectedBeneficiary.beneficiary
        ?.map((e) => e.corporateBeneficiaryId ?? 0);
    final corporateBeneficiaryDistributionNotifier =
        ref.watch(corporateBeneficiaryDistributionProvider.notifier);

    useEffect(() {
      Future.microtask(() async {
        if (widget.selectedSubFundBeneficiaries != null) {
          final existingList = await ref
              .watch(beneficiariesProvider(widget.corporateClientId).future);
          appDebugPrint('get the list ${existingList.length}');

          selectedSubBeneficiaries = widget.selectedSubFundBeneficiaries!
              .map((fundBeneficiary) {
                return existingList.firstWhereOrNull(
                  (beneficiary) =>
                      beneficiary.individualBeneficiaryId ==
                      fundBeneficiary.beneficiaryId,
                );
              })
              .whereType<CorporateBeneficiaryBaseVo>()
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
                        corporateBeneficiaryDistributionNotifier
                            .setSelectedSubBeneficiaries(
                                selectedSubBeneficiaries!);

                        if (widget.onConfirm != null) {
                          showCorporateDistributionBottomSheet(
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
                'Add substitute beneficiary',
                style: AppTextStyle.header1,
              ),
              gapHeight16,
              Text(
                'You can add a substitute beneficiary if you have 1 main beneficiary.',
                style: AppTextStyle.description,
              ),
              gapHeight32,
              ...corporateBeneficiaryList.maybeWhen(
                  data: (data) {
                    filteredList = List.from(data);
                    filteredList.removeWhere(
                        (e) => beneficiary!.contains(e.corporateBeneficiaryId));
                    // final filteredList = data;
                    // filteredList.removeWhere(
                    //     (e) => beneficiary!.contains(e.corporateBeneficiaryId));
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
                                        '${filteredList[index].relationshipToSettlor.defaultDisplay}${filteredList[index].corporateGuardianVo != null ? '\nGuardian: ${filteredList[index].corporateGuardianVo.nameDisplay} ' : ''}',
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
                                    Navigator.pushReplacementNamed(
                                        context,
                                        CustomRouter
                                            .corporateAddEditBeneficiary,
                                        arguments:
                                            CorporateAddEditBeneficiaryPage(
                                          corporateClientId:
                                              widget.corporateClientId,
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
