import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/selection/app_list_tile_selection.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_bank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectCorporateBankDetailPage extends StatefulHookConsumerWidget {
  BankDetailsVo? chosenBank;
  BankDetailsVo? chosenBankFromPortfolio;
  String? corporateClientId;
  final Function(BankDetailsVo?)? onConfirm;

  SelectCorporateBankDetailPage(
      {super.key,
      required this.chosenBank,
      required this.onConfirm,
      this.chosenBankFromPortfolio,
      this.corporateClientId});

  @override
  ConsumerState<SelectCorporateBankDetailPage> createState() {
    return SelectBankDetailState();
  }
}

class SelectBankDetailState
    extends ConsumerState<SelectCorporateBankDetailPage> {
  @override
  Widget build(BuildContext context) {
    final bankList = ref.watch(corporateBankProvider(widget.corporateClientId));
    final selectedBank = useState<String?>(null);
    final selectedBankId = useState<int?>(null);

    useEffect(() {
      Future.microtask(() async {
        if (widget.chosenBankFromPortfolio != null) {
          widget.chosenBank = widget.chosenBankFromPortfolio;

          // selectedBank.value = widget.chosenBankFromPortfolio?.bankName;
          // selectedBankId.value = widget.chosenBankFromPortfolio?.id;
        }
      });
      return;
    });

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Purchase Trust Product'),
        bottomNavigationBar: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: PrimaryButton(
              title: 'Proceed',
              onTap: selectedBank.value != null
                  ? () async {
                      if (widget.onConfirm != null) {
                        widget.onConfirm!(widget.chosenBank);
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  : null,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bank Details',
                style: AppTextStyle.header1,
              ),
              gapHeight16,
              Text(
                'Confirm the bank details for this trust fund.',
                style: AppTextStyle.description,
              ),
              gapHeight32,
              ...bankList.maybeWhen(
                  data: (bankList) {
                    return [
                      AppListTileSelection(
                        items: [
                          ...bankList.map((e) {
                            return ListTileSelection(
                              text: e.bankName ?? '',
                              description: e.bankAccountHolderName,
                            );
                          }),
                        ],
                        initialSelectedIndex: widget.chosenBank != null
                            ? bankList.indexWhere((bank) {
                                return bank.id == widget.chosenBank!.id;
                              })
                            : null,
                        onSelected: (index) {
                          if (index != null) {
                            selectedBankId.value = bankList[index].id;
                            selectedBank.value = bankList[index].bankName;
                            widget.chosenBank = bankList[index];
                          }
                        },
                      ),
                      gapHeight32,
                      Visibility(
                        visible: bankList.length < 2,
                        child: SecondaryButton(
                          height: 32.h,
                          onTap: () {
                            Navigator.pushNamed(
                                context, CustomRouter.corporateAddEditBank,
                                arguments: CorporateAddEditBankDetailPage(
                                    corporateClientId:
                                        widget.corporateClientId));
                          },
                          title: 'Add',
                          icon: Image.asset(
                            Assets.images.icons.plus.path,
                            width: 16.w,
                          ),
                        ),
                      )
                    ];
                  },
                  orElse: () =>
                      [const Center(child: CircularProgressIndicator())]),
            ],
          ),
        ));
  }
}
