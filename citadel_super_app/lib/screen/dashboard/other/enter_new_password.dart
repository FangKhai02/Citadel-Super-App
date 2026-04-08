import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/login_repository.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterNewPasswordPage extends StatefulHookWidget {
  final String? oldPassword;
  EnterNewPasswordPage({super.key, required this.oldPassword});
  final formKey = GlobalKey<AppFormState>();
  late TextEditingController passwordController;

  @override
  EnterNewPasswordPageState createState() => EnterNewPasswordPageState();
}

class EnterNewPasswordPageState extends State<EnterNewPasswordPage> {
  late TextEditingController passwordController;
  bool eightChar = false;
  bool oneUpperChar = false;
  bool onSpecialChar = false;
  bool oneNumber = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    passwordController.addListener(() {
      setState(() {
        if (passwordController.text.length >= 8) {
          eightChar = true;
        } else {
          eightChar = false;
        }

        if (passwordController.text.contains(RegExp(r'[A-Z]'))) {
          oneUpperChar = true;
        } else {
          oneUpperChar = false;
        }

        if (passwordController.text.contains(RegExp(r'[0-9]'))) {
          oneNumber = true;
        } else {
          oneNumber = false;
        }

        if (passwordController.text
            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          onSpecialChar = true;
        } else {
          onSpecialChar = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState?.validateFormButton();
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
          key: widget.formKey,
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
                    await widget.formKey.currentState?.validate(
                        onSuccess: (formData) async {
                      if (formData[AppFormFieldKey.passwordKey] !=
                          formData[AppFormFieldKey.confirmPasswordKey]) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: AppColor.errorRed,
                                content: Text('Password does not match')));
                        return;
                      }

                      final error = validatePassword(
                          formData[AppFormFieldKey.passwordKey]);
                      if (error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: AppColor.errorRed,
                            content: Text(error)));
                        return;
                      }

                      await changePassword(context, formData);
                    });
                  },
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter your new password',
                          style: AppTextStyle.header1),
                      gapHeight32,
                      AppPasswordFormField(
                          formKey: widget.formKey,
                          label: 'Password (min 8 characters)',
                          controller: passwordController,
                          fieldKey: AppFormFieldKey.passwordKey),
                      gapHeight8,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          conditionNotes(passwordController.text.isEmpty,
                              eightChar, 'At least 8 characters'),
                          gapHeight8,
                          conditionNotes(passwordController.text.isEmpty,
                              oneUpperChar, 'At least 1 capital letter'),
                          gapHeight8,
                          conditionNotes(passwordController.text.isEmpty,
                              onSpecialChar, 'At least 1 special character'),
                          gapHeight8,
                          conditionNotes(passwordController.text.isEmpty,
                              oneNumber, 'At least 1 number'),
                        ],
                      ),
                      gapHeight24,
                      AppPasswordFormField(
                          formKey: widget.formKey,
                          label: 'Confirm Password (min 8 characters)',
                          fieldKey: AppFormFieldKey.confirmPasswordKey),
                    ]),
              ))),
    );
  }

  Widget conditionNotes(
      bool isEmpty, bool fulfillCondition, String conditionText) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isEmpty
                ? AppColor.placeHolderBlack
                : fulfillCondition
                    ? AppColor.correctGreen
                    : AppColor.errorRed,
          ),
          child: Visibility(
            visible: !isEmpty,
            child: Center(
              child: Icon(
                Icons.check,
                color: AppColor.mainBlack,
                size: 8.w,
              ),
            ),
          ),
        ),
        gapWidth8,
        Expanded(
            child: Text(
          conditionText,
          style: AppTextStyle.caption.copyWith(
            color: isEmpty
                ? AppColor.placeHolderBlack
                : fulfillCondition
                    ? AppColor.correctGreen
                    : AppColor.errorRed,
          ),
        )),
      ],
    );
  }

  Future<void> changePassword(BuildContext context, formData) async {
    LoginRepository repo = LoginRepository();
    EasyLoadingHelper.show();
    final req = ParameterHelper().changePasswordParam(
        widget.oldPassword ?? '', formData[AppFormFieldKey.passwordKey]);
    await repo.changePassword(req).baseThen(
      context,
      onResponseSuccess: (resp) {
        Navigator.pushNamed(context, CustomRouter.passwordCreationSuccess);
      },
      onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      },
    ).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
