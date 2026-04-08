import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_vo.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_document.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/screen/company/share_holder_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_pep_declaration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShareHolderInfoPage extends StatelessWidget {
  CorporateShareholderVo shareholder;
  final int no;
  bool isEditFromProfile;

  ShareHolderInfoPage(
      {super.key,
      required this.shareholder,
      required this.no,
      this.isEditFromProfile = false});

  @override
  Widget build(BuildContext context) {
    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: CitadelAppBar(
        title: 'Share Holder ${no + 1} Details',
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text('Share Holder Details', style: AppTextStyle.header3),
              const Spacer(),
              AppTextButton(
                title: 'Edit',
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, CustomRouter.shareHolder,
                      arguments: ShareHolderPage(
                        shareholder: shareholder,
                        allowEditPercentage: false,
                      ));
                },
              ),
            ],
          ),
          gapHeight24,
          Text(
            'Share Holder Name',
            style: AppTextStyle.label,
          ),
          gapHeight8,
          Text(
            shareholder.nameDisplay,
            style: AppTextStyle.bodyText,
          ),
          gapHeight16,
          Text(
            'Share Holder Address',
            style: AppTextStyle.label,
          ),
          gapHeight8,
          Text(
            '${shareholder.address}, ${shareholder.postcode}, ${shareholder.city}, ${shareholder.state}, ${shareholder.country}',
            style: AppTextStyle.bodyText,
          ),
          gapHeight16,
          Text(
            'Share Holder Share Percentage',
            style: AppTextStyle.label,
          ),
          gapHeight8,
          Text(
            "${shareholder.percentageOfShareholdings.toString()}%",
            style: AppTextStyle.bodyText,
          ),
          gapHeight16,
          Text(
            'Primary Contact Mobile Number',
            style: AppTextStyle.label,
          ),
          gapHeight8,
          Text(
            '${shareholder.mobileCountryCode} ${shareholder.mobileNumber}',
            style: AppTextStyle.bodyText,
          ),
          gapHeight16,
          Text(
            'Primary Contact Email',
            style: AppTextStyle.label,
          ),
          gapHeight8,
          Text(
            shareholder.emailDisplay,
            style: AppTextStyle.bodyText,
          ),
          gapHeight48,
          Row(
            children: [
              Text('PEP Status', style: AppTextStyle.header3),
              const Spacer(),
              AppTextButton(
                title: 'Edit',
                onTap: () {
                  Navigator.pushNamed(
                      context, CustomRouter.shareHolderPepDeclaration,
                      arguments: ShareHolderPepDeclarationPage(
                        editShareHolder: shareholder,
                      ));
                },
              ),
            ],
          ),
          gapHeight16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInfoText(
                  "PEP",
                  shareholder.pepDeclaration?.isPep == true
                      ? 'Yes - ${shareholder.pepDeclaration?.pepDeclarationOptions?.relationship}'
                      : 'No'),
              if (shareholder.pepDeclaration?.isPep == true) ...[
                if (shareholder
                        .pepDeclaration?.pepDeclarationOptions?.relationship !=
                    'SELF') ...[
                  gapHeight16,
                  AppInfoText(
                      "Name",
                      shareholder.pepDeclaration?.pepDeclarationOptions?.name ??
                          ''),
                ],
                gapHeight16,
                AppInfoText(
                    "Current Position / Designation",
                    shareholder
                            .pepDeclaration?.pepDeclarationOptions?.position ??
                        ''),
                gapHeight16,
                AppInfoText(
                    "Organisation / Entity",
                    shareholder.pepDeclaration?.pepDeclarationOptions
                            ?.organization ??
                        ''),
                if (shareholder.pepDeclaration?.pepDeclarationOptions
                        ?.supportingDocument !=
                    null) ...[
                  gapHeight16,
                  AppInfoDocument("Supporting Document", [
                    NetworkFile(
                        url: shareholder.pepDeclaration?.pepDeclarationOptions
                                ?.supportingDocument ??
                            '')
                  ]),
                ]
              ]
            ],
          )
        ]),
      ),
    );
  }
}
