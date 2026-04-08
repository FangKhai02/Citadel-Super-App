import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPasswordFormField extends HookWidget {
  final String fieldKey;
  final String? label;
  final GlobalKey<AppFormState> formKey;
  final TextEditingController? controller;

  const AppPasswordFormField(
      {super.key,
      required this.formKey,
      this.controller,
      this.label,
      this.fieldKey = AppFormFieldKey.passwordKey});

  @override
  Widget build(BuildContext context) {
    final showPassword = useState(false);

    return AppTextFormField(
      label: label ?? 'Password',
      fieldKey: fieldKey,
      formKey: formKey,
      controller: controller,
      textStyle: AppTextStyle.bodyText,
      suffix: GestureDetector(
        onTap: () {
          showPassword.value = !showPassword.value;
        },
        child: Image.asset(
            showPassword.value
                ? Assets.images.icons.view.path
                : Assets.images.icons.password.path,
            width: 24.w),
      ),
      isObscure: !showPassword.value,
    );
  }
}
