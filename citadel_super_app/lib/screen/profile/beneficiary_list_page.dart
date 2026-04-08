import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/profile/profile_beneficiary_detail_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BeneficiaryListPage extends HookConsumerWidget {
  const BeneficiaryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beneficiaryList = ref.watch(beneficiariesProvider(null));

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Edit your details'),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        child: PrimaryButton(
          onTap: beneficiaryList.whenOrNull(data: (data) {
            return () {
              Navigator.pop(context);
            };
          }),
          title: 'Confirm',
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Beneficiary', style: AppTextStyle.header1),
            gapHeight32,
            ...beneficiaryList.maybeWhen(
              data: (data) {
                return [
                  ...data.map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CustomRouter.clientProfileBeneficiary,
                            arguments:
                                ProfileBeneficiaryDetailPage(beneficiary: e),
                          );
                        },
                        child: WhiteBorderContainer(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.fullName.defaultDisplay,
                                        style: AppTextStyle.header3),
                                    gapHeight8,
                                    Text(e.relationshipToSettlor.defaultDisplay,
                                        style: AppTextStyle.description),
                                    gapHeight8,
                                    if (e.guardian?.id != null)
                                      Text(
                                          'Guardian: ${e.guardian!.fullName.defaultDisplay}',
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
                  )
                ];
              },
              orElse: () => [const Center(child: CircularProgressIndicator())],
            ),
            gapHeight24,
            beneficiaryList.maybeWhen(
              data: (data) {
                return Visibility(
                  visible: data.length < 10,
                  child: SecondaryButton(
                    height: 32.h,
                    onTap: () {
                      Navigator.pushNamed(context, CustomRouter.document,
                          arguments: DocumentPage(
                        onConfirm: () {
                          Navigator.pushNamed(
                              context, CustomRouter.addEditBeneficiary,
                              arguments: AddEditBeneficiaryPage());
                        },
                      ));
                    },
                    title: 'Add',
                    icon: Image.asset(
                      Assets.images.icons.plus.path,
                      width: 16.w,
                    ),
                  ),
                );
              },
              orElse: () => const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
