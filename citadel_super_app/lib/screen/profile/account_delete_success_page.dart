import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountDeleteSuccessPage extends HookConsumerWidget {
  const AccountDeleteSuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResultPage(
        imagePath: Assets.images.icons.goodbye.path,
        title: "We've sorry to see you leave",
        description: Text(
          "We will review and get back to you in 2 working days",
          style: AppTextStyle.bodyText,
          textAlign: TextAlign.center,
        ),
        bottomButton: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, CustomRouter.dashboard, (route) => false);
            },
            title: 'Back to home',
          ),
        ));
  }
}
