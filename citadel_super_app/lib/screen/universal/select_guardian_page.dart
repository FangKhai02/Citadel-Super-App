import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_guardian_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectGuardianPage extends StatefulHookConsumerWidget {
  final int beneficiaryId;
  final bool fromProfile;
  final String? clientId;

  const SelectGuardianPage(
      {super.key,
      required this.beneficiaryId,
      this.fromProfile = false,
      this.clientId});

  @override
  ConsumerState<SelectGuardianPage> createState() {
    return SelectGuardianState();
  }
}

class SelectGuardianState extends ConsumerState<SelectGuardianPage> {
  String getDescription(IndividualBeneficiaryVo beneficiary) {
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
    final beneficiaryList = ref.watch(beneficiariesProvider(widget.clientId));

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: CitadelAppBar(
            title:
                widget.fromProfile == true ? "Beneficiary" : 'Purchase Fund'),
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
                          CustomRouter.addEditGuardian,
                          arguments: AddEditGuardianPage(
                            beneficiaryID: widget.beneficiaryId,
                            clientId: widget.clientId,
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
                      (e) => e.individualBeneficiaryId == widget.beneficiaryId);
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
                        Navigator.pushNamed(
                            context, CustomRouter.addEditGuardian,
                            arguments: AddEditGuardianPage(
                              beneficiaryID: widget.beneficiaryId,
                              beneficiaryDetail: filteredList[index!],
                              clientId: widget.clientId,
                            ));
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
}
