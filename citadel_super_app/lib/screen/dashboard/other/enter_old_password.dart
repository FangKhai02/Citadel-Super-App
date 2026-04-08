import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/login_repository.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_password_form_field.dart';
import 'package:citadel_super_app/screen/dashboard/other/enter_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterOldPasswordPage extends HookWidget {
  EnterOldPasswordPage({super.key});
  final formKey = GlobalKey<AppFormState>();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      child: AppForm(
          key: formKey,
          child: CitadelBackground(
              backgroundType: BackgroundType.darkToBright2,
              appBar: const CitadelAppBar(
                title: 'Change Password',
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w)
                    .copyWith(bottom: 16.h),
                child: PrimaryButton(
                  title: 'Continue',
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  onTap: () async {
                    await formKey.currentState?.validate(
                        onSuccess: (formData) async {
                      await validateOldPassword(context, formData);
                    });
                  },
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter your current password',
                          style: AppTextStyle.header1),
                      gapHeight32,
                      AppPasswordFormField(
                          formKey: formKey,
                          fieldKey: AppFormFieldKey.passwordKey),
                    ]),
              ))),
    );
  }

  Future<void> validateOldPassword(BuildContext context, formData) async {
    final req = ParameterHelper()
        .changePasswordParam(formData[AppFormFieldKey.passwordKey], null);
    LoginRepository repo = LoginRepository();
    EasyLoadingHelper.show();
    await repo.changePassword(req).baseThen(context, onResponseSuccess: (resp) {
      Navigator.pushNamed(context, CustomRouter.enterNewPassword,
          arguments: EnterNewPasswordPage(
              oldPassword: formData[AppFormFieldKey.passwordKey]));
    }, onResponseError: (e, s) {
      if (e.message.equalsIgnoreCase('api.wrong.password')) {
        ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColor.errorRed,
                content: Text('Password Does Not Match.')));
      } else {
        ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      }
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
