import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_guardian_vo.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_guardian_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateBeneficiaryDetailPage extends HookConsumerWidget {
  final CorporateBeneficiaryVo beneficiary;
  final CorporateGuardianVo? guardian;
  final String? relationship;

  const CorporateBeneficiaryDetailPage({
    super.key,
    required this.beneficiary,
    this.guardian,
    this.relationship,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
      appBar: const CitadelAppBar(
        title: 'Beneficiary Details',
      ),
      backgroundType: BackgroundType.darkToBright2,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Beneficiary',
                      style: AppTextStyle.header3,
                    ),
                    const Spacer(),
                    AppTextButton(
                      title: 'Edit',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, CustomRouter.corporateAddEditBeneficiary,
                            arguments: CorporateAddEditBeneficiaryPage(
                              beneficiaryDetail: beneficiary,
                            ));
                      },
                    ),
                  ],
                ),
                gapHeight24,
                AppInfoText("Full Name (same as User ID)",
                    beneficiary.fullName.defaultDisplay),
                gapHeight16,
                AppInfoText(
                    "Relationship to Settlor",
                    getValueForKey(
                        beneficiary.relationshipToSettlor.defaultDisplay, ref)),
                gapHeight16,
                AppInfoText(
                    "User ID", beneficiary.identityCardNumber.defaultDisplay),
                gapHeight16,
                AppInfoText("Date of Birth", beneficiary.dob.toDDMMYYY),
                gapHeight16,
                AppInfoText("Gender",
                    getValueForKey(beneficiary.gender.defaultDisplay, ref)),
                gapHeight16,
                AppInfoText(
                    "Nationality", beneficiary.nationality.defaultDisplay),
                gapHeight16,
                AppInfoText("Address",
                    '${beneficiary.address}, ${beneficiary.postcode}, ${beneficiary.city}, ${beneficiary.state}, ${beneficiary.country}'),
                gapHeight16,
                AppInfoText(
                    "Residential Status",
                    getValueForKey(
                        beneficiary.residentialStatus.defaultDisplay, ref)),
                gapHeight16,
                AppInfoText(
                    "Marital Status",
                    getValueForKey(
                        beneficiary.maritalStatus.defaultDisplay, ref)),
                gapHeight16,
                AppInfoText("Mobile Number",
                    '${beneficiary.mobileCountryCode.defaultDisplay} ${beneficiary.mobileNumber.defaultDisplay}'),
                gapHeight16,
                AppInfoText("Email", beneficiary.email.defaultDisplay),
                gapHeight48,
                if (guardian != null) ...[
                  Row(
                    children: [
                      Text(
                        'Guardian',
                        style: AppTextStyle.header3,
                      ),
                      const Spacer(),
                      AppTextButton(
                        title: 'Edit',
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, CustomRouter.corporateAddEditGuardian,
                              arguments: CorporateAddEditGuardianPage(
                                  currentGuardian: guardian,
                                  beneficiaryID:
                                      beneficiary.corporateBeneficiaryId,
                                  relationshipToBen: getValueForKey(
                                      beneficiary.relationshipToGuardian ?? '',
                                      ref)));
                        },
                      ),
                    ],
                  ),
                  gapHeight24,
                  AppInfoText(
                      "Relationship to Beneficiary",
                      getValueForKey(
                          beneficiary.relationshipToGuardian ?? '', ref)),
                  gapHeight16,
                  AppInfoText(
                      "Full Name (same as User ID)", guardian.nameDisplay),
                  gapHeight16,
                  AppInfoText("${guardian?.identityDocumentType} Number",
                      guardian.identityCardNumberDisplay),
                  gapHeight16,
                  AppInfoText("Date of Birth", guardian.dobDisplay),
                  gapHeight16,
                  AppInfoText(
                      "Gender", getValueForKey(guardian.genderDisplay, ref)),
                  gapHeight16,
                  AppInfoText("Nationality", guardian.nationalityDisplay),
                  gapHeight16,
                  AppInfoText("Address", guardian.fullAddressDisplay),
                  gapHeight16,
                  AppInfoText("Residential Status",
                      getValueForKey(guardian.residentialStatusDisplay, ref)),
                  gapHeight16,
                  AppInfoText("Marital Status",
                      getValueForKey(guardian.maritalStatusDisplay, ref)),
                  gapHeight16,
                  AppInfoText("Mobile Number", guardian.fullMobileDisplay),
                  gapHeight16,
                  AppInfoText("Email", guardian.emailDisplay),
                  gapHeight64,
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
