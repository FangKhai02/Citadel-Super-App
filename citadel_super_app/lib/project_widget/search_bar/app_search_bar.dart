import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchBar extends HookWidget {
  final TextEditingController controller;
  final EdgeInsets? padding;
  final Color? fillColor;
  final TextStyle? style;

  const AppSearchBar({super.key, required this.controller, this.padding, this.fillColor, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: TextFormField(
          controller: controller,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ??AppColor.white,
            prefixIcon: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Image.asset(Assets.images.icons.search.path)),
            prefixIconConstraints: BoxConstraints(maxHeight: 24.h),
            hintText: 'Search',
            labelStyle: AppTextStyle.bodyText
                .copyWith(color: AppColor.offWhite),
            hintStyle: AppTextStyle.bodyText
                .copyWith(color: AppColor.placeHolderBlack),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.placeHolderBlack,
                width: 1.0,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.placeHolderBlack,
                width: 1.0,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.placeHolderBlack,
                width: 1.0,
              ),
            ),
          ),
          style: style ?? AppTextStyle.bodyText.copyWith(color: AppColor.placeHolderBlack),
      ),
    );
  }
}
