import 'dart:io';

import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaintenancePage extends StatelessWidget {
  final String startDatetime;
  final String endDatetime;

  const MaintenancePage(
      {super.key, 
      required this.startDatetime, 
      required this.endDatetime});

  @override
  Widget build(BuildContext context) {
    // String maintenanceTime = '10 Sep 2024, 12:00am - 6:00am';

    return CitadelBackground(
        backgroundType: BackgroundType.maintenance,
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            title: 'Okay',
            onTap: () {
              if (Platform.isAndroid) {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Image.asset(Assets.images.icons.maintenanceSchedule.path),
              gapHeight32,
              Text(
                'Scheduled Maintenance',
                style: AppTextStyle.header1,
              ),
              gapHeight16,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyle.description,
                  text: 'We have a scheduled maintenance for Citadel app on ',
                  children: [
                    TextSpan(
                      text: '$startDatetime - $endDatetime',
                      style: AppTextStyle.header3,
                    ),
                    TextSpan(
                      text:
                          '. During this period, our services will be temporarily unavailable. Thank you for your understanding!',
                      style: AppTextStyle.bodyText,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
