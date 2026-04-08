import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/state/agent_profile_state.dart';
import 'package:citadel_super_app/extension/agent_detail_extension.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/personal_sales_record_widget.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/agent_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalSaleDetailPage extends HookConsumerWidget {
  const PersonalSaleDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentTotalSales = ref.watch(agentTotalSalesFutureProvider(null));
    final profile = ref.watch(agentProfileFutureProvider);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: agentTotalSales.maybeWhen(data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapHeight32,
              AgentInfoContainer(
                  image: Assets.images.icons.totalSales.path,
                  title: 'Total Sales'),
              gapHeight16,
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      flex: 60,
                      child: AppInfoContainer(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 24.h),
                          borderRadius: 32.r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Assets.images.icons.totalProductSold.path,
                                width: 24.w,
                                height: 24.w,
                              ),
                              gapHeight8,
                              Text(
                                'Total Product Sold',
                                style: AppTextStyle.label,
                              ),
                              gapHeight16,
                              Text(
                                data.totalProductsSold.toString(),
                                style: AppTextStyle.number,
                              ),
                            ],
                          )),
                    ),
                    gapWidth16,
                    Flexible(
                      flex: 40,
                      child: AppInfoContainer(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 24.h),
                          borderRadius: 32.r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Assets.images.icons.onlineBanking.path,
                                width: 24.w,
                                height: 24.w,
                              ),
                              gapHeight8,
                              Text(
                                'Payment Method',
                                style: AppTextStyle.label,
                              ),
                              gapHeight16,
                              Text(
                                data.paymentMethod ?? '-',
                                style: AppTextStyle.bodyText,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              gapHeight32,
              Row(
                children: [
                  Text(
                    'Further Breakdown',
                    style: AppTextStyle.header2,
                  ),
                  const Spacer(),
                  profile.maybeWhen(orElse: () {
                    return const SizedBox.shrink();
                  }, data: (profile) {
                    return profile.agentDetails.agentTypeDisplay
                            .equalsIgnoreCase('CITADEL')
                        ? GestureDetector(
                            onTap: () async {
                              EasyLoadingHelper.show();

                              final month = DateTime.now().month;
                              final year = DateTime.now().year;

                              AgentRepository repo = AgentRepository();
                              await repo
                                  .getAgentComissionReport(month, year)
                                  .baseThen(context,
                                      onResponseSuccess: (pdfLink) {
                                if (pdfLink != null) {
                                  DownloadFileHelper()
                                      .downloadAndOpenPDF(context, pdfLink);
                                } else {
                                  context.showWarningSnackBar('No pdf found.');
                                }
                              }).whenComplete(
                                      () => EasyLoadingHelper.dismiss());
                            },
                            child: Image.asset(
                              Assets.images.icons.downloadBlue.path,
                              width: 40.w,
                              height: 40.w,
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
                ],
              ),
              gapHeight16,
              const PersonalSalesRecord(),
            ],
          );
        }, orElse: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
