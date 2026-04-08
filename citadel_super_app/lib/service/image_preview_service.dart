import 'dart:io';

import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/project_widget/document/pdf_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_folder/app_text_style.dart';

class ImagePreviewService {
  static void openPreview(BuildContext context, dynamic file) {
    OverlayEntry? overlayEntry;
    LocalHistoryEntry? historyEntry;
    bool isRemoved = false;

    void removeHighlightOverlay({bool fromHistory = false}) {
      if (isRemoved) {
        return;
      }
      overlayEntry?.remove();
      overlayEntry?.dispose();
      overlayEntry = null;
      if (!fromHistory) {
        historyEntry?.remove();
      }
      historyEntry = null;
      isRemoved = true;
    }

    overlayEntry = OverlayEntry(builder: (context) {
      Widget getWidget(BuildContext context) {
        if (file is File) {
          if (file.path.endsWith('.pdf')) {
            return PdfViewerWidget(
              file: file,
            );
          }
          return Image.file(file);
        } else if (file is NetworkFile) {
          if (file.url.contains('pdf')) {
            return PdfViewerWidget(file: file);
          }
          return Image.network(file.url);
        }

        return Text(
          'Something Went Wrong',
          style: AppTextStyle.bodyText,
        );
      }

      return GestureDetector(
        onTap: () {
          removeHighlightOverlay();
        },
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.black.withOpacity(0.5),
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: InteractiveViewer(
            child: getWidget(context),
          ),
        ),
      );
    });

    Overlay.of(context).insert(overlayEntry!);
    final route = ModalRoute.of(context);
    if (route != null) {
      historyEntry = LocalHistoryEntry(
        onRemove: () => removeHighlightOverlay(fromHistory: true),
      );
      route.addLocalHistoryEntry(historyEntry!);
    }
  }
}
