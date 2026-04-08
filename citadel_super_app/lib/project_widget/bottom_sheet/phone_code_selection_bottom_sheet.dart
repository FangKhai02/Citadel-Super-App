import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/country_code.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/project_widget/search_bar/app_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

Future<CountryCodes?> showCountrySelectionBottomSheet(
  BuildContext context, {
  CountryCodes? selectedCountry,
}) async {
  CountryCodes? value = await showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => PhoneCodeSelectionBottomSheet(
      selectedCode: selectedCountry,
    ),
  );
  return value;
}

class PhoneCodeSelectionBottomSheet extends HookConsumerWidget {
  final CountryCodes? selectedCode;

  const PhoneCodeSelectionBottomSheet({
    super.key,
    required this.selectedCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CountryCode countryCodeVM = ref.read(countryCodeProvider);

    final searchValueNotifier = useState('');
    final textEditController = useTextEditingController();
    Map<dynamic, List<CountryCodes>> filteredCountryCodesMap = {};

    textEditController.addListener(() {
      String searchValue = textEditController.value.text.toLowerCase().trim();
      searchValueNotifier.value = searchValue;
    });

    useEffect(() {
      if (searchValueNotifier.value.isEmpty) {
        filteredCountryCodesMap = groupBy(countryCodeVM.countryCodes!,
            (CountryCodes countryCodes) => countryCodes.countryName![0]);
      } else {
        final filteredCountryCodes = countryCodeVM.countryCodes!.where(
            (element) => element.countryName!
                .toLowerCase()
                .trim()
                .contains(searchValueNotifier.value));
        filteredCountryCodesMap = groupBy(filteredCountryCodes,
            (CountryCodes countryCodes) => countryCodes.countryName![0]);
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
              'Select a country',
              style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
            ),
            AppSearchBar(
              controller: textEditController,
            ),
            Flexible(
              child: GroupListView(
                physics: const BouncingScrollPhysics(),
                sectionsCount: filteredCountryCodesMap.keys.length,
                groupHeaderBuilder: (BuildContext context, int section) {
                  return Container(
                    color: AppColor.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                    child: Text(
                      filteredCountryCodesMap.keys.elementAt(section),
                      style: AppTextStyle.label
                          .copyWith(color: AppColor.labelBlack),
                    ),
                  );
                },
                countOfItemInSection: (int sectionIndex) =>
                    filteredCountryCodesMap.values
                        .elementAt(sectionIndex)
                        .length,
                itemBuilder: (BuildContext context, IndexPath index) {
                  CountryCodes countryCode = filteredCountryCodesMap.values
                      .elementAt(index.section)
                      .elementAt(index.index);
                  final bool isSelected =
                      countryCode.countryCode == selectedCode?.countryCode;

                  return Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.pop(context, countryCode),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 24.w,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(countryCode.countryName ?? '',
                                    style: isSelected
                                        ? AppTextStyle.header3
                                            .copyWith(color: AppColor.mainBlack)
                                        : AppTextStyle.bodyText.copyWith(
                                            color: AppColor.mainBlack)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  countryCode.diallingCode ?? '',
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
