import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/project_widget/selection/tick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DualHorizontalTileSelection extends StatefulHookWidget {
  const DualHorizontalTileSelection(
      {super.key,
      this.items = const [],
      this.initialSelectedIndex,
      this.onSelected});
  final Function(int?)? onSelected;
  final int? initialSelectedIndex;
  final List<String> items;

  /// only do 2 selection

  @override
  State<DualHorizontalTileSelection> createState() =>
      _DualHorizontalTileSelectionState();
}

class _DualHorizontalTileSelectionState
    extends State<DualHorizontalTileSelection> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      selectedIndex = widget.initialSelectedIndex;
      return null;
    }, [widget.initialSelectedIndex]);

    return Row(children: [
      tileSelection(widget.items[0], 0, selectedIndex, onSelected: () {
        widget.onSelected!(0);
        setState(() {
          selectedIndex = 0;
        });
      }),
      gapWidth16,
      tileSelection(widget.items[1], 1, selectedIndex, onSelected: () {
        widget.onSelected!(1);
        setState(() {
          selectedIndex = 1;
        });
      }),
    ]);
  }
}

Widget tileSelection(String item, int index, int? selectedIndex,
    {required Function() onSelected}) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide.none),
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide.none),
            1),
        title: Text(item,
            style: TextStyle(
                fontSize: 16.spMin,
                color: AppColor.white,
                fontWeight: index == selectedIndex
                    ? FontWeight.w600
                    : FontWeight.w300)),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: selectedIndex == index
              ? const CircleSelectedTick()
              : const CircleUnselectedTick(),
        ),
        selected: index == selectedIndex,
        tileColor: AppColor.primaryUnselect,
        selectedTileColor: AppColor.cyan,
        onTap: () {
          onSelected();
        },
      ),
    ),
  );
}
