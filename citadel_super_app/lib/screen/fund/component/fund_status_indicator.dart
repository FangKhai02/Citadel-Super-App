import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/fund/portfolio_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundStatusIndicator extends HookWidget {
  final PortfolioStatus status;

  const FundStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: getStatusColor(status),
            shape: BoxShape.circle,
          ),
        ),
        gapWidth8,
        Flexible(
          child: Text(
            getStatus(status),
            softWrap: true,
            style: AppTextStyle.description,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

Color getStatusColor(PortfolioStatus status) {
  switch (status) {
    case PortfolioStatus.active:
      return AppColor.green;
    case PortfolioStatus.inReview:
      return AppColor.yellow;
    case PortfolioStatus.rejected:
      return AppColor.errorRed;
    case PortfolioStatus.draft:
      return AppColor.orange;
    case PortfolioStatus.completed:
      return AppColor.green;
    case PortfolioStatus.agreement:
      return AppColor.brightBlue;
    case PortfolioStatus.pendingPayment:
      return AppColor.orange;
    case PortfolioStatus.matured:
      return AppColor.yellow;
    case PortfolioStatus.withdrawn:
      return AppColor.green;
    case PortfolioStatus.pending:
      return AppColor.orange;
    case PortfolioStatus.failed:
      return AppColor.errorRed;
    case PortfolioStatus.success:
      return AppColor.green;
    case PortfolioStatus.cancelled:
      return AppColor.yellow;
    case PortfolioStatus.expired:
      return AppColor.orange;
    case PortfolioStatus.processing:
      return AppColor.orange;
    case PortfolioStatus.pendingPayment:
      return AppColor.brightBlue;
    case PortfolioStatus.secondSignee:
      return AppColor.brightBlue;
    default:
      return Colors.grey;
  }
}

String getStatus(PortfolioStatus status) {
  switch (status) {
    case PortfolioStatus.active:
      return 'Active';
    case PortfolioStatus.inReview:
      return 'In Review';
    case PortfolioStatus.rejected:
      return 'Rejected';
    case PortfolioStatus.draft:
      return 'Draft';
    case PortfolioStatus.completed:
      return 'Completed';
    case PortfolioStatus.agreement:
      return 'Agreement';
    case PortfolioStatus.pendingPayment:
      return 'Pending Payment';
    case PortfolioStatus.matured:
      return 'Matured';
    case PortfolioStatus.withdrawn:
      return 'Withdrawn';
    case PortfolioStatus.pending:
      return 'Pending';
    case PortfolioStatus.failed:
      return 'Failed';
    case PortfolioStatus.success:
      return 'Success';
    case PortfolioStatus.cancelled:
      return 'Cancelled';
    case PortfolioStatus.expired:
      return 'Expired';
    case PortfolioStatus.processing:
      return 'Processing';
    case PortfolioStatus.pendingPayment:
      return 'Pending Payment';
    case PortfolioStatus.secondSignee:
      return 'Agreement';
    default:
      return 'Unknown';
  }
}
