import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final Widget? description;
  final Widget bottomButton;

  const ResultPage(
      {super.key,
      required this.imagePath,
      required this.title,
      this.description,
      required this.bottomButton});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CitadelBackground(
          backgroundType: BackgroundType.blueToOrange,
          bottomNavigationBar: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: bottomButton,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Image.asset(
                    imagePath,
                    width: 96.w,
                  ),
                  gapHeight32,
                  Text(
                    title,
                    style: AppTextStyle.header1,
                    textAlign: TextAlign.center,
                  ),
                  gapHeight16,
                  description ?? const SizedBox()
                ],
              ),
            ),
          )),
    );
  }
}
