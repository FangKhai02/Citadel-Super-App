import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/app_repository.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactUsPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  ContactUsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConstant = ref.read(appProvider).constants ?? [];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    List<AppDropDownItem> getReasonList() {
      List<AppDropDownItem> reasonList = [];

      for (var constant in appConstant) {
        if (constant.category == AppConstantsKey.contactUsReason) {
          for (var reason in (constant.list ?? [])) {
            reasonList.add(AppDropDownItem(
                text: reason.value ?? '', value: reason.key ?? ''));
          }
        }
      }

      return reasonList;
    }

    return AppForm(
      key: formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.darkToBright2,
          appBar: const CitadelAppBar(
            title: 'Contact Us',
          ),
          bottomNavigationBar: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: PrimaryButton(
              key: const Key(AppFormFieldKey.primaryButtonValidateKey),
              onTap: (() async {
                await formKey.currentState?.validate(
                    onSuccess: (formData) async {
                  await sendContactUs(context, formData);
                });
              }),
              title: 'Submit',
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextFormField(
                    formKey: formKey,
                    label: 'Name',
                    fieldKey: AppFormFieldKey.nameKey),
                AppMobileFormField(formKey: formKey),
                AppTextFormField(
                    formKey: formKey,
                    label: 'Email',
                    fieldKey: AppFormFieldKey.emailKey),
                AppDropdown(
                  formKey: formKey,
                  label: 'Reason',
                  fieldKey: AppFormFieldKey.reasonKey,
                  hintText: 'Reason',
                  options: getReasonList(),
                  onSelected: (item) {},
                ),
                gapHeight24,
                AppTextFormField(
                  formKey: formKey,
                  label: 'Remark',
                  fieldKey: AppFormFieldKey.remarkKey,
                  height: 160,
                  maxline: 6,
                  minLine: 6,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    hintText: 'Remark',
                    labelText: 'Remark',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.labelGray)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.labelGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.brightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> sendContactUs(BuildContext context, formData) async {
    AppRepository repo = AppRepository();
    final req = ParameterHelper().contactUsFormSubmitRequestVo(formData);
    EasyLoadingHelper.show();
    await repo.postContactUs(req).baseThen(
      context,
      onResponseSuccess: (resp) {
        Navigator.pushNamed(context, CustomRouter.contactUsSuccess);
      },
      onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper().resolveValidationError(formKey, e.message);
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
