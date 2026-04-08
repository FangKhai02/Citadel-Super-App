import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/button/app_back_button.dart';
import 'package:flutter/material.dart';

class CitadelAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeading;
  final Widget? leading;
  final Color? backgroundColor;
  final String? title;
  final Color? titleColor;
  final Widget? titleWidget;
  final Widget Function(Widget child)? titleBuilder;
  final List<Widget> actions;
  final VoidCallback? onTap;

  const CitadelAppBar(
      {super.key,
      this.title,
      this.titleColor,
      this.leading,
      this.titleWidget,
      this.titleBuilder,
      this.backgroundColor,
      this.showLeading = true,
      this.actions = const [],
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final titleChild = Text(title ?? '',
        style:
            AppTextStyle.header3.copyWith(color: titleColor ?? AppColor.white));

    return AppBar(
      toolbarHeight: kToolbarHeight + 44,
      backgroundColor: backgroundColor ?? Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: showLeading
          ? leading ??
              Center(
                  child: AppBackButton(
                onTap: onTap,
                color: titleColor,
              ))
          : const SizedBox.shrink(),
      title: titleWidget ?? titleBuilder?.call(titleChild) ?? titleChild,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: actions),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 44);
}
