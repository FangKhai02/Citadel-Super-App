import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:citadel_super_app/project_widget/selection/tick.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppCheckbox extends BaseFormField {
  final GlobalKey<AppFormState>? formKey;
  final bool? isTick;
  final Function(bool)? onCheck;
  final TextStyle? textStyle;

  const AppCheckbox(
      {super.key,
      this.formKey,
      required super.label,
      required super.fieldKey,
      this.isTick = false,
      super.isRequired = false,
      this.textStyle,
      this.onCheck});

  @override
  BaseFormFieldState createState() => AppCheckboxState();
}

class AppCheckboxState extends BaseFormFieldState<AppCheckbox> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.isTick ?? false;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      checked = widget.isTick ?? false;
      return null;
    }, [widget.isTick]);

    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;
          widget.onCheck!(checked);
          widget.formKey?.currentState!.validateFormButton();
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          checked ? const SquareSelectedTick() : const SquareUnselectedTick(),
          gapWidth16,
          Expanded(
              child: Text(widget.label,
                  style: widget.textStyle ?? AppTextStyle.bodyText)),
        ],
      ),
    );
  }

  @override
  bool? onSaved() {
    return checked;
  }

  @override
  bool validate() {
    if (widget.isRequired) {
      return checked;
    } else {
      return true;
    }
  }
}
