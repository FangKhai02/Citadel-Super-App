import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MonthDropdown extends HookWidget {
  final Function(int, int) onMonthSelected;
  const MonthDropdown({super.key, required this.onMonthSelected});
  @override
  Widget build(BuildContext context) {
    final months = useMemoized(() {
      final now = DateTime.now();
      return List.generate(12, (index) {
        final date = DateTime(now.year, now.month - index, 1);
        return DateFormat('MMM yyyy').format(date);
      });
    });

    final selectedMonth = useState<String>(months.first);

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(64.0.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMonth.value,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          onChanged: (String? newValue) {
            if (newValue != null) {
              selectedMonth.value = newValue;
              DateTime parsedDate = DateFormat("MMM yyyy").parse(newValue);

              // Extract month and year as int
              int month = parsedDate.month;
              int year = parsedDate.year;

              onMonthSelected(month, year);
            }
          },
          items: months.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: selectedMonth.value == value
                      ? AppColor.brightBlue.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(value,
                    style: TextStyle(
                      fontSize: 16.spMin,
                      fontWeight: selectedMonth.value == value
                          ? FontWeight.w600
                          : FontWeight.w300,
                      color: selectedMonth.value == value
                          ? AppColor.mainBlack
                          : AppColor.labelBlack,
                    )),
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return months.map((String value) {
              return Row(
                children: [
                  Image.asset(
                    Assets.images.icons.calendarBlue.path,
                    width: 24.w,
                    height: 24.w,
                  ),
                  gapWidth8,
                  Text(
                    value,
                    style: AppTextStyle.description,
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
