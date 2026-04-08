import 'package:citadel_super_app/custom_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/upload_file_helper.dart';
import '../project_widget/bottom_sheet/upload_action_bottom_sheet.dart';
import '../screen/profile/profile_image_page.dart';

mixin ProfileImageMixin {
  void selectPhoto(BuildContext context, UserType type) async {
    final pickedImage = await showUploadActionBottomSheet(context);

    if (pickedImage != null) {
      final result = await UploadFileHelper().cropImage(imageFile: pickedImage);
      final imageBase64 = await UploadFileHelper().getImageBase64(result?.path);

      if (context.mounted) {
        Navigator.pushNamed(
          context,
          CustomRouter.profileImage,
          arguments: ProfileImagePage(
            profileImage: imageBase64,
            isPreview: false,
            type: type,
          ),
        );
      }
    }
  }
}
