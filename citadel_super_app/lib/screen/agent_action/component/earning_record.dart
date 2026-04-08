import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/agent_earning_vo.dart';
import 'package:citadel_super_app/extension/agent_product_order_comission_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/screen/agent_action/earning_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningRecord extends HookWidget {
  final AgentEarningVo earning;

  const EarningRecord({super.key, required this.earning});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pushNamed(context, CustomRouter.agentEarningDetails,
            arguments: EarningDetailsPage(earning: earning));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        child: Row(children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(earning.earningTypeDisplay, style: AppTextStyle.bodyText),
              gapHeight4,
              Text(earning.agreementNameDisplay, style: AppTextStyle.caption),
              gapHeight4,
              Text(earning.transactionDateDisplay,
                  style:
                      AppTextStyle.caption.copyWith(color: AppColor.labelGray)),
            ],
          )),
          gapWidth16,
          Text(
            earning.comissionAmountDisplay,
            style: AppTextStyle.header3.copyWith(
              color: earning.getTransactionColor,
            ),
          )
        ]),
      ),
    );
  }
}
