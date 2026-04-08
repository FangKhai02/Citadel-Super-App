import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentInfoContainer extends HookConsumerWidget {
  final String? agentId;
  final String title;
  final String image;
  final VoidCallback? onTap;

  const AgentInfoContainer(
      {super.key,
      required this.title,
      required this.image,
      this.onTap,
      this.agentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentTotalSales = ref.watch(agentTotalSalesFutureProvider(agentId));

    return GestureDetector(
      onTap: onTap,
      child: AppInfoContainer(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          borderRadius: 32.r,
          child: agentTotalSales.maybeWhen(data: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      image,
                      width: 24.w,
                      height: 24.h,
                    ),
                    gapWidth8,
                    Text(
                      title,
                      style: AppTextStyle.header3,
                    ),
                  ],
                ),
                gapHeight16,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'RM ${double.tryParse(data.totalSalesAmount ?? '0.0')?.toInt().thousandSeparator() ?? '0.00'}',
                        style: AppTextStyle.header1,
                      ),
                    ),
                    gapWidth16,
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: (double.tryParse(
                                          data.percentageDifference ?? '0') ??
                                      0) >
                                  0
                              ? AppColor.green
                              : (double.tryParse(data.percentageDifference ??
                                              '0') ??
                                          0) ==
                                      0
                                  ? AppColor.placeHolderBlack
                                  : AppColor.errorRed,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Row(
                        children: [
                          Image.asset(
                            (double.tryParse(
                                            data.percentageDifference ?? '0') ??
                                        0) >
                                    0
                                ? Assets.images.icons.increase.path
                                : Assets.images.icons.decrease.path,
                            width: 12.w,
                            height: 12.h,
                          ),
                          Text(
                            '${data.percentageDifference ?? '0'} %',
                            style: AppTextStyle.label,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                gapHeight8,
                Text(
                  '${data.currentQuarterStartDate.toDateFormat('MMM')} - ${data.currentQuarterEndDate.toDateFormat('MMM yyyy')}',
                  style: AppTextStyle.description,
                ),
              ],
            );
          }, orElse: () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      image,
                      width: 24.w,
                      height: 24.h,
                    ),
                    gapWidth8,
                    Text(
                      title,
                      style: AppTextStyle.header3,
                    ),
                  ],
                ),
                gapHeight16,
                Row(
                  children: [
                    Text(
                      'RM 0.00',
                      style: AppTextStyle.bigNumber,
                    ),
                    gapWidth16,
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: AppColor.placeHolderBlack,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.images.icons.increase.path,
                            width: 12.w,
                            height: 12.h,
                          ),
                          Text(
                            '0 %',
                            style: AppTextStyle.label,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                gapHeight8,
                Text(
                  '-',
                  style: AppTextStyle.description,
                ),
              ],
            );
          })),
    );
  }
}
