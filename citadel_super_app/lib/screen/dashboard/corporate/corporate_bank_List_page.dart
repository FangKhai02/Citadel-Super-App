import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_bank_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_bank_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateBankListPage extends HookConsumerWidget {
  const CorporateBankListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banks = ref.watch(corporateBankProvider(null));

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Edit your details'),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        child: PrimaryButton(
          onTap: () {
            Navigator.pop(context);
          },
          title: 'Confirm',
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Bank Details', style: AppTextStyle.header1),
          ...?banks.whenOrNull(data: (bankList) {
            return [
              gapHeight12,
              Text(
                '${bankList.length} banks added.',
                style: AppTextStyle.description,
              )
            ];
          }),
          gapHeight32,
          ...banks.maybeWhen(data: (bankList) {
            return [
              ...bankList.map(
                (e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      CorporateRepository corporateRepository =
                          CorporateRepository();
                      corporateRepository
                          .getCorporateBankById(e.id!)
                          .baseThen(context, onResponseSuccess: (data) {
                        Navigator.pushNamed(
                            context, CustomRouter.corporateBankDetail,
                            arguments: CorporateBankDetailPage(
                                bank: CommonBankDetails.fromClientBankDetails(
                                    data)));
                      });
                    },
                    child: WhiteBorderContainer(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.bankName.defaultDisplay,
                                    style: AppTextStyle.header3),
                                gapHeight8,
                                Text(e.bankAccountHolderName.defaultDisplay,
                                    style: AppTextStyle.description),
                              ],
                            ),
                          ),
                          Image.asset(
                            Assets.images.icons.right.path,
                            width: 24,
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              gapHeight32,
              Visibility(
                visible: bankList.length < 2,
                child: SecondaryButton(
                  height: 32.h,
                  onTap: () {
                    Navigator.pushNamed(
                        context, CustomRouter.corporateAddEditBank,
                        arguments: CorporateAddEditBankDetailPage());
                  },
                  title: 'Add',
                  icon: Image.asset(
                    Assets.images.icons.plus.path,
                    width: 16.w,
                  ),
                ),
              )
            ];
          }, orElse: () {
            return [const Center(child: CircularProgressIndicator())];
          }),
        ]),
      ),
    );
  }
}
