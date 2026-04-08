import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/commission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommissionStatusIndicator extends HookWidget {
  final CommissionStatus status;

  const CommissionStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Text(
          getStatus(status),
          style: AppTextStyle.description,
        ),
      ],
    );
  }
}

Color getStatusColor(CommissionStatus status) {
  switch (status) {
    case CommissionStatus.newCommission:
      return AppColor.green;
    case CommissionStatus.success:
      return AppColor.green;
  }
}

String getStatus(CommissionStatus status) {
  switch (status) {
    case CommissionStatus.newCommission:
      return 'New';
    case CommissionStatus.success:
      return 'Success';
  }
}
