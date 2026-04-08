import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleSelectedTick extends StatelessWidget {
  const CircleSelectedTick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.white,
      ),
      child: Assets.images.icons.tick.image(color: AppColor.cyan),
    );
  }
}

class CircleSelectedDisableTick extends StatelessWidget {
  const CircleSelectedDisableTick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.white.withOpacity(0.4),
      ),
      child: Assets.images.icons.tick.image(color: AppColor.disabledBlack),
    );
  }
}

class CircleUnselectedTick extends StatelessWidget {
  const CircleUnselectedTick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.white.withOpacity(0.4), width: 1)),
    );
  }
}

class SquareUnselectedTick extends StatelessWidget {
  const SquareUnselectedTick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColor.lineGray, width: 1)),
    );
  }
}

class SquareSelectedTick extends StatelessWidget {
  const SquareSelectedTick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        color: AppColor.brightBlue,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Assets.images.icons.tick.image(),
    );
  }
}
