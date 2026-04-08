import 'dart:io';

import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/project_widget/document/app_document_widget.dart';
import 'package:flutter/material.dart';

class AppInfoDocument extends StatelessWidget {
  final String title;
  final List<dynamic> documents;

  const AppInfoDocument(this.title, this.documents, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.label,
        ),
        gapHeight16,
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: documents.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            final doc = documents[index];

            return AppDocumentWidget(
              file: doc,
              onDelete: () {},
              viewOnly: true,
              showFileSize: false,
              fileName: doc is Document || doc is File || doc is NetworkFile
                  ? (doc.fileName.isNotEmpty ? doc.fileName : "Network File")
                  : "Network File",
            );
          },
        ),
      ],
    );
  }
}
