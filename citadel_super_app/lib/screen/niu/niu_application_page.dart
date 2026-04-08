import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/niu_application_state.dart';
import 'package:citadel_super_app/helper/thousand_formatter.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:citadel_super_app/project_widget/selection/dual_horizontal_tile_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuApplicationPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  NiuApplicationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final didSelectApplicationType = useState(true);
    final niuApplicationState = ref.watch(niuApplicationProvider);
    final niuApplicationNotifier = ref.watch(niuApplicationProvider.notifier);
    final constants = ref.read(appProvider).constants ?? [];
    final tenurePeriodList = constants
            .firstWhere((element) =>
                element.category == AppConstantsKey.niuTenurePeriod)
            .list ??
        [];
    final niuApplicationType = constants
            .firstWhere((element) =>
                element.category == AppConstantsKey.niuApplicationType)
            .list ??
        [];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.darkToBright2,
          appBar: const CitadelAppBar(
            title: 'Niu Application',
          ),
          bottomNavigationBar: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: PrimaryButton(
              title: 'Next',
              key: const Key(AppFormFieldKey.primaryButtonValidateKey),
              onTap: () async {
                didSelectApplicationType.value =
                    niuApplicationState.applicationType != null;
                await formKey.currentState?.validate(
                    onSuccess: (formData) async {
                  if (!didSelectApplicationType.value) {
                    return;
                  }
                  niuApplicationNotifier.setAmountRequested(int.tryParse(
                          (formData[AppFormFieldKey.amountRequestedKey]
                                  as String)
                              .replaceAll(',', '')) ??
                      0);
                  niuApplicationNotifier
                      .setTenure(formData[AppFormFieldKey.tenureKey]);

                  final registerAsPersonal =
                      ref.read(niuApplicationProvider).applicationType ==
                          'PERSONAL';
                  Navigator.pushNamed(
                      context,
                      registerAsPersonal
                          ? CustomRouter.niuPersonalDetails
                          : CustomRouter.niuCompanyDetails);
                });
              },
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount Requested',
                  style: AppTextStyle.label,
                ),
                AppTextFormField(
                    label: '',
                    fieldKey: AppFormFieldKey.amountRequestedKey,
                    formKey: formKey,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [ThousandsFormatter()],
                    textStyle: AppTextStyle.bigNumber,
                    decoration: BaseFormField.inputDecoration.copyWith(
                      prefixIcon: SizedBox(
                        width: 32.w,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'RM',
                              style: AppTextStyle.header3
                                  .copyWith(color: AppColor.brightBlue),
                            ),
                          ),
                        ),
                      ),
                    )),
                gapHeight16,
                AppDropdown(
                  label: 'Tenure',
                  formKey: formKey,
                  fieldKey: AppFormFieldKey.tenureKey,
                  options: tenurePeriodList
                      .map(
                          (e) => AppDropDownItem(value: e.key!, text: e.value!))
                      .toList(),
                  onSelected: (item) {
                    niuApplicationNotifier.setTenure(item.value);
                  },
                ),
                gapHeight32,
                Text(
                  'Apply For',
                  style: AppTextStyle.header3,
                ),
                gapHeight16,
                DualHorizontalTileSelection(
                  initialSelectedIndex: niuApplicationType.indexWhere(
                      (element) =>
                          element.key ==
                          ref.read(niuApplicationProvider).applicationType),
                  items: niuApplicationType.map((e) => e.value!).toList(),
                  onSelected: (index) {
                    niuApplicationNotifier.setApplicationType(
                        niuApplicationType[index ?? 0].key ?? '');

                    didSelectApplicationType.value =
                        ref.read(niuApplicationProvider).applicationType !=
                            null;
                  },
                ),
                Visibility(
                  visible: !didSelectApplicationType.value,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Please select an application type',
                        style: BaseFormField.formErrorStyle),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
