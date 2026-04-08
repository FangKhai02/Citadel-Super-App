import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpProgressBar extends StatelessWidget {
  final int currentStep; // 0 = Sign Up, 1 = Declaration, 2 = Disclaimer, 3 = Verification, 4 = Complete

  const SignUpProgressBar({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final steps = ['Sign Up', 'Declaration', 'Disclaimer', 'Verification', 'Complete'];

    return Row(
      children: List.generate(steps.length, (index) {
        final isPast = index < currentStep;
        final isPresent = index == currentStep;

        return Expanded(
          child: Column(
            children: [
              // Progress bar segment
              Row(
                children: [
                  // Left connector
                  if (index > 0)
                    Expanded(
                      child: Container(
                        height: 4.h,
                        margin: EdgeInsets.only(left: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.r),
                            bottomLeft: Radius.circular(2.r),
                          ),
                          color: index < currentStep
                              ? AppColor.brightBlue
                              : index == currentStep
                                  ? AppColor.yellow
                                  : AppColor.white.withOpacity(0.15),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                  // Right connector
                  Expanded(
                    child: Container(
                      height: 4.h,
                      margin: EdgeInsets.only(right: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2.r),
                          bottomRight: Radius.circular(2.r),
                        ),
                        color: index < currentStep
                            ? AppColor.brightBlue
                            : index == currentStep
                                ? AppColor.yellow
                                : AppColor.white.withOpacity(0.15),
                      ),
                    ),
                  ),
                ],
              ),
              gapHeight8,
              // Label below
              Text(
                steps[index],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.caption.copyWith(
                  fontSize: 9.spMin,
                  color: isPast || isPresent
                      ? (isPresent ? AppColor.yellow : AppColor.brightBlue)
                      : AppColor.white.withOpacity(0.4),
                  fontWeight: isPresent ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
