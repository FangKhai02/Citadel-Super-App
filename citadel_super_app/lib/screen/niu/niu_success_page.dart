import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/niu_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuSuccessPage extends HookConsumerWidget {
  const NiuSuccessPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResultPage(
      imagePath: Assets.images.icons.loan.path,
      title: 'We have received your application',
      description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              'Your NIU Application will be reviewed within 3 days. You may check the details in ',
          style: AppTextStyle.bodyText,
          children: [
            TextSpan(
              text: 'Menu > \nNIU',
              style: AppTextStyle.header3,
            ),
          ],
        ),
      ),
      bottomButton: PrimaryButton(
        title: 'Back to home',
        onTap: () {
          // ignore: unused_result
          ref.refresh(niuApplicationDetailsFutureProvider.future);
          Navigator.pushNamedAndRemoveUntil(
              context, CustomRouter.dashboard, (route) => false);
        },
      ),
    );
  }
}
