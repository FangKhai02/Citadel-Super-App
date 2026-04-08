import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/state/agent_profile_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/agent_personal_details_vo.dart';
import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/extension/agent_detail_extension.dart';
import 'package:citadel_super_app/extension/agent_profile_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/mixin/profile_image_mixin.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/screen/profile/account_deletion_request_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_agent_detail_page.dart';
import 'package:citadel_super_app/screen/profile/add_edit_bank_detail_page.dart';
import 'package:citadel_super_app/screen/profile/bank_list_page.dart';
import 'package:citadel_super_app/screen/profile/profile_bank_detail_page.dart';
import 'package:citadel_super_app/screen/profile/profile_image_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:citadel_super_app/extension/string_extension.dart';

class AgentProfilePage extends HookConsumerWidget with ProfileImageMixin {
  const AgentProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(agentProfileFutureProvider);
    final banks = ref.watch(bankProvider(null));

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      onRefresh: () async {
        // ignore: unused_result
        await ref.refresh(agentProfileFutureProvider.future);
        // ignore: unused_result
        await ref.refresh(bankProvider(null).future);
      },
      appBar: const CitadelAppBar(
        title: 'My Profile',
        backgroundColor: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 100),
        child: Column(
          children: [
            profile.when(data: (data) {
              return Column(
                children: [
                  profileImage(context, data.personalDetails),
                  gapHeight32,
                  profileDetails(context, data.personalDetails),
                  gapHeight32,
                  banks.maybeWhen(data: (data) {
                    return bankDetails(context, data);
                  }, orElse: () {
                    return const CircularProgressIndicator();
                  }),
                  gapHeight32,
                  agentDetails(context, data.agentDetails),
                  gapHeight32,
                  AppTextButton(
                      title: "Delete my account",
                      textStyle: AppTextStyle.action
                          .copyWith(color: AppColor.errorRed),
                      onTap: () => Navigator.pushNamed(
                          context, CustomRouter.accountDeletion,
                          arguments: AccountDeletionRequestPage(
                            accountName:
                                data.personalDetails?.nameDisplay ?? '',
                            mobileNumber:
                                data.personalDetails?.mobileNumberDisplay ?? '',
                            mobileCountryCode:
                                data.personalDetails?.mobileCountryCode ?? '',
                          ))),
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

  Widget noItems(String title, {required Function() onTap}) {
    return RichText(
      text: TextSpan(
        style: AppTextStyle.description,
        text: "$title ",
        children: [
          TextSpan(
              text: 'Add Now',
              style: AppTextStyle.action.copyWith(
                color: AppColor.brightBlue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap),
        ],
      ),
    );
  }

  Widget profileImage(BuildContext context, AgentPersonalDetailsVo? user) {
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
                  selectPhoto(context, UserType.agent);
                } else {
                  Navigator.pushNamed(
                    getAppContext() ?? context,
                    CustomRouter.profileImage,
                    arguments: ProfileImagePage(
                      profileImage: profilePicture,
                      isPreview: true,
                      type: UserType.agent,
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
            selectPhoto(context, UserType.agent);
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

  Widget profileDetails(BuildContext context, AgentPersonalDetailsVo? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Personal Details', style: AppTextStyle.header3),
            const Spacer(),
            AppTextButton(
              title: 'Edit',
              onTap: () {
                Navigator.pushNamed(context, CustomRouter.agentProfileEdit);
              },
            ),
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: user.isNew
              ? noItems("No details is added.", onTap: () {
                  Navigator.pushNamed(context, CustomRouter.agentProfileEdit);
                })
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInfoText("Full Name", user.nameDisplay),
                    gapHeight16,
                    AppInfoText(
                        "${user?.identityDocumentType ?? "MyKad"} Number",
                        user.identityCardNumberDisplay),
                    gapHeight16,
                    AppInfoText("Date of Birth", user.dobDisplay),
                    gapHeight16,
                    AppInfoText("Address", user.fullAddressDisplay),
                    gapHeight16,
                    AppInfoText("Mobile Number", user.fullMobileNumberDisplay),
                    gapHeight16,
                    AppInfoText("Email", user.emailDisplay),
                  ],
                ),
        ),
      ],
    );
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
            AppTextButton(
              title: 'Add New',
              onTap: () {
                Navigator.pushNamed(context, CustomRouter.bankList,
                    arguments: const BankListPage());
              },
            )
          ],
        ),
        gapHeight16,
        AppInfoContainer(
          child: bankList.isEmpty
              ? noItems(
                  "No Bank Details was added.",
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.addEditBankDetail,
                        arguments: AddEditBankDetailPage());
                  },
                )
              : Column(
                  children: bankList
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                CustomRouter.clientProfileBank,
                                arguments: ProfileBankDetailPage(
                                  bank: CommonBankDetails.fromClientBankDetails(
                                      e),
                                ),
                              );
                            },
                            child: WhiteBorderContainer(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.bankName.defaultDisplay,
                                            style: AppTextStyle.header3),
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        )
      ],
    );
  }

  Widget agentDetails(BuildContext context, AgentVo? agent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Agent', style: AppTextStyle.header3),
        gapHeight16,
        AppInfoContainer(
          color: AppColor.cyan.withOpacity(0.2),
          child: agent.isNew
              ? noItems('No agent is assign.', onTap: () {
                  Navigator.pushNamed(context, CustomRouter.addEditAgentDetail,
                      arguments: AddEditAgentDetailPage());
                })
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child:
                                AppInfoText("Agent ID", agent.agentIdDisplay)),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: agent.agentIdDisplay));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copied to clipboard'),
                              ),
                            );
                          },
                          child: Image.asset(Assets.images.icons.copy.path,
                              width: 20.w, height: 20.w),
                        )
                      ],
                    ),
                    gapHeight16,
                    Row(
                      children: [
                        Expanded(
                            child: AppInfoText("Agent Referral Code",
                                agent.agentReferralCodeDisplay)),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                text: agent.agentReferralCodeDisplay));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Copied to clipboard'),
                              ),
                            );
                          },
                          child: Image.asset(Assets.images.icons.copy.path,
                              width: 20.w, height: 20.w),
                        )
                      ],
                    ),
                    gapHeight16,
                    AppInfoText("Agent Role", agent.agentRoleDisplay),
                    gapHeight16,
                    AppInfoText("Agent Type", agent.agentTypeDisplay),
                    gapHeight16,
                    AppInfoText("Agency ID", agent.agencyIdDisplay),
                    gapHeight16,
                    AppInfoText("Recruitment Manager ID",
                        agent.recruitmentManagerIdDisplay),
                    gapHeight16,
                    AppInfoText("Recruitment Manager Name",
                        agent.recruitmentManagerNameDisplay),
                  ],
                ),
        ),
      ],
    );
  }
}
