import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/niu_apply_signee.dart';
import 'package:citadel_super_app/data/repository/niu_repository.dart';
import 'package:citadel_super_app/data/state/niu_application_state.dart';
import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/screen/universal/component/sign_authories_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuSignPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final NiuRepository niuRepository = NiuRepository();
  NiuGetApplicationDetailsVo? application;

  NiuSignPage({super.key, this.application});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final niuApplicationNotifier = ref.watch(niuApplicationProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(
        title: 'NIU Application',
      ),
      child: AppForm(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Authorised Signatories', style: AppTextStyle.header1),
              gapHeight16,
              Text('We need your signatures to authorize the application.',
                  style: AppTextStyle.bodyText),
              ...List.generate(2, (index) {
                return SignAuthoriesWidget(
                  formKey: formKey,
                  label: 'Signee ${index + 1}',
                  index: index,
                  fieldKey: index == 0
                      ? AppFormFieldKey.signeeOneKey
                      : AppFormFieldKey.signeeTwoKey,
                );
              }),
              gapHeight32,
              PrimaryButton(
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                title: 'Confirm',
                onTap: () async {
                  await apply(context, ref, niuApplicationNotifier);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> apply(BuildContext context, WidgetRef ref,
      NiuApplicationState niuApplicationNotifier) async {
    await formKey.currentState!.validate(onSuccess: (formData) async {
      final signeOne =
          await (formData[AppFormFieldKey.signeeOneKey] as NiuApplySignee).vo;
      final signeeTwo =
          await (formData[AppFormFieldKey.signeeTwoKey] as NiuApplySignee).vo;

      if (signeOne == null || signeeTwo == null) {
        (getAppContext() ?? context)
            .showErrorSnackBar('Please sign both signees');
        return;
      }

      niuApplicationNotifier.setFirstSignee(signeOne);
      niuApplicationNotifier.setSecondSignee(signeeTwo);

      final req = ref.read(niuApplicationProvider);
      NiuRepository niuRepository = NiuRepository();
      await niuRepository.niuApply(req).baseThen(getAppContext() ?? context,
          onResponseSuccess: (resp) {
        Navigator.pushReplacementNamed(context, CustomRouter.niuSuccess);
      }, onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper().resolveValidationError(formKey, e.message);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColor.errorRed, content: Text(e.message)));
        }
      });
    });
  }
}
