import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OthersOptions extends StatelessWidget {
  final Function()? onTap;
  final String? image;
  final String title;
  final bool action;
  final ValueNotifier<bool>? isSwitched;

  const OthersOptions(
      {super.key,
      this.onTap,
      this.image,
      this.title = '',
      this.action = false,
      this.isSwitched});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: image != null
          ? Image.asset(
              image!,
              width: 24.w,
              height: 24.h,
            )
          : const SizedBox(),
      title: Text(title, style: AppTextStyle.bodyText),
      trailing: action
          ? SizedBox(
              width: 45.w,
              height: 35.h,
              child: FittedBox(
                fit: BoxFit.fill,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onTap,
                  child: Switch(
                    value: isSwitched!.value,
                    onChanged: (value) {
                      if (onTap != null) onTap!();
                      isSwitched!.value = value;
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      minLeadingWidth: 16,
      splashColor: Colors.transparent,
    );
  }
}
