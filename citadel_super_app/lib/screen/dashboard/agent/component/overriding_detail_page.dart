import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/commission_status.dart';
import 'package:citadel_super_app/data/model/month_year.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/commission_status_indicator.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/month_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverridingDetailsPage extends StatefulHookConsumerWidget {
  const OverridingDetailsPage({super.key});

  @override
  ConsumerState<OverridingDetailsPage> createState() =>
      OverridingDetailsPageState();
}

class OverridingDetailsPageState extends ConsumerState<OverridingDetailsPage> {
  late MonthYear monthYear;

  @override
  void initState() {
    super.initState();
    monthYear = MonthYear(
      month: DateTime.now().month,
      year: DateTime.now().year,
    );
  }

  @override
  Widget build(BuildContext context) {
    final comissions =
        ref.watch(agentComissionOverridingFutureProvider(monthYear));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapHeight32,
          Text(
            'Commission earn under your downline.',
            style: AppTextStyle.bodyText,
          ),
          gapHeight32,
          MonthDropdown(
            onMonthSelected: (int month, int year) async {
              monthYear.month = month;
              monthYear.year = year;

              ref.invalidate(agentComissionOverridingFutureProvider(monthYear));
            },
          ),
          comissions.when(data: (data) {
            if (data.isEmpty) {
              return AppInfoContainer(
                margin: EdgeInsets.only(top: 32.h),
                child: Text(
                  'No data available',
                  style: AppTextStyle.header3,
                ),
              );
            }

            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var category = data[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.productCode ?? '',
                      style: AppTextStyle.header2,
                    ),
                    gapHeight16,
                    AppInfoContainer(
                        child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var record = category.commissionList![index];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    record.agentName ?? '',
                                    style: AppTextStyle.bodyText,
                                  ),
                                ),
                                gapWidth16,
                                CommissionStatusIndicator(
                                    status: CommissionStatus.newCommission
                                        .getStatus(record.status ?? '')),
                                gapHeight4,
                              ],
                            ),
                            gapHeight8,
                            Row(
                              children: [
                                Text(
                                  record.agentRole ?? '',
                                  style: AppTextStyle.description,
                                ),
                                const Spacer(),
                                Text(
                                  'RM ${(record.commissionAmount ?? 0.0).toInt().thousandSeparator()}',
                                  style: AppTextStyle.header3,
                                ),
                              ],
                            ),
                            gapHeight8,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    record
                                        .calculatedDate.toDDMMMYYYhhmmWithSpace,
                                    style: AppTextStyle.caption,
                                  ),
                                ),
                                Text(
                                  'Commission ${record.commissionPercentage} %',
                                  style: AppTextStyle.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            gapHeight16,
                            Divider(
                              color: AppColor.white.withOpacity(0.2),
                            ),
                            gapHeight16
                          ],
                        );
                      },
                      itemCount: (category.commissionList ?? []).length,
                    ))
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return gapHeight32;
              },
            );
          }, error: (e, s) {
            return Center(
              child: Text('Error: ${e.toString()}'),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ],
      ),
    );
  }
}
