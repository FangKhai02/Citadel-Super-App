import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/app_repository.dart';
import 'package:citadel_super_app/data/request/app_user_delete_request_vo.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/screen/login/pin_attempt_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountDeletionRequestPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final String accountName;
  final String mobileNumber;
  final String mobileCountryCode;

  AccountDeletionRequestPage(
      {super.key,
      required this.accountName,
      required this.mobileCountryCode,
      required this.mobileNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: formKey,
      child: CitadelBackground(
        appBar: const CitadelAppBar(
          title: 'Account Deletion Request',
        ),
        backgroundType: BackgroundType.darkToBright2,
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            onTap: () async {
              await formKey.currentState!.validate(onSuccess: (formData) {
                Navigator.pushNamed(context, CustomRouter.pinAttempt,
                    arguments: PinAttemptPage(
                      appBarTitle: 'Account Deletion Request',
                      onConfirm: (oldPin) async {
                        AppRepository repo = AppRepository();
                        await repo
                            .deleteAccount(AppUserDeleteRequestVo(
                                pin: oldPin,
                                name: formData[AppFormFieldKey.nameKey],
                                mobileNumber:
                                    formData[AppFormFieldKey.mobileNumberKey],
                                mobileCountryCode:
                                    formData[AppFormFieldKey.countryCodeKey],
                                reason: formData[
                                    AppFormFieldKey.accountDeleteReasonKey]))
                            .baseThen(context, onResponseSuccess: (response) {
                          Navigator.pushNamed(
                              context, CustomRouter.accountDeleteSuccess);
                        });
                      },
                    ));
              });
            },
            title: 'Submit',
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This action will be reviewed and the account will be deleted upon confirmation. All your data including your login access will be deleted.',
                style: AppTextStyle.bodyText,
              ),
              gapHeight32,
              AppTextFormField(
                formKey: formKey,
                label: 'Name',
                initialValue: accountName,
                fieldKey: AppFormFieldKey.nameKey,
                isEnabled: false,
              ),
              gapHeight16,
              AppMobileFormField(
                formKey: formKey,
                country: countryCodeNotifier
                        .getObjectByDialCode(dialCode: mobileCountryCode)
                        ?.countryName ??
                    '',
                initialValue: mobileNumber,
                enabled: false,
              ),
              gapHeight24,
              AppTextFormField(
                formKey: formKey,
                label: 'Reason for Account Deletion',
                fieldKey: AppFormFieldKey.accountDeleteReasonKey,
                height: 128,
                maxline: 10,
                minLine: 6,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Reason for Account Deletion',
                  labelText: 'Reason for Account Deletion',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColor.labelGray),
                      borderRadius: BorderRadius.all(Radius.circular(8.r))),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.labelGray),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.brightBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
