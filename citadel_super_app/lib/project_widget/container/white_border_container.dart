import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteBorderContainer extends HookWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;

  const WhiteBorderContainer(
      {super.key, required this.child, this.padding, this.decoration});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: decoration ??
          BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: AppColor.white.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8.r)),
      padding: padding ?? EdgeInsets.all(16.r),
      child: child,
    );
  }
}
