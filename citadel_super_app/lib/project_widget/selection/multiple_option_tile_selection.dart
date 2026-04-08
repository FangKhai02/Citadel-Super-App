import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/project_widget/selection/tick.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultipleOptionTileSelection extends StatefulHookWidget {
  final Function(List<int>)? onSelected;
  final List<ListTileSelection> items;
  final List<int>? initialSelectedIndexes;

  const MultipleOptionTileSelection({
    super.key,
    this.items = const [],
    this.initialSelectedIndexes,
    this.onSelected,
  });

  @override
  State<MultipleOptionTileSelection> createState() =>
      _MultipleOptionTileSelectionState();
}

class _MultipleOptionTileSelectionState
    extends State<MultipleOptionTileSelection> {
  List<int> selectedIndex = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (widget.initialSelectedIndexes != null) {
        selectedIndex = widget.initialSelectedIndexes!;
      }
      return;
    }, [widget.initialSelectedIndexes]);
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
              color: selectedIndex.contains(index)
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
                    : selectedIndex.contains(index)
                        ? const CircleSelectedTick()
                        : const CircleUnselectedTick(),
              ),
              selected: selectedIndex.contains(index),
              // tileColor: AppColor.primaryUnselect,
              // selectedTileColor: AppColor.cyan,
              onTap: widget.items[index].isDisabled
                  ? null
                  : () {
                      try {
                        setState(() {
                          setState(() {
                            if (selectedIndex.contains(index)) {
                              selectedIndex.remove(index);
                            } else {
                              selectedIndex.add(index);
                            }
                          });
                        });

                        widget.onSelected!(selectedIndex);

                        // ignore: empty_catches
                      } catch (e) {
                        appDebugPrint(e);
                      }
                    },
            ),
          ),
        );
      },
    );
  }
}
