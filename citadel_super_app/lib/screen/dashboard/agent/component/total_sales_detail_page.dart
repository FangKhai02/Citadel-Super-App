import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/agent_info_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/personal_sales_record_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TotalSalesDetailPage extends HookWidget {
  final String? agentId;
  const TotalSalesDetailPage({super.key, this.agentId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sales belongs to your agent.',
          style: AppTextStyle.bodyText,
        ),
        gapHeight32,
        AgentInfoContainer(
          image: Assets.images.icons.totalSales.path,
          title: 'Total Sales',
          agentId: agentId,
        ),
        gapHeight32,
        Text(
          'Further Breakdown',
          style: AppTextStyle.header2,
        ),
        gapHeight16,
        PersonalSalesRecord(
          agentId: agentId,
        ),
      ],
    );
  }
}
