import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CitadelGroupPage extends HookConsumerWidget {
  const CitadelGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
      backgroundType: BackgroundType.brightToDark2,
      appBar: const CitadelAppBar(
        title: 'Citadel Group',
      ),
      bottomNavigationBar: const CitadelBottomNav(

        needPop: true,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 0.55.sh, maxHeight: 0.55.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Citadel Group', style: AppTextStyle.header2),
              gapHeight32,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(bottomNavigationProvider.notifier)
                            .setSelectedIndex(1);
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 164.w,
                          height: 164.w,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Image.asset(
                            Assets.images.icons.citadelGroupCorporate.path,
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  gapWidth16,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(bottomNavigationProvider.notifier)
                            .setSelectedIndex(2);
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: 164.w,
                          height: 164.w,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Image.asset(
                            Assets.images.icons.citadelGroupNiu.path,
                            scale: 2.w,
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
