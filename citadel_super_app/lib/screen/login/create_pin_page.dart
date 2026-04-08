import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CreatePinPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  CreatePinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String pin = '';
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: formKey,
      child: CitadelBackground(
        backgroundType: BackgroundType.pureBlack,
        appBar: const CitadelAppBar(
          title: 'Fast Login',
          showLeading: false,
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            key: const Key(AppFormFieldKey.primaryButtonValidateKey),
            title: 'Submit',
            onTap: () async {
              await formKey.currentState?.validate(onSuccess: (formData) async {
                if (pin.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: AppColor.errorRed,
                      content: Text('Security PIN is required')));
                  return;
                }
                await createPin(context, ref, pin);
              });
            },
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create your Security Pin', style: AppTextStyle.header1),
              gapHeight16,
              Text(
                'Set your personal 4-digit pin. It will be used for secure and fast login.',
                style: AppTextStyle.bodyText,
              ),
              gapHeight64,
              Builder(
                builder: (pinContext) {
                  return SizedBox(
                    width: 180.w,
                    child: PinCodeTextField(
                        obscureText: true,
                        appContext: context,
                        length: 4,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          fieldOuterPadding: EdgeInsets.only(right: 16.w),
                          shape: PinCodeFieldShape.underline,
                          fieldHeight: 39.h,
                          fieldWidth: 24.w,
                          selectedColor: AppColor.brightBlue,
                          selectedFillColor: Colors.transparent,
                          activeColor: AppColor.lineGray,
                          activeFillColor: Colors.transparent,
                          inactiveColor: AppColor.lineGray,
                          inactiveFillColor: Colors.transparent,
                        ),
                        textStyle:
                            TextStyle(fontSize: 16.sp, color: AppColor.white),
                        cursorColor: AppColor.brightBlue,
                        enableActiveFill: false,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          pin = value;
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createPin(
      BuildContext context, WidgetRef ref, String pin) async {
    final userType = ref.watch(bottomNavigationProvider);
    if (userType.isLoginAsClient) {
      ClientRepository repo = ClientRepository();
      final req = ParameterHelper().changePinParam(newPin: pin);
      EasyLoadingHelper.show();
      await repo.registerPin(req).baseThen(
        context,
        onResponseSuccess: (resp) {
          Navigator.pushNamed(context, CustomRouter.pinCreateSucess);
        },
        onResponseError: (e, s) {
          if (e.message.equalsIgnoreCase('api.invalid.new.pin')) {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Security PIN'),
                backgroundColor: AppColor.errorRed,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.errorRed, content: Text(e.message)));
          }
        },
      ).whenComplete(() => EasyLoadingHelper.dismiss());
    } else if (userType.isLoginAsAgent) {
      AgentRepository repo = AgentRepository();
      final req = ParameterHelper().changeAgentPinParam(newPin: pin);
      EasyLoadingHelper.show();
      await repo.registerPin(req).baseThen(
        context,
        onResponseSuccess: (resp) {
          Navigator.pushNamed(context, CustomRouter.pinCreateSucess);
        },
        onResponseError: (e, s) {
          if (e.message.equalsIgnoreCase('api.invalid.new.pin')) {
            ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Security PIN'),
                backgroundColor: AppColor.errorRed,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.errorRed, content: Text(e.message)));
          }
        },
      ).whenComplete(() => EasyLoadingHelper.dismiss());
    }
  }
}
