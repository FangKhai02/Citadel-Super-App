import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayFundBanner extends StatelessWidget {
  const DisplayFundBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16.w, bottom: 16.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32.r),
                  child: Image(
                    width: 343.w,
                    height: 168.h,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.images.temporary.fakeFundICHTBackground.path,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    visible: true,
                    child: Image.asset(
                      Assets.images.backgrounds.comingSoon.path,
                      width: 80.w,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'ICHT-3',
                      style: AppTextStyle.header1
                          .copyWith(color: AppColor.white.withOpacity(0.4)),
                    ))
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w, bottom: 16.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32.r),
                  child: Image(
                    width: 343.w,
                    height: 168.h,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.images.temporary.fakeFundICHFTBackground.path,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    visible: true,
                    child: Image.asset(
                      Assets.images.backgrounds.comingSoon.path,
                      width: 80.w,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'ICHFT',
                      style: AppTextStyle.header1
                          .copyWith(color: AppColor.white.withOpacity(0.4)),
                    ))
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w, bottom: 16.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32.r),
                  child: Image(
                    width: 343.w,
                    height: 168.h,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      Assets.images.temporary.fakeFundCGOTBackground.path,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    visible: true,
                    child: Image.asset(
                      Assets.images.backgrounds.comingSoon.path,
                      width: 80.w,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      'CGOT-3',
                      style: AppTextStyle.header1
                          .copyWith(color: AppColor.white.withOpacity(0.4)),
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
