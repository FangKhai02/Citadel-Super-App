import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDownItem {
  final String value;
  final String text;

  AppDropDownItem({required this.value, required this.text});
}

class AppDropdown extends BaseFormField {
  const AppDropdown({
    super.key,
    this.formKey,
    required super.label,
    required super.fieldKey,
    this.hintText = '',
    this.isReadOnly = false,
    this.onSelected,
    required this.options,
    this.enabled = true,
    this.textController,
    super.isRequired = true,
    super.initialValue,
    this.textFieldDecoration,
    this.padding,
  });

  final GlobalKey<AppFormState>? formKey;

  /// This key is for you to get the data back from the form field.
  final String hintText;
  final bool isReadOnly;
  final Function(AppDropDownItem)? onSelected;
  final List<AppDropDownItem> options;
  final bool enabled;
  final TextEditingController? textController;
  final InputDecoration? textFieldDecoration;
  final EdgeInsets? padding;

  @override
  BaseFormFieldState createState() => AppDropdownState();
}

class AppDropdownState extends BaseFormFieldState<AppDropdown> {
  late final TextEditingController textEditingController;
  final MenuController menuController = MenuController();
  AppDropDownItem? selectedItem;

  /// Set the selected item programmatically (e.g., when pre-filling form data)
  void setSelectedItem(AppDropDownItem item) {
    setState(() {
      selectedItem = item;
      textEditingController.text = item.text;
    });
  }

  @override
  void initState() {
    super.initState();

    textEditingController = widget.textController ??
        TextEditingController(text: widget.initialValue);

    selectedItem = widget.options.firstWhereOrNull((e) =>
        e.text.toLowerCase() == textEditingController.text.toLowerCase() ||
        e.value.toLowerCase() == textEditingController.text.toLowerCase());

    textEditingController.addListener(() {
      final value = textEditingController.text;
      if (value.isNotEmpty) {
        menuController.close();
        // final list = widget.options
        //     .where((e) => e.text.toLowerCase() == value.toLowerCase());
        selectedItem = widget.options.firstWhereOrNull((e) =>
            e.text.toLowerCase() == textEditingController.text.toLowerCase() ||
            e.value.toLowerCase() == textEditingController.text.toLowerCase());
        widget.onSelected
            ?.call(selectedItem ?? AppDropDownItem(value: value, text: value));
        widget.formKey?.currentState?.validateFormButton();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterHistoryList = useMemoized(() {
      return widget.options;
    }, [widget.options]);

    return MenuAnchor(
      controller: menuController,
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStatePropertyAll(Size.fromHeight(0.1.sh)),
        maximumSize: WidgetStatePropertyAll(Size.fromHeight(0.5.sh)),
      ),
      menuChildren: [
        ...filterHistoryList.map(
          (e) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                selectedItem = e;
              });

              textEditingController.text = e.text;
              widget.formKey?.currentState?.validateFormButton();
              widget.onSelected?.call(e);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                width: 0.9.sw,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.5.h),
                decoration: selectedItem?.value == e.value
                    ? BoxDecoration(
                        color: AppColor.brightBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        e.text,
                        style: TextStyle(
                          fontSize: 16.spMin,
                          fontWeight: selectedItem?.value == e.value
                              ? FontWeight.w600
                              : FontWeight.w300,
                          color: selectedItem?.value == e.value
                              ? AppColor.mainBlack
                              : AppColor.labelBlack,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (selectedItem?.value == e.value)
                      Assets.images.icons.tick.image(
                          width: 16.r, height: 16.r, color: AppColor.cyan)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
      child: AppTextFormField(
          padding: widget.padding,
          fieldKey: widget.fieldKey,
          label: widget.label,
          validator: widget.validator,
          hint: widget.hintText,
          controller: textEditingController,
          isEnabled: widget.enabled,
          isRequired: widget.isRequired,
          suffix: Assets.images.icons.dropdown.image(scale: 3),
          textStyle: const TextStyle(
            color: AppColor.offWhite,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            if (menuController.isOpen) {
              menuController.close();
            } else {
              menuController.open();
            }
            return null;
          },
          decoration: widget.textFieldDecoration?.copyWith(
            suffix: Assets.images.icons.dropdown.image(scale: 3),
          )),
    );
  }

  @override
  String? onSaved() {
    return selectedItem?.value ?? textEditingController.text;
  }

  @override
  bool validate() {
    if (widget.isRequired) {
      setState(() {
        if (widget.isRequired &&
            (selectedItem == null || textEditingController.text.isEmpty)) {
          errorMsg = 'Please select a value';
          widget.formKey?.currentState
              ?.setError(fieldKey: widget.fieldKey, errorMsg: errorMsg);
        } else {
          errorMsg = '';
        }
      });
    } else {
      setState(() {
        errorMsg = '';
      });
    }
    return errorMsg.isEmpty;
  }
}
