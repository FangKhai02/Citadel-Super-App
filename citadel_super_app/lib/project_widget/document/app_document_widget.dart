import 'dart:io';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/service/image_preview_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppDocumentWidget extends StatefulHookConsumerWidget {
  final Function onDelete;
  final dynamic file;
  final bool showFileSize;
  final bool invalid;
  final bool viewOnly;
  final String? fileName;

  const AppDocumentWidget(
      {super.key,
      required this.file,
      required this.onDelete,
      this.showFileSize = true,
      this.invalid = false,
      this.viewOnly = false,
      this.fileName});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DocumentWidgetState();
  }
}

class DocumentWidgetState extends ConsumerState<AppDocumentWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (widget.file != null) {
        _animationController.addListener(() {
          setState(() {});
        });
        _animationController.forward();
      }
      return;
    }, [widget.file]);

    return GestureDetector(
      onTap: () {
        ImagePreviewService.openPreview(context, widget.file);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.white.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.invalid ? AppColor.errorRed : AppColor.cyan,
                  ),
                  child: Image.asset(
                    Assets.images.icons.document.path,
                    width: 24.w,
                  ),
                ),
                gapWidth16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.file is File?) ...[
                        Text(
                          widget.fileName ??
                              widget.file?.path.split('/').last ??
                              'filename',
                          style: AppTextStyle.description,
                        ),
                        if (widget.showFileSize)
                          Text(
                            '${((widget.file?.lengthSync() ?? 0) / (1024 * 1024)).toStringAsFixed(2)} MB',
                            style: AppTextStyle.caption,
                          ),
                      ] else if (widget.file is NetworkFile?)
                        Text(
                          widget.file.fileName ?? 'Internet file',
                          style: AppTextStyle.description,
                        )
                      else if (widget.file is Document?)
                        Text(
                          widget.file.fileName ?? 'Internet file',
                          style: AppTextStyle.description,
                        ),
                      if (widget.invalid)
                        Text(
                          'Invalid file',
                          style: AppTextStyle.caption
                              .copyWith(color: AppColor.errorRed),
                        ),
                    ],
                  ),
                ),
                gapWidth16,
                GestureDetector(
                  onTap: () {
                    if (!widget.viewOnly) {
                      _animationController.reset();
                      widget.onDelete();
                    }
                  },
                  child: widget.viewOnly
                      ? Image.asset(
                          Assets.images.icons.view.path,
                          width: 24.w,
                        )
                      : Image.asset(
                          Assets.images.icons.dustbin.path,
                          width: 24.w,
                        ),
                )
              ],
            ),
            Visibility(
              visible: _animationController.value != 1,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        color: AppColor.cyan,
                        backgroundColor: AppColor.white,
                        value: _animationController.value,
                        semanticsLabel: 'Linear progress indicator',
                      ),
                    ),
                    gapWidth16,
                    Text(
                      '${(_animationController.value * 100).round()}%',
                      style: AppTextStyle.remark,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
