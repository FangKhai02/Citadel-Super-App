// ignore_for_file: unused_result

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/corporate_shareholder_state.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_base_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_client_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_details_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_base_vo.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/mixin/profile_image_mixin.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/screen/company/company_details_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_details_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_info_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_page.dart';
import 'package:citadel_super_app/screen/company/wealth_source_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_bank_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_bank_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_beneficiary_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_select_guardian_page.dart';
import 'package:citadel_super_app/screen/fund/component/profile_details_widget.dart';
import 'package:citadel_super_app/screen/profile/profile_image_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateProfilePage extends HookConsumerWidget with ProfileImageMixin {
  final String? corporateClientId;
  const CorporateProfilePage({super.key, this.corporateClientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(corporateProfileProvider(corporateClientId));
    final banks = ref.watch(corporateBankProvider(corporateClientId));
    final beneficiaries =
        ref.watch(corporateBeneficiaryProvider(corporateClientId));

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      onRefresh: () async {
        await ref.refresh(corporateProfileProvider(corporateClientId).future);
        await ref.refresh(corporateBankProvider(corporateClientId).future);
        await ref
            .refresh(corporateBeneficiaryProvider(corporateClientId).future);
        await ref.refresh(shareholdersProvider.future);
      },
      appBar: const CitadelAppBar(
        title: 'Profile',
        backgroundColor: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 100),
        child: Column(
          children: [
            profile.when(data: (data) {
              return Column(
                children: [
                  profileImage(context, data.corporateClient),
                  if (corporateClientId == null) ...[
                    gapHeight32,
                    ProfileDetailsWidget(
                      allowEdit: false,
                      onEditTap: () {},
                    ),
                  ],
                  gapHeight32,
                  corporateDetails(context, data.corporateDetails, ref),
                  gapHeight32,
                  shareHolderDetails(
                      context, data.bindedCorporateShareholders, ref),
                  gapHeight32,
                  wealthSource(context, data.corporateClient, ref),
                  gapHeight32,
                  banks.maybeWhen(data: (data) {
                    return bankDetails(context, data);
                  }, orElse: () {
                    return const CircularProgressIndicator();
                  }),
                  gapHeight32,
                  beneficiaries.maybeWhen(data: (data) {
                    return beneficialDetails(context, data, ref);
                  }, orElse: () {
                    return const CircularProgressIndicator();
                  }),
                ],
              );
            }, error: (e, s) {
              return Center(
                child: Text(
                  'Something Went Wrong',
                  style: AppTextStyle.bodyText,
                ),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget corporateShareHolderPlaceHolder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Shareholder Details',
                style: AppTextStyle.header3,
              ),
            ),
            const Spacer(),
            AppTextButton(
              title: 'Add New',
              onTap: () {
                Navigator.pushNamed(context, CustomRouter.shareHolderDetails,
                    arguments: const ShareHolderDetailsPage());
              },
            )
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: noItems(context, "No share holder was added.", onTap: () {
            Navigator.pushNamed(context, CustomRouter.shareHolderDetails,
                arguments: const ShareHolderDetailsPage());
          }),
        ),
      ],
    );
  }

  Widget noItems(BuildContext context, String title,
      {required Function() onTap}) {
    return RichText(
      textScaler: MediaQuery.of(context)
          .textScaler
          .clamp(minScaleFactor: 1, maxScaleFactor: 1.4),
      text: TextSpan(
        style: AppTextStyle.description,
        text: "$title ",
        children: corporateClientId == null
            ? [
                TextSpan(
                    text: 'Add Now',
                    style: AppTextStyle.action.copyWith(
                      color: AppColor.brightBlue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap),
              ]
            : [],
      ),
    );
  }

  Widget profileImage(BuildContext context, CorporateClientVo? user) {
    final profilePicture = user?.profilePicture ?? '';

    return Image.network(
      profilePicture,
      width: 128.w,
      height: 128.w,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(64.r), child: child),
            GestureDetector(
              onTap: () async {
                if (profilePicture.isEmpty) {
                  selectPhoto(context, UserType.corporate);
                } else {
                  Navigator.pushNamed(
                    getAppContext() ?? context,
                    CustomRouter.profileImage,
                    arguments: ProfileImagePage(
                      profileImage: profilePicture,
                      isPreview: true,
                      type: UserType.corporate,
                    ),
                  );
                }
              },
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColor.brightBlue,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return GestureDetector(
          onTap: () async {
            selectPhoto(context, UserType.corporate);
          },
          child: Container(
            width: 128.w,
            height: 128.w,
            decoration: BoxDecoration(
              color: AppColor.popupGray,
              borderRadius: BorderRadius.circular(64.r),
            ),
            child: Center(
              child: Icon(
                Icons.photo_camera_outlined,
                size: 48.w,
                color: AppColor.brightBlue,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget corporateDetails(BuildContext context,
      CorporateDetailsVo? corporateDetails, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Company Details', style: AppTextStyle.header3),
            const Spacer(),
            Visibility(
              visible: corporateClientId == null,
              child: AppTextButton(
                title: 'Edit',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.companyDetails,
                      arguments: CompanyDetailsPage(
                        isEdit: true,
                        corporateDetail: corporateDetails,
                      ));
                },
              ),
            ),
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppInfoText("Name of Entity", corporateDetails.entityNameDisplay),
              gapHeight16,
              AppInfoText("Type of Entity",
                  getValueForKey(corporateDetails.entityTypeDisplay, ref)),
              gapHeight16,
              AppInfoText("Registration Number",
                  corporateDetails.registrationNumberDisplay),
              gapHeight16,
              AppInfoText("Date of Incorporation",
                  corporateDetails.dateIncorporateDisplay),
              gapHeight16,
              AppInfoText("Place of Incorporation",
                  corporateDetails.placeIncorporateDisplay),
              gapHeight16,
              AppInfoText("Business Type",
                  getValueForKey(corporateDetails.businessTypeDisplay, ref)),
              gapHeight16,
              AppInfoText("Registered Address",
                  corporateDetails.fullRegisteredAddressDisplay),
              gapHeight16,
              AppInfoText(
                  "Business Address",
                  corporateDetails?.corporateAddressDetails
                              ?.isDifferentRegisteredAddress ==
                          true
                      ? corporateDetails.fullBusinessAddressDisplay
                      : corporateDetails.fullRegisteredAddressDisplay),
              gapHeight16,
              AppInfoText("Primary Contact Person Name",
                  corporateDetails.contactNameDisplay),
              gapHeight16,
              AppInfoText("Primary Contact Designation",
                  corporateDetails.contactDesignationDisplay),
              gapHeight16,
              AppInfoText("Primary Contact Mobile Number",
                  corporateDetails.fullMobileDisplay),
              gapHeight16,
              AppInfoText("Primary Contact Email",
                  corporateDetails.contactEmailDisplay),
            ],
          ),
        ),
      ],
    );
  }

  Widget shareHolderDetails(BuildContext context,
      List<CorporateShareholderBaseVo>? shareholders, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Shareholder Details',
              style: AppTextStyle.header3,
            )),
            Visibility(
              visible: corporateClientId == null,
              child: AppTextButton(
                title: (shareholders ?? []).length < 5 ? 'Add New' : '',
                onTap: () {
                  globalRef.invalidate(corporateShareholderProvider);
                  Navigator.pushNamed(context, CustomRouter.shareHolderDetails,
                      arguments: const ShareHolderDetailsPage());
                  // Navigator.pushNamed(context, CustomRouter.document,
                  //     arguments: DocumentPage(
                  //         title: 'Scan Share Holder ID',
                  //         onConfirm: () {
                  //           Navigator.pushReplacementNamed(
                  //               context, CustomRouter.shareHolder,
                  //               arguments: ShareHolderPage());
                  //         }));
                },
              ),
            )
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: (shareholders ?? []).isEmpty
              ? noItems(
                  context,
                  "No Shareholder was added.",
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.document,
                        arguments: DocumentPage(
                            title: 'Scan Share Holder ID',
                            onConfirm: () {
                              Navigator.pushReplacementNamed(
                                  context, CustomRouter.shareHolder,
                                  arguments: ShareHolderPage());
                            }));
                  },
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(shareholders ?? []).length} Share Holders added.',
                      style: AppTextStyle.description,
                    ),
                    gapHeight8,
                    ...(shareholders ?? []).asMap().entries.map((entry) {
                      final index = entry.key;
                      final shareholder = entry.value;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: GestureDetector(
                          onTap: () {
                            CorporateRepository corporateRepository =
                                CorporateRepository();
                            final referenceNumber =
                                ref.read(corporateRefProvider);
                            corporateRepository
                                .getShareholderById(
                                    shareholder.id ?? 0, referenceNumber ?? '')
                                .baseThen(context, onResponseSuccess: (data) {
                              Navigator.pushNamed(
                                  context, CustomRouter.shareHolderInfo,
                                  arguments: ShareHolderInfoPage(
                                    shareholder: data,
                                    no: index,
                                    isEditFromProfile: true,
                                  ));
                            }, onResponseError: (e, s) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: AppColor.errorRed,
                                      content: Text(e.message)));
                            });
                          },
                          child: WhiteBorderContainer(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shareholder.name ?? '',
                                        style: AppTextStyle.header3,
                                      ),
                                      Text(
                                        'ShareHolder ${index + 1}',
                                        style: AppTextStyle.description,
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  Assets.images.icons.right.path,
                                  width: 24,
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
        ),
      ],
    );
  }

  Widget wealthSource(
      BuildContext context, CorporateClientVo? wealthSource, WidgetRef ref) {
    return Column(children: [
      Row(
        children: [
          Text('Wealth Source', style: AppTextStyle.header3),
          const Spacer(),
          Visibility(
            visible: corporateClientId == null,
            child: AppTextButton(
              title: 'Edit',
              onTap: () {
                Navigator.pushNamed(context, CustomRouter.wealthSource,
                    arguments: WealthSourcePage(
                      initialIncome: wealthSource?.annualIncomeDeclaration,
                      initialSource: wealthSource?.sourceOfIncome,
                      onConfirm: (annualIncome, sourceOfIncome) {
                        CorporateRepository corporateRepository =
                            CorporateRepository();
                        corporateRepository
                            .editCorporateWealthSource(
                                annualIncome, sourceOfIncome)
                            .baseThen(context, onResponseSuccess: (_) {
                          ref.invalidate(corporateProfileProvider);
                          Navigator.pop(context);
                        });
                      },
                    ));
              },
            ),
          ),
        ],
      ),
      gapHeight16,
      AppInfoContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInfoText(
                "Annual Income Declared",
                getValueForKey(
                    wealthSource.annualIncomeDeclarationDisplay, ref)),
            gapHeight16,
            AppInfoText("Source of Income",
                getValueForKey(wealthSource.sourceofIncomeDisplay, ref)),
          ],
        ),
      ),
    ]);
  }

  Widget bankDetails(BuildContext context, List<BankDetailsVo> bankList) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Bank Details',
              style: AppTextStyle.header3,
            )),
            Visibility(
              visible: corporateClientId == null,
              child: AppTextButton(
                title: 'Edit',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.corporateBankList);
                },
              ),
            )
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: bankList.isEmpty
              ? noItems(
                  context,
                  "No Bank Details was added.",
                  onTap: () {
                    Navigator.pushNamed(
                        context, CustomRouter.corporateAddEditBank,
                        arguments: CorporateAddEditBankDetailPage());
                  },
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${bankList.length} Bank Details added.',
                      style: AppTextStyle.description),
                  gapHeight8,
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
                                    bank:
                                        CommonBankDetails.fromClientBankDetails(
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
                ]),
        )
      ],
    );
  }

  Widget beneficialDetails(BuildContext context,
      List<CorporateBeneficiaryBaseVo> beneficiaryList, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Beneficiary',
              style: AppTextStyle.header3,
            )),
            Visibility(
              visible: corporateClientId == null,
              child: AppTextButton(
                title: beneficiaryList.length < 5 ? 'Add New' : '',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.document,
                      arguments: DocumentPage(
                        title: 'Scan Beneficiary ID',
                        onConfirm: () {
                          Navigator.pushReplacementNamed(
                              context, CustomRouter.corporateAddEditBeneficiary,
                              arguments: CorporateAddEditBeneficiaryPage());
                        },
                      ));
                },
              ),
            )
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: beneficiaryList.isEmpty
              ? noItems(context, "No beneficiary was added.", onTap: () {
                  Navigator.pushNamed(context, CustomRouter.document,
                      arguments: DocumentPage(
                        title: 'Scan Beneficiary ID',
                        onConfirm: () {
                          Navigator.pushReplacementNamed(
                              context, CustomRouter.corporateAddEditBeneficiary,
                              arguments: CorporateAddEditBeneficiaryPage());
                        },
                      ));
                })
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${beneficiaryList.length} Beneficiaries added.',
                      style: AppTextStyle.description),
                  gapHeight8,
                  ...beneficiaryList.map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          if (e.corporateGuardianVo == null &&
                              e.isUnderAge == true) {
                            Navigator.pushNamed(
                                context, CustomRouter.corporateSelectGuardian,
                                arguments: CorporateSelectGuardianPage(
                                  beneficiaryId: e.corporateBeneficiaryId!,
                                ));
                          } else {
                            CorporateRepository corporateRepository =
                                CorporateRepository();
                            corporateRepository
                                .getCorporateBeneficiaryById(
                                    e.corporateBeneficiaryId)
                                .baseThen(context, onResponseSuccess: (data) {
                              Navigator.pushNamed(
                                context,
                                CustomRouter.corporateBeneficiaryDetail,
                                arguments: CorporateBeneficiaryDetailPage(
                                  beneficiary: data,
                                  guardian: e.corporateGuardianVo,
                                ),
                              );
                            });
                          }
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
                                    Text(
                                        getValueForKey(
                                            e.relationshipToSettlor
                                                .defaultDisplay,
                                            ref),
                                        style: AppTextStyle.description),
                                    if (e.isUnderAge ?? false) ...[
                                      gapHeight8,
                                      Text(
                                          "Guardian: ${(e.corporateGuardianVo?.fullName ?? '').defaultDisplay}",
                                          style: AppTextStyle.description),
                                    ]
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
                ]),
        )
      ],
    );
  }
}
