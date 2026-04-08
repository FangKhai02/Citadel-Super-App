import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/commission_status.dart';
import 'package:citadel_super_app/data/model/month_year.dart';
import 'package:citadel_super_app/data/model/sales_details.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/commission_status_indicator.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/month_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PersonalSalesRecord extends StatefulHookConsumerWidget {
  final String? agentId;
  const PersonalSalesRecord({super.key, this.agentId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      PersonalSalesRecordState();
}

class PersonalSalesRecordState extends ConsumerState<PersonalSalesRecord> {
  late SalesDetails salesDetails;

  @override
  void initState() {
    super.initState();
    salesDetails = SalesDetails(agentId: widget.agentId);
  }

  @override
  Widget build(BuildContext context) {
    var agentSalesDetails =
        ref.watch(agentSalesDetailsFutureProvider(salesDetails));

    return Column(
      children: [
        MonthDropdown(
          onMonthSelected: (int month, int year) async {
            salesDetails.monthYear = MonthYear(month: month, year: year);

            ref.invalidate(agentSalesDetailsFutureProvider(salesDetails));
          },
        ),
        gapHeight16,
        agentSalesDetails.when(
          data: (data) {
            if (data.salesDetails == null || data.salesDetails!.isEmpty) {
              return AppInfoContainer(
                  child: Text(
                'No data yet. Please try again later.',
                style: AppTextStyle.bodyText,
              ));
            }
            return ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (BuildContext context, int index) {
                  return gapHeight16;
                },
                itemCount: (data.salesDetails ?? []).length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var sales = data.salesDetails![index];
                  return AppInfoContainer(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              sales.clientName ?? '',
                              style: AppTextStyle.bodyText,
                            ),
                          ),
                          gapWidth16,
                          CommissionStatusIndicator(
                              status: CommissionStatus.newCommission
                                  .getStatus(sales.productStatus ?? '')),
                        ],
                      ),
                      gapHeight4,
                      Row(
                        children: [
                          Text(
                            sales.clientId ?? '',
                            style: AppTextStyle.description,
                          ),
                          const Spacer(),
                          Text(
                            sales.calculatedDate.toDateFormat('dd MMM yyyy'),
                            style: AppTextStyle.description,
                          )
                        ],
                      ),
                      gapHeight16,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: '${sales.code} ',
                                style: AppTextStyle.header3),
                            TextSpan(
                                text: '(${sales.agreementFileName})',
                                style: AppTextStyle.caption)
                          ]),
                        ),
                      ),
                      gapHeight8,
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: container(
                                    'Total Sales', sales.purchasedAmount)),
                            gapWidth8,
                            Expanded(
                                child: container(
                                    'Commission Earn (${sales.commissionPercentage}%)',
                                    sales.commissionAmount)),
                          ],
                        ),
                      )
                    ],
                  ));
                });
          },
          error: (e, s) {
            return AppInfoContainer(
                child: Text(
              'No data yet. Please try again later.',
              style: AppTextStyle.bodyText,
            ));
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  Widget container(String title, double? number) {
    return WhiteBorderContainer(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColor.white.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.label.copyWith(color: AppColor.labelGray),
          ),
          gapHeight8,
          Text(
            'RM ${number?.toInt().thousandSeparator()}',
            style: AppTextStyle.bodyText,
          )
        ],
      ),
    );
  }
}
