import 'dart:io';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/upload_file_helper.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/upload_action_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/document/app_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DocumentType {
  supportingDocument,
  normalDocument,
  proofOfAddress,
  bankHeaderProof,
  paymentReceipt,
  companyDocument;

  String getDescText() {
    switch (this) {
      case DocumentType.supportingDocument:
        return 'Upload Supporting Document\n(membership, ID etc)';
      case DocumentType.normalDocument:
        return 'Upload Supporting Document';
      case DocumentType.proofOfAddress:
        return 'Upload Proof of Address\n(e.g. License, Utility Bill, Bank Statement)';
      case DocumentType.companyDocument:
        return 'Upload Company Document';
      case DocumentType.bankHeaderProof:
        return 'Upload Bank Header Proof';
      case DocumentType.paymentReceipt:
        return 'Upload Payment Receipt';
    }
  }
}

class AppUploadDocumentWidget extends BaseFormField {
  final GlobalKey<AppFormState>? formKey;
  final bool enable;
  final DocumentType? type;
  final List<dynamic> initialFiles;
  final int minFile;
  final int maxFile;

  const AppUploadDocumentWidget({
    super.key,
    this.formKey,
    required super.fieldKey,
    this.type = DocumentType.supportingDocument,
    this.enable = true,
    this.initialFiles = const [],
    this.minFile = 1,
    this.maxFile = 1,
    required super.label,
  });

  @override
  AppUploadDocumentWidgetState createState() => AppUploadDocumentWidgetState();
}

class AppUploadDocumentWidgetState
    extends BaseFormFieldState<AppUploadDocumentWidget> {
  bool hasError = false;
  List<dynamic> uploadedFiles = [];

  @override
  List<Document> onSaved() {
    List<Document> documentList = [];
    for (var file in uploadedFiles) {
      if (file is File) {
        final base64Str = UploadFileHelper().getFileBase64(file);
        final fileName = file.path.split('/').last;
        documentList
            .add(Document(fileName: fileName, base64EncodeStr: base64Str));
      } else if (file is NetworkFile && file.url.isNetworkImage()) {
        documentList
            .add(Document(fileName: file.fileName, base64EncodeStr: file.url));
      } else if (file is Document) {
        documentList.add(file);
      } else {
        debugPrint('Unsupported file type: ${file.runtimeType}');
      }
    }
    return documentList;
  }

  @override
  bool validate() {
    setState(() {
      if (uploadedFiles.length < widget.minFile) {
        errorMsg = 'Min of ${widget.minFile} file(s) required';
      } else {
        errorMsg = '';
      }
    });
    return uploadedFiles.length >= widget.minFile &&
        uploadedFiles.length <= widget.maxFile;
  }

  String getLabel() {
    if (widget.minFile == 1 && widget.maxFile > 1) {
      return '${widget.label} (up to ${widget.maxFile} files)';
    } else if (widget.minFile == widget.maxFile && widget.minFile != 1) {
      return '${widget.label} (${widget.minFile} file(s) required)';
    } else if (widget.minFile > 1) {
      return '${widget.label} (minimum of ${widget.minFile} files required, up to ${widget.maxFile} files)';
    } else if (widget.minFile == 0) {
      return '${widget.label} (optional)';
    } else {
      return widget.label;
    }
  }

  Widget uploadedFileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (uploadedFiles.length < widget.maxFile) gapHeight32,
        Text(
          getLabel(),
          style: AppTextStyle.label,
        ),
        ...List.generate(uploadedFiles.length, (index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: AppDocumentWidget(
              file: uploadedFiles[index],
              onDelete: () {
                setState(() {
                  uploadedFiles.removeAt(index);
                  validate();
                  widget.formKey?.currentState?.validateFormButton();
                });
              },
            ),
          );
        })
      ],
    );
  }

  @override
  void initState() {
    uploadedFiles = [...widget.initialFiles];
    super.initState();
  }

  @override
  void dispose() {
    uploadedFiles.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.minFile <= widget.maxFile,
        'The amount of minFile cannot be more than maxFile');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (uploadedFiles.length < widget.maxFile)
          GestureDetector(
            onTap: () async {
              if (widget.enable) {
                FocusNode().unfocus();
                final result = await showUploadActionBottomSheet(context);

                if (result != null) {
                  if (result.lengthSync() > 5 * 1024 * 1024) {
                    ScaffoldMessenger.of(getAppContext() ?? context)
                        .showSnackBar(const SnackBar(
                            backgroundColor: AppColor.errorRed,
                            content:
                                Text('File size cannot be more than 5MB')));
                    return;
                  }
                  setState(() {
                    uploadedFiles.add(result);
                    validate();
                    widget.formKey?.currentState?.validateFormButton();
                  });
                }
              }
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(8.r),
              dashPattern: const [10, 10],
              color: AppColor.white.withOpacity(0.2),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        Assets.images.icons.upload.path,
                        width: 24.w,
                        opacity: widget.enable
                            ? null
                            : const AlwaysStoppedAnimation(.2),
                      ),
                      gapHeight8,
                      Text(
                        widget.minFile > 1
                            ? 'Min. ${widget.minFile} files to upload'
                            : widget.type!.getDescText(),
                        textAlign: TextAlign.center,
                        style: AppTextStyle.action.copyWith(
                            color: AppColor.white
                                .withOpacity(widget.enable ? 1 : 0.2)),
                      ),
                      gapHeight8,
                      Text('In jpg, png or pdf. 5MB max file size.',
                          style: AppTextStyle.caption.copyWith(
                              color: AppColor.white
                                  .withOpacity(widget.enable ? 1 : 0.2)))
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (uploadedFiles.isNotEmpty) uploadedFileSection(),
        Visibility(
          visible: errorMsg.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Text(errorMsg, style: BaseFormField.formErrorStyle),
          ),
        ),
      ],
    );
  }
}
