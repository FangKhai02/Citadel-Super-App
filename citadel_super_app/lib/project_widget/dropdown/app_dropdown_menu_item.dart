import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDownMenuItem extends StatelessWidget {
  const AppDropDownMenuItem({
    super.key,
    required this.currentSelectedValue,
    required this.item,
  });
  final String currentSelectedValue;
  final AppDropDownItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.5.h),
      decoration: currentSelectedValue == item.value
          ? BoxDecoration(
              color: AppColor.brightBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.r),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.text,
            style: TextStyle(
              fontSize: 16.spMin,
              fontWeight: currentSelectedValue == item.value
                  ? FontWeight.w600
                  : FontWeight.w300,
              color: currentSelectedValue == item.value
                  ? AppColor.mainBlack
                  : AppColor.labelBlack,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (currentSelectedValue == item.value)
            Assets.images.icons.tick
                .image(width: 16.r, height: 16.r, color: AppColor.cyan)
        ],
      ),
    );
  }
}
