import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/data/vo/fund_amount_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class PurchaseFundBase extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final int productId;

  PurchaseFundBase(
      {super.key,
      required this.productId,
      required this.onAmountChoosen,
      required this.onPurchase,
      required this.onLivingTrustChoosen});

  @override
  PurchaseFundPageState createState() => PurchaseFundPageState();

  final Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)
      onPurchase;

  final Function(WidgetRef ref, double purchaseAmount, double dividend,
      int investmentMonth) onAmountChoosen;

  final Function(WidgetRef ref, bool livingTrustEnabled) onLivingTrustChoosen;
}

class PurchaseFundPageState extends ConsumerState<PurchaseFundBase> {
  late final TextEditingController amountController;

  @override
  void dispose() {
    globalRef.invalidate(productDetailFutureProvider(widget.productId));
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(corporatePurchaseFundProvider);
      ref.invalidate(purchaseFundProvider);
      ref.read(productOrderRefProvider.notifier).state = null;
      globalRef
          .read(purchaseFundProvider.notifier)
          .setProductId(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isValidAmount = useState<bool?>(null);
    final matchingFund = useState<FundAmountVo?>(null);
    final productDetails =
        ref.watch(productDetailFutureProvider(widget.productId));

    // final purchaseFundState = ref.watch(purchaseFundProvider);

    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      child: productDetails.when(data: (data) {
        final double? increment;
        final double? minimumPlacement;
        final double? maxPlacementRange;

        final ableToMinus = useState(false);

        if ((data.fundAmounts ?? []).isNotEmpty) {
          minimumPlacement = data.fundAmounts!.first.amount;
          increment = (data.fundAmounts![1].amount ?? 0.0) -
              (data.fundAmounts!.first.amount ?? 0.0);
          maxPlacementRange = data.fundAmounts!.last.amount;

          amountController.addListener(() {
            if (amountController.text.isEmpty) {
              isValidAmount.value = null;
              ableToMinus.value = false;
              return;
            }

            if (int.parse(amountController.text) <= minimumPlacement!) {
              ableToMinus.value = false;
            } else {
              ableToMinus.value = true;
            }

            final purchaseAmount = double.tryParse(amountController.text) ?? 0;

            Future.microtask(() {
              if (purchaseAmount > 0 &&
                  (purchaseAmount % (increment ?? 0)) == 0 &&
                  purchaseAmount < maxPlacementRange!.toInt()) {
                int index =
                    binarySearch(data.fundAmounts!, purchaseAmount.toInt());
                if (index != -1) {
                  isValidAmount.value = true;
                  matchingFund.value = data.fundAmounts![index];

                  widget.onAmountChoosen(
                      ref,
                      purchaseAmount,
                      matchingFund.value?.dividend ?? 0.0,
                      data.investmentTenureMonth ?? 0);
                } else {
                  isValidAmount.value = false;
                  matchingFund.value = null;
                }
              } else {
                isValidAmount.value = false;
                matchingFund.value = null;
              }
            });
          });

          return AppForm(
              key: widget.formKey,
              child: CitadelBackground(
                backgroundType: BackgroundType.darkToBright2,
                appBar: const CitadelAppBar(title: 'Purchase Trust Product'),
                onRefresh: () async {
                  ref.invalidate(productDetailFutureProvider(widget.productId));
                },
                bottomNavigationBar: isValidAmount.value ?? false
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w)
                            .copyWith(bottom: 16.h),
                        child: PrimaryButton(
                            key: const Key(
                                AppFormFieldKey.primaryButtonValidateKey),
                            title: 'Proceed',
                            onTap: () async {
                              if ((data.livingTrustOptionEnabled ?? false) &&
                                  (double.tryParse(amountController.text) ??
                                          0) >=
                                      250000) {
                                await showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AppDialog(
                                        image: Assets
                                            .images.icons.livingTrustIcon.path,
                                        title:
                                            'Do you want to opt for Living Trust?',
                                        message:
                                            'Upon death or Total Permanent Disability (Brain Death) of the Settlor, the Settlor can choose to transfer the amount to Living Trust to ensure that beneficiaries will only get the amount after 18 years of age or 10 years minimum remaining in Living Trust, whichever is later.',
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        textAlign: TextAlign.center,
                                        positiveText: 'Yes, I agree',
                                        positiveOnTap: () {
                                          widget.onLivingTrustChoosen(
                                              ref, true);
                                          widget.onPurchase(
                                              context, ref, widget.formKey);
                                        },
                                        negativeText: 'No, I do not agree',
                                        negativeOnTap: () {
                                          widget.onLivingTrustChoosen(
                                              ref, false);
                                          widget.onPurchase(
                                              context, ref, widget.formKey);
                                        },
                                        isRounded: true,
                                      );
                                    });
                              } else {
                                widget.onPurchase(context, ref, widget.formKey);
                              }
                            }),
                      )
                    : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? '',
                        style: AppTextStyle.header1,
                      ),
                      gapHeight32,
                      Text(
                        'Placement Amount',
                        style: AppTextStyle.label,
                      ),
                      AppTextFormField(
                        padding: EdgeInsets.zero,
                        label: '',
                        fieldKey: AppFormFieldKey.investmentAmountKey,
                        controller: amountController,
                        textStyle: AppTextStyle.bigNumber,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                          suffixIcon: Container(
                            width: 72.w,
                            margin: EdgeInsets.only(left: 8.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: ableToMinus.value
                                      ? () {
                                          setState(() {
                                            final currentAmount = int.tryParse(
                                                    amountController.text) ??
                                                0;
                                            final newAmount =
                                                (currentAmount - increment!)
                                                    .toInt()
                                                    .toString();
                                            amountController.text = newAmount;
                                          });
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.remove,
                                    size: 20.r,
                                    color: ableToMinus.value
                                        ? AppColor.white
                                        : AppColor.labelGray.withOpacity(0.3),
                                  ),
                                ),
                                gapWidth32,
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      final currentAmount =
                                          int.tryParse(amountController.text) ??
                                              0;
                                      if (currentAmount == 0) {
                                        amountController.text = minimumPlacement
                                                ?.toInt()
                                                .toString() ??
                                            '';
                                      } else {
                                        final newAmount =
                                            (currentAmount + increment!)
                                                .toInt()
                                                .toString();
                                        amountController.text = newAmount;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 20.r,
                                    color: AppColor.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          enabledBorder:
                              BaseFormField.inputDecoration.enabledBorder,
                          focusedBorder:
                              BaseFormField.inputDecoration.focusedBorder,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.labelGray.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      gapHeight8,
                      fundDescription(
                          'Incremental value of RM${increment!.toInt().commaFormatter()}'),
                      gapHeight8,
                      fundDescription(
                          'Trust fund available RM${(minimumPlacement ?? 0.0).toInt().commaFormatter()} - RM${(maxPlacementRange ?? 0.0).toInt().commaFormatter()}'),
                      gapHeight8,
                      Visibility(
                        visible: isValidAmount.value != null &&
                            !isValidAmount.value!,
                        child: Text(
                          'Invalid amount. Please enter a valid amount between the range and is dividable by RM${increment.toInt().commaFormatter()}.',
                          style: AppTextStyle.label
                              .copyWith(color: AppColor.errorRed),
                        ),
                      ),
                      gapHeight32,
                      Visibility(
                          visible: (isValidAmount.value ?? false),
                          child: AppInfoContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppInfoText(
                                    'Returns from Placement (per Annum)',
                                    '${(matchingFund.value?.dividend ?? 0.0).toString()} %'),
                                gapHeight24,
                                AppInfoText('Trust Tenure',
                                    '${data.investmentTenureMonth ?? 0} months'),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ));
        } else {
          return Center(
            child: Text(
              'Unable to retrieve product details, please try again.',
              textAlign: TextAlign.center,
              style: AppTextStyle.header2,
            ),
          );
        }
      }, error: (error, stackTrace) {
        return Center(
          child: Text(
            'Unable to retrieve product details due to /n ${error.toString()},\n please refresh and try again.',
            textAlign: TextAlign.center,
            style: AppTextStyle.header2,
          ),
        );
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  int binarySearch(List<FundAmountVo> sortedList, int target) {
    int low = 0;
    int high = sortedList.length - 1;

    while (low <= high) {
      int mid = (low + high) ~/ 2;

      if (sortedList[mid].amount == target) {
        return mid; // Element found
      } else if (sortedList[mid].amount! < target) {
        low = mid + 1; // Search right half
      } else {
        high = mid - 1; // Search left half
      }
    }

    return -1; // Element not found
  }

  Widget fundDescription(String content) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColor.placeHolderBlack),
        ),
        gapWidth8,
        Expanded(
            child: Text(
          content,
          style:
              AppTextStyle.caption.copyWith(color: AppColor.placeHolderBlack),
        )),
      ],
    );
  }
}
