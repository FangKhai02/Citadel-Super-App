import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/vo/agent_earning_vo.dart';
import 'package:citadel_super_app/extension/agent_product_order_comission_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningDetailsPage extends HookWidget {
  final AgentEarningVo earning;

  const EarningDetailsPage({super.key, required this.earning});

  @override
  Widget build(BuildContext context) {
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CitadelAppBar(
              title: 'Earning Details',
            ),
            gapHeight16,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(earning.earningTypeDisplay, style: AppTextStyle.header2),
                  gapHeight16,
                  Text(
                    earning.comissionAmountDisplay,
                    style: AppTextStyle.bigNumber.copyWith(
                      color: earning.getTransactionColor,
                    ),
                  ),
                  gapHeight48,
                  AppInfoContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInfoText(
                          'Trust Product Name', earning.productNameDisplay),
                      gapHeight24,
                      AppInfoText(
                          'Agreement Number', earning.agreementNameDisplay),
                      gapHeight24,
                      AppInfoText(
                          'Transaction Date', earning.transactionDateDisplay),
                      gapHeight24,
                      AppInfoText('Bank Name', earning.bankNameDisplay),
                      gapHeight24,
                      AppInfoText(
                          'Transaction ID', earning.transactionIdDisplay),
                      gapHeight24,
                      AppInfoText('Status', earning.statusDisplay),
                    ],
                  )),
                ],
              ),
            )
          ],
        ));
  }
}
