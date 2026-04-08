import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewTabWidget extends HookWidget {
  final String title;
  final int index;
  final ValueNotifier<int> currentPageIndex;
  final PageController? pageController;

  const PageViewTabWidget(
      {super.key,
      required this.title,
      required this.index,
      required this.currentPageIndex,
      this.pageController});

  @override
  Widget build(BuildContext context) {
    final isSelected = currentPageIndex.value == index;
    return InkWell(
        onTap: () {
          currentPageIndex.value = index;
          pageController?.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.5.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.cyan : Colors.transparent,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Center(
            child: Text(
              title,
              style:
                  isSelected ? AppTextStyle.action : AppTextStyle.description,
            ),
          ),
        ));
  }
}
