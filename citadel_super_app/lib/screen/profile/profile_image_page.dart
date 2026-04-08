import 'dart:io';
// import 'dart:js_interop_unsafe';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/agent_profile_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/upload_file_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../mixin/profile_image_mixin.dart';

enum UserType {
  client,
  agent,
  corporate;

  Future<void> upload(
      BuildContext context, WidgetRef ref, String profileImage) async {
    switch (this) {
      case UserType.client:
        ClientRepository clientRepository = ClientRepository();

        EasyLoadingHelper.show();
        await clientRepository
            .updateProfileImage(profileImage)
            .baseThen(context, onResponseSuccess: (value) {
          ref.invalidate(profileProvider);
          Navigator.popUntil(
              context,
              (routes) =>
                  routes.settings.name == CustomRouter.clientProfile ||
                  routes.settings.name == CustomRouter.agentProfile);
        }).whenComplete(() => EasyLoadingHelper.dismiss());
        break;
      case UserType.agent:
        AgentRepository agentRepository = AgentRepository();

        EasyLoadingHelper.show();
        await agentRepository
            .updateAgentProfileImage(profileImage)
            .baseThen(context, onResponseSuccess: (_) {
          ref.invalidate(agentProfileFutureProvider);
          Navigator.popUntil(context,
              (routes) => routes.settings.name == CustomRouter.agentProfile);
        }).whenComplete(() => EasyLoadingHelper.dismiss());
        break;
      case UserType.corporate:
        CorporateRepository corporateRepository = CorporateRepository();

        EasyLoadingHelper.show();
        await corporateRepository
            .updateCorporateProfileImage(profileImage)
            .baseThen(context, onResponseSuccess: (_) {
          ref.invalidate(corporateProfileProvider);
          Navigator.popUntil(
              context,
              (routes) =>
                  routes.settings.name == CustomRouter.corporateProfile);
        }).whenComplete(() => EasyLoadingHelper.dismiss());
        break;
    }
  }

  void delete(BuildContext context, WidgetRef ref, String profileImage) {
    switch (this) {
      case UserType.client:
        ClientRepository clientRepository = ClientRepository();
        EasyLoadingHelper.show();
        clientRepository.updateProfileImage(null).baseThen(context,
            onResponseSuccess: (value) {
          ref.invalidate(profileProvider);
          Navigator.popUntil(
              context,
              (routes) =>
                  routes.settings.name == CustomRouter.clientProfile ||
                  routes.settings.name == CustomRouter.agentProfile);
        }).whenComplete(() {
          EasyLoadingHelper.dismiss();
        });
        break;
      case UserType.agent:
        AgentRepository agentRepository = AgentRepository();
        EasyLoadingHelper.show();
        agentRepository.updateAgentProfileImage(null).baseThen(context,
            onResponseSuccess: (value) {
          ref.invalidate(agentProfileFutureProvider);
          Navigator.popUntil(context,
              (routes) => routes.settings.name == CustomRouter.agentProfile);
        }).whenComplete(() {
          EasyLoadingHelper.dismiss();
        });
        break;
      case UserType.corporate:
        CorporateRepository corporateRepository = CorporateRepository();

        EasyLoadingHelper.show();

        corporateRepository.updateCorporateProfileImage(null).baseThen(context,
            onResponseSuccess: (_) {
          ref.invalidate(corporateProfileProvider);
          Navigator.popUntil(
              context,
              (routes) =>
                  routes.settings.name == CustomRouter.corporateProfile);
        }).whenComplete(() => EasyLoadingHelper.dismiss());
        break;
    }
  }

  const UserType();
}

class ProfileImagePage extends StatefulHookConsumerWidget {
  String profileImage;
  bool isPreview;
  final UserType type;

  ProfileImagePage(
      {super.key,
      required this.profileImage,
      this.isPreview = true,
      required this.type});

  @override
  ProfileImageState createState() => ProfileImageState();
}

class ProfileImageState extends ConsumerState<ProfileImagePage>
    with ProfileImageMixin {
  final ClientRepository clientRepository = ClientRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.mainBlack,
        appBar: CitadelAppBar(
          showLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColor.white),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        bottomNavigationBar: widget.isPreview
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w)
                    .copyWith(bottom: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      title: 'Edit profile picture',
                      onTap: () async {
                        selectPhoto(context, widget.type);
                      },
                    ),
                    AppTextButton(
                      title: 'Delete current picture',
                      textStyle: AppTextStyle.action
                          .copyWith(color: AppColor.errorRed),
                      onTap: () =>
                          widget.type.delete(context, ref, widget.profileImage),
                    )
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w)
                    .copyWith(bottom: 16.h),
                child: PrimaryButton(
                  title: 'Upload',
                  onTap: () async => await widget.type
                      .upload(context, ref, widget.profileImage),
                ),
              ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcATop),
                child: widget.profileImage.isNetworkImage()
                    ? Image.network(
                        widget.profileImage,
                        fit: BoxFit.cover,
                      )
                    : widget.profileImage.isImageBase64()
                        ? UploadFileHelper().getImageFromBase64(
                            imageBase64: widget.profileImage)
                        : Image.file(
                            File(widget.profileImage),
                            fit: BoxFit.cover,
                          ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: widget.profileImage.isNetworkImage()
                      ? Image.network(
                          widget.profileImage,
                          fit: BoxFit.cover,
                        )
                      : widget.profileImage.isImageBase64()
                          ? UploadFileHelper().getImageFromBase64(
                              imageBase64: widget.profileImage)
                          : Image.file(
                              File(widget.profileImage),
                              fit: BoxFit.cover,
                            ),
                ),
              ),
            ],
          ),
        ));
  }
}
