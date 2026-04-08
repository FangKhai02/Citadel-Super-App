import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/selection/tick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileSelection {
  final Widget? icon;
  final String text;
  final TextStyle? textStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final bool isDisabled;

  ListTileSelection(
      {this.icon,
      required this.text,
      this.textStyle,
      this.description,
      this.descriptionStyle,
      this.isDisabled = false});
}

class AppListTileSelection extends StatefulWidget {
  const AppListTileSelection(
      {super.key,
      this.items = const [],
      this.onSelected,
      this.initialSelectedIndex});
  final Function(int?)? onSelected;
  final List<ListTileSelection> items;
  final int? initialSelectedIndex;

  @override
  State<AppListTileSelection> createState() => _AppListTileSelectionState();
}

class _AppListTileSelectionState extends State<AppListTileSelection> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              // Scaffold gradient will make listtile unable to show color, thus using container color to determine this
              color: index == selectedIndex
                  ? AppColor.cyan
                  : AppColor.primaryUnselect,
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide.none),
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide.none),
                  1),
              leading: widget.items[index].icon,
              title: Text(widget.items[index].text,
                  style: widget.items[index].textStyle ?? AppTextStyle.header3),
              subtitle: widget.items[index].description != null
                  ? Text(widget.items[index].description!,
                      style: widget.items[index].descriptionStyle ??
                          AppTextStyle.description)
                  : null,
              trailing: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: widget.items[index].isDisabled
                    ? const CircleSelectedDisableTick()
                    : selectedIndex == index
                        ? const CircleSelectedTick()
                        : const CircleUnselectedTick(),
              ),
              selected: index == selectedIndex,
              // tileColor: AppColor.primaryUnselect,
              // selectedTileColor: AppColor.cyan,
              onTap: widget.items[index].isDisabled
                  ? null
                  : () {
                      try {
                        widget.onSelected!(index);

                        setState(() {
                          selectedIndex = index;
                        });
                        // ignore: empty_catches
                      } catch (e) {}
                    },
            ),
          ),
        );
      },
    );
  }
}
