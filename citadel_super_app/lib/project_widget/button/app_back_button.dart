import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final Image? image;
  final VoidCallback? onTap;
  const AppBackButton({super.key, this.color, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: Theme.of(context).iconButtonTheme.style?.copyWith(
            backgroundColor: const WidgetStatePropertyAll(AppColor.white),
            side: const WidgetStatePropertyAll(BorderSide.none),
          ),
      onPressed: onTap ??
          () async {
            Navigator.pop(context);
          },
      icon: image ??
          Image.asset(
            Assets.images.icons.back.path,
            width: 24,
            height: 24,
            color: color ?? AppColor.white,
          ),
    );
  }
}
