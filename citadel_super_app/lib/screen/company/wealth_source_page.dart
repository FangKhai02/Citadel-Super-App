import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WealthSourcePage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final Function(String annualIncome, String sourceOfIncome) onConfirm;
  final String? initialIncome;
  final String? initialSource;
  WealthSourcePage(
      {super.key,
      required this.onConfirm,
      this.initialIncome,
      this.initialSource});

  @override
  ConsumerState<WealthSourcePage> createState() => WealthSourcePageState();
}

class WealthSourcePageState extends ConsumerState<WealthSourcePage> {
  late final TextEditingController annualDeclarationController;
  late final TextEditingController sourceIncomeController;

  @override
  void initState() {
    super.initState();
    annualDeclarationController = TextEditingController(
        text: getValueForKey(widget.initialIncome ?? '', ref));
    sourceIncomeController = TextEditingController(
        text: getValueForKey(widget.initialSource ?? '', ref));
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: widget.formKey,
      child: CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Enter your details'),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            key: const Key(AppFormFieldKey.primaryButtonValidateKey),
            onTap: () async {
              // FocusScope.of(context).unfocus();

              await widget.formKey.currentState?.validate(
                  onSuccess: (formData) {
                widget.onConfirm(formData[AppFormFieldKey.annualIncomeKey],
                    formData[AppFormFieldKey.sourceOfIncomeKey]);
              });
            },
            title: 'Confirm',
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wealth & Source of Income',
                style: AppTextStyle.header1,
              ),
              Consumer(builder: (context, ref, child) {
                final constants = ref.read(appProvider).constants ?? [];
                final annualDeclarationType = constants.firstWhere((element) =>
                    element.category == AppConstantsKey.annualDeclarationType);
                final options = annualDeclarationType.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList();
                final initialOptions = options.firstWhereOrNull(
                    (element) => element.value == widget.initialIncome);

                return AppDropdown(
                    formKey: widget.formKey,
                    label: 'Annual Turnover of Declaration',
                    fieldKey: AppFormFieldKey.annualIncomeKey,
                    hintText: 'Annual Turnover of Declaration',
                    textController: annualDeclarationController,
                    initialValue: initialOptions?.text ?? '',
                    options: options);
              }),
              Consumer(builder: (context, ref, child) {
                final constants = ref.read(appProvider).constants ?? [];
                final sourceIncomeConstants = constants.firstWhere((element) =>
                    element.category == AppConstantsKey.sourceIncomeType);
                final options = sourceIncomeConstants.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList();
                final initialOptions = options.firstWhereOrNull(
                    (element) => element.value == widget.initialSource);

                return AppDropdown(
                    formKey: widget.formKey,
                    label: 'Source of Income',
                    fieldKey: AppFormFieldKey.sourceOfIncomeKey,
                    hintText: 'Source of Income',
                    textController: sourceIncomeController,
                    initialValue: initialOptions?.text ?? '',
                    options: options);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
