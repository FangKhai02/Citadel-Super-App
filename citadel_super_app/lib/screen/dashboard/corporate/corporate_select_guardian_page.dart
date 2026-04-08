import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_guardian_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateSelectGuardianPage extends StatefulHookConsumerWidget {
  final int beneficiaryId;
  final String? corporateClientId;

  const CorporateSelectGuardianPage(
      {super.key, required this.beneficiaryId, this.corporateClientId});

  @override
  ConsumerState<CorporateSelectGuardianPage> createState() {
    return CorporateSelectGuardianState();
  }
}

class CorporateSelectGuardianState
    extends ConsumerState<CorporateSelectGuardianPage> {
  String getDescription(CorporateBeneficiaryBaseVo beneficiary) {
    String desc = '';
    desc += beneficiary.relationshipToSettlor.defaultDisplay;

    return desc;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final beneficiaryList =
        ref.watch(corporateBeneficiaryProvider(widget.corporateClientId));

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: CitadelAppBar(
          title: "Beneficiary",
          onTap: () {
            Navigator.popUntil(context, (routes) {
              if ([
                CustomRouter.corporateProfile,
                CustomRouter.selectCorporateBeneficiary,
              ].contains(routes.settings.name)) {
                return true;
              }
              return false;
            });
          },
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
              title: 'Add New',
              onTap: () {
                Navigator.pushNamed(context, CustomRouter.document,
                    arguments: DocumentPage(
                      onConfirm: () {
                        Navigator.pushReplacementNamed(
                          context,
                          CustomRouter.corporateAddEditGuardian,
                          arguments: CorporateAddEditGuardianPage(
                            beneficiaryID: widget.beneficiaryId,
                            corporateClientId: widget.corporateClientId,
                          ),
                        );
                      },
                      title: 'Scan Guardian ID',
                    ));
              }),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select guardian from existing beneficiaries',
                style: AppTextStyle.header1,
              ),
              gapHeight16,
              ...beneficiaryList.maybeWhen(
                data: (data) {
                  final filteredList = [...data];
                  filteredList.removeWhere(
                      (e) => e.corporateBeneficiaryId == widget.beneficiaryId);
                  filteredList.removeWhere((e) => e.isUnderAge ?? true);

                  return [
                    Text(
                      '${filteredList.length} beneficiaries available.',
                      style: AppTextStyle.description,
                    ),
                    gapHeight32,
                    AppListTileSelection(
                      items: [
                        ...filteredList.map((e) => ListTileSelection(
                            text: e.fullName.defaultDisplay,
                            description: getDescription(e))),
                      ],
                      initialSelectedIndex: null,
                      onSelected: (index) {
                        EasyLoadingHelper.show();
                        CorporateRepository corporateRepository =
                            CorporateRepository();

                        corporateRepository
                            .getCorporateBeneficiaryById(
                                filteredList[index!].corporateBeneficiaryId,
                                corporateClientId: widget.corporateClientId)
                            .baseThen(context, onResponseSuccess: (data) {
                          Navigator.pushNamed(
                              context, CustomRouter.corporateAddEditGuardian,
                              arguments: CorporateAddEditGuardianPage(
                                beneficiaryDetail: data,
                                beneficiaryID: widget.beneficiaryId,
                                corporateClientId: widget.corporateClientId,
                              ));
                        }).whenComplete(() => EasyLoadingHelper.dismiss());
                      },
                    ),
                  ];
                },
                orElse: () =>
                    [const Center(child: CircularProgressIndicator())],
              ),
              gapHeight32,
            ],
          ),
        ));
  }

  void onCreate() {}
}
