import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_document.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileDetailsWidget extends HookConsumerWidget {
  final bool allowEdit;
  final Function() onEditTap;
  final String? clientId;

  const ProfileDetailsWidget({
    super.key,
    this.allowEdit = true,
    required this.onEditTap,
    this.clientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      final profile = ref.watch(profileProvider(clientId));

      return profile.when(data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Personal Details', style: AppTextStyle.header3),
                const Spacer(),
                if (allowEdit)
                  AppTextButton(
                    onTap: onEditTap,
                    title: 'Edit',
                  ),
              ],
            ),
            gapHeight16,
            AppInfoContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInfoText(
                    "Full Name (same as User ID)",
                    data.personalDetails.nameDisplay,
                  ),
                  gapHeight16,
                  AppInfoText(
                    "${data.personalDetails?.identityDocumentType ?? "MyKad"} Number",
                    data.personalDetails.identityCardNumberDisplay,
                  ),
                  gapHeight16,
                  AppInfoText(
                    "Date of Birth",
                    data.personalDetails.dobDisplay,
                  ),
                  gapHeight16,
                  AppInfoText("Gender",
                      getValueForKey(data.personalDetails.genderDisplay, ref)),
                  gapHeight16,
                  AppInfoText(
                      "Nationality", data.personalDetails.nationalityDisplay),
                  gapHeight16,
                  AppInfoText(
                      "Residential Status",
                      getValueForKey(
                          data.personalDetails.residentialStatusDisplay, ref)),
                  gapHeight16,
                  AppInfoText(
                      "Marital Status",
                      getValueForKey(
                          data.personalDetails.maritalStatusDisplay, ref)),
                  gapHeight16,
                  AppInfoText(
                    "Mobile Number",
                    '${data.personalDetails.mobileCountryCodeDisplay} ${data.personalDetails.mobileNumberDisplay}',
                  ),
                  gapHeight16,
                  AppInfoText(
                    "Email",
                    data.personalDetails.emailDisplay,
                  ),
                  gapHeight16,
                  AppInfoText(
                    "Agent Referral Code",
                    data.agentDetails?.agentReferralCodeDisplay ?? '',
                  ),
                  gapHeight16,
                  AppInfoText(
                    "Permanent Address",
                    data.personalDetails.fullAddressDisplay,
                  ),
                  gapHeight16,
                  AppInfoText(
                    "Corresponding Address",
                    data.personalDetails.fullCorrespondingAddressDisplay,
                  ),
                  if (data.personalDetails?.correspondingAddress
                          ?.correspondingAddressProofKey !=
                      null) ...[
                    gapHeight16,
                    AppInfoDocument("Proof of Corresponding Address", [
                      NetworkFile(
                          url: data.personalDetails?.correspondingAddress
                                  ?.correspondingAddressProofKey ??
                              '')
                    ]),
                    gapHeight16,
                  ]
                ],
              ),
            ),
          ],
        );
      }, error: (error, stackTrace) {
        return Column(
          children: [
            Text('Personal Details', style: AppTextStyle.header3),
            gapHeight16,
            RichText(
              text: TextSpan(
                style: AppTextStyle.description,
                text: "No details is added.",
                children: const [],
              ),
            )
          ],
        );
      }, loading: () {
        return const CircularProgressIndicator();
      });
    } catch (e) {
      return Text('An error occurred: $e');
    }
  }
}
