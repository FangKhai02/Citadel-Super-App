import 'dart:io';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/upload_file_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<File?> showUploadActionBottomSheet(BuildContext context) async {
  File? value = await showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => const UploadActionBottomSheet(),
  );
  return value;
}

class UploadActionBottomSheet extends HookConsumerWidget {
  const UploadActionBottomSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            gapHeight32,
            Text(
              'Choose document',
              style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
            ),
            gapHeight24,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                UploadFileHelper().pickImageFromGallery().then((value) {
                  if (value != null)
                    Navigator.pop(getAppContext() ?? context, value);
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    Assets.images.icons.gallery.path,
                    width: 24.w,
                    height: 24.h,
                  ),
                  gapWidth16,
                  Text(
                    'Gallery',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.popupGray),
                  ),
                ],
              ),
            ),
            gapHeight16,
            const Divider(),
            gapHeight16,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                UploadFileHelper().takePhoto().then((value) {
                  if (value != null)
                    Navigator.pop(getAppContext() ?? context, value);
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    Assets.images.icons.camera.path,
                    width: 24.w,
                    height: 24.h,
                  ),
                  gapWidth16,
                  Text(
                    'Camera',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.popupGray),
                  ),
                ],
              ),
            ),
            gapHeight16,
            const Divider(),
            gapHeight16,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                UploadFileHelper().pickDocumentFile().then((value) {
                  if (value != null)
                    Navigator.pop(getAppContext() ?? context, value);
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    Assets.images.icons.folder.path,
                    width: 24.w,
                    height: 24.h,
                  ),
                  gapWidth16,
                  Text(
                    'Document Folder',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.popupGray),
                  ),
                ],
              ),
            ),
            gapHeight32,
          ],
        ),
      ),
    );
  }
}
