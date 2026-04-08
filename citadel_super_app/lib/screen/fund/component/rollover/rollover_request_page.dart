import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/product_repository.dart';
import 'package:citadel_super_app/data/request/reallocate_request_vo.dart';
import 'package:citadel_super_app/data/request/rollover_request_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/screen/fund/component/rollover/rollover_result_page.dart';

class RolloverRequestPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final ClientPortfolioProductDetailsResponseVo portfolioDetails;
  final String referenceNumber;

  RolloverRequestPage(
      {super.key,
      required this.referenceNumber,
      required this.portfolioDetails});

  @override
  RolloverRequestPageState createState() => RolloverRequestPageState();
}

class RolloverRequestPageState extends ConsumerState<RolloverRequestPage> {
  List<AppDropDownItem> amountOptions = [];
  List<AppDropDownItem> productOptions = [];

  final TextEditingController rolloverAmountController =
      TextEditingController();
  final TextEditingController reallocationProductController =
      TextEditingController();
  final TextEditingController reallocationAmountController =
      TextEditingController();

  void clearDependentFields() {
    rolloverAmountController.clear();
    reallocationProductController.clear();
    reallocationAmountController.clear();
  }

  @override
  void dispose() {
    rolloverAmountController.dispose();
    reallocationProductController.dispose();
    reallocationAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ProductRepository repo = ProductRepository();
      await repo
          .getProductIncrementalValue(widget.referenceNumber)
          .baseThen(context, onResponseSuccess: (amountList) {
        for (var amount in amountList) {
          amountOptions.add(AppDropDownItem(
              value: amount.toString(),
              text: '${amount.toInt().thousandSeparator()}'));
        }
        setState(() {});
      });

      await repo
          .getReallocatableProductCodes(widget.referenceNumber)
          .baseThen(context, onResponseSuccess: (productCodes) {
        productOptions.clear();

        for (var product in productCodes) {
          productOptions.add(AppDropDownItem(value: product, text: product));
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedMethod = useState<String>('');

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    void proceedToResultPage(String selectedMethod) {
      ref.refresh(clientPortfolioFutureProvider.future);
      ref.invalidate(corporatePortfolioFutureProvider);
      Navigator.pushNamed(
        context,
        CustomRouter.rolloverResult,
        arguments: RolloverResultPage(selectedMethod: selectedMethod),
      );
    }

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(
        title: 'Redeem / Rollover',
      ),
      child: AppForm(
        key: widget.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColor.brightBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.portfolioDetails.clientPortfolio?.productName ??
                          '',
                      style: AppTextStyle.header2,
                    ),
                    gapHeight8,
                    Text(
                      'RM${(widget.portfolioDetails.clientPortfolio?.purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                      style: AppTextStyle.number,
                    ),
                  ],
                ),
              ),
              gapHeight32,
              Consumer(builder: (context, ref, child) {
                final constants = ref.read(appProvider).constants ?? [];
                final redemptionMethodConstants = constants.firstWhere(
                    (element) =>
                        element.category ==
                        AppConstantsKey.redemptionMethodType);
                final options = redemptionMethodConstants.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList();

                if (productOptions.isEmpty) {
                  options
                      .removeWhere((option) => option.value == "REALLOCATION");
                }
                return AppDropdown(
                  formKey: widget.formKey,
                  label: 'Method of Redemption',
                  fieldKey: AppFormFieldKey.methodOfRedemptionKey,
                  hintText: 'Method of Redemption',
                  options: options,
                  onSelected: (item) async {
                    selectedMethod.value = item.value;
                    clearDependentFields();
                  },
                );
              }),
              if (selectedMethod.value == "ROLLOVER") ...[
                gapHeight32,
                Text(
                  'Amount to Rollover',
                  style: AppTextStyle.label
                      .copyWith(color: AppColor.labelGray, fontSize: 11.spMin),
                ),
                AppDropdown(
                  formKey: widget.formKey,
                  label: 'Amount to Rollover',
                  fieldKey: AppFormFieldKey.amountRolloverKey,
                  textController: rolloverAmountController,
                  options: amountOptions,
                  padding: EdgeInsets.only(top: 8.h),
                  textFieldDecoration: BaseFormField.inputDecoration.copyWith(
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 32.w, maxWidth: 32.w),
                    prefixIcon: Text(
                      'RM',
                      style: AppTextStyle.header3
                          .copyWith(color: AppColor.brightBlue),
                    ),
                  ),
                ),
                gapHeight8,
                Text(
                  'The leftover amount will be submitted for redemption request',
                  style: AppTextStyle.caption,
                ),
              ] else if (selectedMethod.value == "REALLOCATION") ...[
                gapHeight16,
                AppDropdown(
                  formKey: widget.formKey,
                  label: 'Product of Reallocation',
                  hintText: 'Product of Reallocation',
                  fieldKey: AppFormFieldKey.productReallocationKey,
                  textController: reallocationProductController,
                  options: productOptions,
                ),
                gapHeight32,
                Text(
                  'Amount to Reallocation',
                  style: AppTextStyle.label
                      .copyWith(color: AppColor.labelGray, fontSize: 11.spMin),
                ),
                AppDropdown(
                  formKey: widget.formKey,
                  label: 'Amount of Reallocation',
                  fieldKey: AppFormFieldKey.amountReallocationKey,
                  textController: reallocationAmountController,
                  options: amountOptions,
                  padding: EdgeInsets.only(top: 8.h),
                  textFieldDecoration: BaseFormField.inputDecoration.copyWith(
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 32.w, maxWidth: 32.w),
                    prefixIcon: Text(
                      'RM',
                      style: AppTextStyle.header3
                          .copyWith(color: AppColor.brightBlue),
                    ),
                  ),
                ),
                gapHeight8,
                Text(
                  'The leftover amount will be submitted for redemption request',
                  style: AppTextStyle.caption,
                ),
                gapHeight24,
              ],
              gapHeight48,
              PrimaryButton(
                key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                title: 'Submit',
                onTap: () async {
                  await widget.formKey.currentState!.validate(
                      onSuccess: (formData) async {
                    ProductRepository repo = ProductRepository();

                    EasyLoadingHelper.show();
                    switch (selectedMethod.value) {
                      case "ROLLOVER":
                        RolloverRequestVo req = RolloverRequestVo(
                          rolloverAmount: double.tryParse(
                              rolloverAmountController.text
                                  .replaceAll(',', '')),
                        );
                        await repo
                            .productRollover(widget.referenceNumber, req)
                            .baseThen(context, onResponseSuccess: (data) {
                          proceedToResultPage(selectedMethod.value);
                        }).whenComplete(() => EasyLoadingHelper.dismiss());
                        break;
                      case "REALLOCATION":
                        ReallocateRequestVo req = ReallocateRequestVo(
                          productCode: reallocationProductController.text,
                          amount: double.tryParse(reallocationAmountController
                                  .text
                                  .replaceAll(',', '')) ??
                              0.0,
                        );
                        await repo
                            .productReallocation(widget.referenceNumber, req)
                            .baseThen(context, onResponseSuccess: (data) {
                          proceedToResultPage(selectedMethod.value);
                        }).whenComplete(() => EasyLoadingHelper.dismiss());
                        break;
                      case "FULLY_REDEEM":
                        await repo
                            .productFullyRedemption(
                          widget.referenceNumber,
                        )
                            .baseThen(context, onResponseSuccess: (data) {
                          proceedToResultPage(selectedMethod.value);
                        }).whenComplete(() => EasyLoadingHelper.dismiss());
                        break;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
