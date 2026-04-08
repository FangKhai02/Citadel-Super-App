// ignore_for_file: unused_result

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/response/client_profile_response_vo.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/state/update_state.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/data/vo/client_agent_details_vo.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/app_info_document.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/company/wealth_source_page.dart';
import 'package:citadel_super_app/screen/fund/component/profile_details_widget.dart';
import 'package:citadel_super_app/screen/profile/account_deletion_request_page.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_beneficiary_page.dart';
import 'package:citadel_super_app/screen/profile/agent/add_edit_pep_page.dart';
import 'package:citadel_super_app/screen/profile/bank_list_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_bank_detail_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_employment_detail_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_personal_detail_page.dart';
import 'package:citadel_super_app/screen/profile/profile_bank_detail_page.dart';
import 'package:citadel_super_app/screen/profile/profile_beneficiary_detail_page.dart';
import 'package:citadel_super_app/screen/profile/profile_image_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:citadel_super_app/screen/universal/select_guardian_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../custom_router.dart';
import '../../data/vo/client_personal_details_vo.dart';
import '../../generated/assets.gen.dart';
import '../../mixin/profile_image_mixin.dart';
import '../../project_widget/appbar/citadel_app_bar.dart';
import '../../project_widget/container/white_border_container.dart';

class ProfilePage extends HookConsumerWidget with ProfileImageMixin {
  String? clientId;
  ProfilePage({super.key, this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider(clientId));
    final beneficiaries = ref.watch(beneficiariesProvider(clientId));
    final banks = ref.watch(bankProvider(clientId));

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      onRefresh: () async {
        await ref.refresh(profileProvider(clientId).future);
        await ref.refresh(beneficiariesProvider(clientId).future);
        await ref.refresh(bankProvider(clientId).future);
      },
      appBar: const CitadelAppBar(
        title: 'Profile',
        backgroundColor: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            profile.when(data: (data) {
              return Column(
                children: [
                  profileImage(context, data.personalDetails),
                  gapHeight32,
                  data.personalDetails != null
                      ? ProfileDetailsWidget(
                          allowEdit: clientId == null,
                          onEditTap: () {
                            Navigator.pushNamed(
                                context, CustomRouter.editPersonalDetail,
                                arguments: EditPersonalDetailPage(user: data));
                          },
                          clientId: clientId,
                        )
                      : noItems(
                          context,
                          "No details is added.",
                          onTap: () {
                            Navigator.pushNamed(
                                context, CustomRouter.editPersonalDetail,
                                arguments: EditPersonalDetailPage(user: data));
                          },
                        ),
                  gapHeight32,
                  pepDetails(context, data, ref),
                  gapHeight32,
                  employmentDetails(context, data, ref),
                  gapHeight32,
                  wealthDetails(context, data, ref),
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
                  gapHeight32,
                  agentDetails(context, data.agentDetails),
                  gapHeight32,
                  Visibility(
                    visible: clientId == null,
                    child: AppTextButton(
                        title: "Delete my account",
                        textStyle: AppTextStyle.action
                            .copyWith(color: AppColor.errorRed),
                        onTap: () => Navigator.pushNamed(
                            context, CustomRouter.accountDeletion,
                            arguments: AccountDeletionRequestPage(
                              accountName:
                                  data.personalDetails?.nameDisplay ?? '',
                              mobileNumber:
                                  data.personalDetails?.mobileNumberDisplay ??
                                      '',
                              mobileCountryCode: data.personalDetails
                                      ?.mobileCountryCodeDisplay ??
                                  '',
                            ))),
                  ),
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

  Widget noItems(BuildContext context, String title,
      {required Function() onTap}) {
    return RichText(
      textScaler: MediaQuery.of(context)
          .textScaler
          .clamp(minScaleFactor: 1, maxScaleFactor: 1.4),
      text: TextSpan(
        style: AppTextStyle.description,
        text: "$title ",
        children: clientId == null
            ? [
                TextSpan(
                    text: 'Add Now',
                    style: AppTextStyle.action.copyWith(
                      color: AppColor.brightBlue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap),
              ]
            : null,
      ),
    );
  }

  Widget profileImage(BuildContext context, ClientPersonalDetailsVo? user) {
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
            Visibility(
              visible: clientId == null,
              child: GestureDetector(
                onTap: () async {
                  if (profilePicture.isEmpty) {
                    selectPhoto(context, UserType.client);
                  } else {
                    Navigator.pushNamed(
                      getAppContext() ?? context,
                      CustomRouter.profileImage,
                      arguments: ProfileImagePage(
                        profileImage: profilePicture,
                        isPreview: true,
                        type: UserType.client,
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
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return GestureDetector(
          onTap: clientId == null
              ? () async {
                  selectPhoto(context, UserType.client);
                }
              : null,
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

  Widget pepDetails(
      BuildContext context, ClientProfileResponseVo? user, WidgetRef ref) {
    final bool isPep = user?.pepDeclaration?.isPep ?? false;

    return Column(
      children: [
        Row(
          children: [
            Text('PEP Status', style: AppTextStyle.header3),
            const Spacer(),
            Visibility(
              visible: clientId == null,
              child: AppTextButton(
                title: 'Edit',
                onTap: () {
                  globalRef.invalidate(updateProvider);
                  Navigator.pushNamed(context, CustomRouter.addEditPepPage,
                      arguments: AddEditPepPage(user: user));
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
                "PEP",
                isPep
                    ? "Yes - ${getValueForKey(user?.pepDeclaration?.pepDeclarationOptions?.relationship ?? '', ref)}"
                    : "No",
              ),
              if (isPep &&
                  !(user?.pepDeclaration?.pepDeclarationOptions?.relationship ??
                          '')
                      .equalsIgnoreCase('SELF')) ...[
                gapHeight16,
                AppInfoText("Full Name",
                    user?.pepDeclaration?.pepDeclarationOptions?.name ?? ''),
              ],
              gapHeight16,
              AppInfoText(
                "Current Position / Designation",
                user?.pepDeclaration?.pepDeclarationOptions?.position ?? '',
              ),
              gapHeight16,
              AppInfoText(
                "Organisation / Entity",
                user?.pepDeclaration?.pepDeclarationOptions?.organization ?? '',
              ),
              if (user?.pepDeclaration?.pepDeclarationOptions
                      ?.supportingDocument !=
                  null) ...[
                gapHeight16,
                AppInfoDocument(
                  "Supporting Document",
                  [
                    NetworkFile(
                        url: user?.pepDeclaration?.pepDeclarationOptions
                                ?.supportingDocument ??
                            '')
                  ],
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget employmentDetails(
      BuildContext context, ClientProfileResponseVo? user, WidgetRef ref) {
    final employment = user?.employmentDetails;
    return Column(
      children: [
        Row(
          children: [
            Text('Employment Details', style: AppTextStyle.header3),
            const Spacer(),
            Visibility(
              visible: clientId == null,
              child: AppTextButton(
                title: 'Edit',
                onTap: () {
                  Navigator.pushNamed(
                      context, CustomRouter.addEditEmploymentDetail,
                      arguments: AddEditEmploymentDetailPage());
                },
              ),
            ),
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          color: AppColor.cyan.withOpacity(0.2),
          child: employment.isNew
              ? noItems(context, "No employment details added.", onTap: () {
                  Navigator.pushNamed(
                      context, CustomRouter.addEditEmploymentDetail,
                      arguments: AddEditEmploymentDetailPage());
                })
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInfoText("Employment Type",
                        getValueForKey(employment.employmentTypeDisplay, ref)),
                    gapHeight16,
                    AppInfoText(
                        "Name of Employer", employment.employerNameDisplay),
                    gapHeight16,
                    AppInfoText("Industry Type",
                        getValueForKey(employment.industryTypeDisplay, ref)),
                    gapHeight16,
                    AppInfoText("Job Title", employment.jobTitleDisplay),
                    gapHeight16,
                    AppInfoText("Employer Address",
                        employment.employerFullAddressDisplay),
                  ],
                ),
        ),
      ],
    );
  }

  Widget wealthDetails(
      BuildContext context, ClientProfileResponseVo? user, WidgetRef ref) {
    final wealthSource = user?.wealthSourceDetails;
    return Column(children: [
      Row(
        children: [
          Text('Wealth Source', style: AppTextStyle.header3),
          const Spacer(),
          Visibility(
            visible: clientId == null,
            child: AppTextButton(
              title: 'Edit',
              onTap: () {
                Navigator.pushNamed(context, CustomRouter.wealthSource,
                    arguments: WealthSourcePage(
                      initialIncome:
                          wealthSource?.annualIncomeDeclaration ?? '',
                      initialSource: wealthSource?.sourceOfIncome ?? '',
                      onConfirm: (annualIncome, sourceOfIncome) {
                        ClientRepository repo = ClientRepository();
                        final req = ParameterHelper().editProfileParam(
                            {}, user!,
                            annualIncomeDeclaration: annualIncome,
                            sourceOfIncome: sourceOfIncome);
                        repo.editProfile(req).baseThen(
                          context,
                          onResponseSuccess: (_) {
                            final latestContext = getAppContext() ?? context;
                            latestContext
                                .showSuccessSnackBar('Successfully Updated');
                            ref.invalidate(profileProvider);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ));
              },
            ),
          ),
        ],
      ),
      gapHeight16,
      AppInfoContainer(
        child: wealthSource.isNew
            ? noItems(context, "No wealth source is added", onTap: () {
                Navigator.pushNamed(context, CustomRouter.wealthSource,
                    arguments: WealthSourcePage(
                  onConfirm: (annualIncome, sourceOfIncome) {
                    ClientRepository repo = ClientRepository();
                    final req = ParameterHelper().editProfileParam({}, user!,
                        annualIncomeDeclaration: annualIncome,
                        sourceOfIncome: sourceOfIncome);
                    repo.updateProfile(req).baseThen(context,
                        onResponseSuccess: (result) {
                      globalRef.refresh(profileProvider(clientId).future);
                      Navigator.pop(context);
                    });
                  },
                ));
              })
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInfoText(
                      "Annual Income Declared",
                      getValueForKey(
                          wealthSource.annualIncomeDeclarationDisplay, ref)),
                  gapHeight16,
                  AppInfoText("Source of Income",
                      getValueForKey(wealthSource.sourceOfIncomeDisplay, ref)),
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
              visible: clientId == null,
              child: AppTextButton(
                title: 'Edit',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.bankList,
                      arguments: const BankListPage());
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
                    Navigator.pushNamed(context, CustomRouter.addEditBankDetail,
                        arguments: AddEditBankDetailPage());
                  },
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${bankList.length} banks added.',
                      style: AppTextStyle.description),
                  gapHeight8,
                  ...bankList.map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            CustomRouter.clientProfileBank,
                            arguments: ProfileBankDetailPage(
                              allowEdit: clientId == null,
                              bank: CommonBankDetails.fromClientBankDetails(e),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WhiteBorderContainer(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.bankName.defaultDisplay,
                                            style: AppTextStyle.header3),
                                        gapHeight8,
                                        Text(
                                            e.bankAccountHolderName
                                                .defaultDisplay,
                                            style: AppTextStyle.description),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
        ),
      ],
    );
  }

  Widget beneficialDetails(BuildContext context,
      List<IndividualBeneficiaryVo> beneficiaryList, WidgetRef ref) {
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
              visible: clientId == null,
              child: AppTextButton(
                title: beneficiaryList.length < 5 ? 'Add New' : '',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.document,
                      arguments: DocumentPage(
                        title: 'Scan Beneficiary ID',
                        onConfirm: () {
                          Navigator.pushReplacementNamed(
                              context, CustomRouter.addEditBeneficiary,
                              arguments: AddEditBeneficiaryPage(
                                fromProfile: true,
                              ));
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
                          Navigator.pushNamed(
                              context, CustomRouter.addEditBeneficiary,
                              arguments: AddEditBeneficiaryPage(
                                fromProfile: true,
                              ));
                        },
                      ));
                })
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${beneficiaryList.length} beneficiaries added.',
                      style: AppTextStyle.description),
                  gapHeight8,
                  ...beneficiaryList.map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          if (e.isUnderAge == true && e.guardian?.id == null) {
                            Navigator.pushNamed(
                                context, CustomRouter.selectGuardian,
                                arguments: SelectGuardianPage(
                                    beneficiaryId: e.individualBeneficiaryId!,
                                    fromProfile: true));
                          } else {
                            Navigator.pushNamed(
                              context,
                              CustomRouter.clientProfileBeneficiary,
                              arguments: ProfileBeneficiaryDetailPage(
                                  allowEdit: clientId == null,
                                  beneficiary: e,
                                  guardian: e.guardian),
                            );
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
                                          'Guardian: ${(e.guardian?.fullName ?? '').defaultDisplay}',
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
        ),
      ],
    );
  }

  Widget agentDetails(BuildContext context, ClientAgentDetailsVo? agent) {
    return Column(
      children: [
        Row(
          children: [
            Text('Agent', style: AppTextStyle.header3),
            const Spacer(),
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          color: AppColor.cyan.withOpacity(0.2),
          child: agent.isNew
              ? Text(
                  'No agent is assigned',
                  style: AppTextStyle.description,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInfoText("Full Name", agent.agentNameDisplay),
                    gapHeight16,
                    AppInfoText("Agency ID", agent.agencyIdDisplay),
                    gapHeight16,
                    Row(
                      children: [
                        AppInfoText(
                          "Mobile Number",
                          agent.agentFullMobileDisplay,
                        ),
                        const Spacer(),
                        FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.transparent,
                            onPressed: () {
                              final phoneNumber = agent?.agentFullMobileDisplay;
                              if (phoneNumber != null &&
                                  phoneNumber.isNotEmpty) {
                                launchUrlString("tel://$phoneNumber");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("No phone number available")),
                                );
                              }
                            },
                            child: Assets.images.icons.phone.image()),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
