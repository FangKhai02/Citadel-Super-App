import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/login_repository.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordPage extends HookWidget {
  ForgotPasswordPage({super.key});

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
                title: 'Forgot Password',
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w)
                    .copyWith(bottom: 16.h),
                child: PrimaryButton(
                  title: 'Submit',
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  onTap: () async {
                    await formKey.currentState?.validate(
                        onSuccess: (formData) async {
                      await forgotPass(context, formData);
                    });
                  },
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Forgot your password?',
                          style: AppTextStyle.header1),
                      gapHeight16,
                      Text(
                          'No worries. Please enter your email address and we will send you a link to reset your password.',
                          style: AppTextStyle.bodyText),
                      gapHeight64,
                      AppTextFormField(
                          formKey: formKey,
                          label: 'Email',
                          fieldKey: AppFormFieldKey.emailKey),
                    ]),
              ))),
    );
  }

  Future<void> forgotPass(BuildContext context, formData) async {
    LoginRepository repo = LoginRepository();

    EasyLoadingHelper.show();
    await repo.forgotPassword(formData[AppFormFieldKey.emailKey]).baseThen(
      context,
      onResponseSuccess: (resp) {
        Navigator.pushNamed(context, CustomRouter.forgotPasswordSuccess);
      },
      onResponseError: (e, s) {
        if (e.message.equalsIgnoreCase('api.user.not.found')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email Address Is Not Registered.'),
              backgroundColor: AppColor.errorRed,
            ),
          );
        } else if (e.message.equalsIgnoreCase('api.invalid.email')) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Invalid Email Address'),
            backgroundColor: AppColor.errorRed,
          ));
        } else if (e.message.equalsIgnoreCase('api.wrong.password')) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Password Does Not Match'),
            backgroundColor: AppColor.errorRed,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
              backgroundColor: AppColor.errorRed,
            ),
          );
        }
      },
    ).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
