import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/banks.dart';
import 'package:citadel_super_app/data/state/bank_list_state.dart';
import 'package:citadel_super_app/project_widget/search_bar/app_search_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<Bank?> showBankSelectionBottomSheet(
  BuildContext context, {
  Bank? selectedBank,
}) async {
  Bank? value = await showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => BankSelectionBottomSheet(
      selectedBank: selectedBank,
    ),
  );
  return value;
}

class BankSelectionBottomSheet extends HookConsumerWidget {
  final Bank? selectedBank;

  const BankSelectionBottomSheet({super.key, this.selectedBank});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Banks banksVM = ref.read(bankListProvider);
    final searchValueNotifier = useState('');
    final textEditController = useTextEditingController();
    Map<dynamic, List<Bank>> filteredBankMap = {};

    textEditController.addListener(() {
      String searchValue = textEditController.value.text.toLowerCase().trim();
      searchValueNotifier.value = searchValue;
    });

    useEffect(() {
      banksVM.bankList?.sort((a, b) => a.bankName!.compareTo(b.bankName!));
      if (searchValueNotifier.value.isEmpty) {
        filteredBankMap =
            groupBy(banksVM.bankList!, (Bank bank) => bank.bankName![0]);
      } else {
        final filteredBankList = banksVM.bankList!.where((element) => element
            .bankName!
            .toLowerCase()
            .trim()
            .contains(searchValueNotifier.value));
        filteredBankMap =
            groupBy(filteredBankList, (Bank bank) => bank.bankName![0]);
      }
      filteredBankMap = {...filteredBankMap};
      if (filteredBankMap.isEmpty) {
        filteredBankMap = {
          'New Bank': [Bank(bankName: 'New Bank')],
          ...filteredBankMap
        };
      }
      return;
    });

    return SafeArea(
      child: SizedBox(
        height: 0.9.sh,
        child: Column(
          children: [
            gapHeight32,
            Text(
              'Select a bank',
              style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
            ),
            AppSearchBar(
              controller: textEditController,
            ),
            Flexible(
              child: GroupListView(
                physics: const BouncingScrollPhysics(),
                sectionsCount: filteredBankMap.keys.length,
                groupHeaderBuilder: (BuildContext context, int section) {
                  return Container(
                    color: AppColor.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                    child: Text(
                      filteredBankMap.keys.elementAt(section),
                      style: AppTextStyle.label
                          .copyWith(color: AppColor.labelBlack),
                    ),
                  );
                },
                countOfItemInSection: (int sectionIndex) =>
                    filteredBankMap.values.elementAt(sectionIndex).length,
                itemBuilder: (BuildContext context, IndexPath index) {
                  Bank bank = filteredBankMap.values
                      .elementAt(index.section)
                      .elementAt(index.index);
                  final bool isSelected =
                      bank.bankName == selectedBank?.bankName;

                  return Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (bank.bankName == 'New Bank') {
                            Navigator.pop(
                                context,
                                Bank(
                                  bankName: textEditController.text,
                                ));
                            return;
                          }
                          Navigator.pop(context, bank);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 24.w,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(bank.bankName ?? '',
                                    style: isSelected
                                        ? AppTextStyle.header3
                                            .copyWith(color: AppColor.mainBlack)
                                        : AppTextStyle.bodyText.copyWith(
                                            color: AppColor.mainBlack)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  bank.swiftCode ?? '',
                                  style: isSelected
                                      ? AppTextStyle.header3
                                          .copyWith(color: AppColor.mainBlack)
                                      : AppTextStyle.bodyText
                                          .copyWith(color: AppColor.mainBlack),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
