import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatefulWidget {
  final Function()? onTap;
  final String? title;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final Widget? icon;
  final double? height;
  final double? width;
  final Color secondaryColor;
  final bool isVertical;

  const SecondaryButton({
    super.key,
    this.onTap,
    this.title,
    this.titleFontSize,
    this.titleFontWeight,
    this.height,
    this.width,
    this.icon,
    this.secondaryColor = AppColor.primaryBackground,
    this.isVertical = false,
  });

  @override
  State<SecondaryButton> createState() => SecondaryButtonState();
}

class SecondaryButtonState extends State<SecondaryButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap != null
          ? () async {
              if (isLoading) return;

              setState(() {
                isLoading = true;
              });
              try {
                await widget.onTap!();
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: AppColor.disabledBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: AppColor.white),
        ),
        padding: widget.isVertical
            ? EdgeInsets.symmetric(horizontal: 20.r, vertical: 18.r)
            : null,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: SizedBox(
        width: widget.width ?? 343.w,
        height: widget.height ?? 48.h,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : widget.isVertical
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) widget.icon!,
                        SizedBox(
                            height:
                                (widget.icon != null && widget.title != null)
                                    ? 8.h
                                    : 0),
                        if (widget.title != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.icon != null ? 20.h : 0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: widget.width ?? 250.w),
                              child: Text(
                                widget.title!,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.action,
                                maxLines: 2,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) widget.icon!,
                      SizedBox(
                          height: (widget.icon != null && widget.title != null)
                              ? 8.h
                              : 0),
                      gapWidth8,
                      if (widget.title != null)
                        Text(
                          widget.title!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: AppTextStyle.action,
                        ),
                    ],
                  ),
      ),
    );
  }
}
