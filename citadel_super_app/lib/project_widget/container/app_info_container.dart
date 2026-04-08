import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInfoContainer extends HookWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const AppInfoContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? 1.sw,
      decoration: BoxDecoration(
        color: color ?? AppColor.brightBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
      ),
      padding: padding ?? EdgeInsets.all(16.r),
      margin: margin,
      child: child,
    );
  }
}
