// import 'dart:io';

// import 'package:citadel_super_app/app_folder/app_constant.dart';
// import 'package:citadel_super_app/app_folder/app_spacing.dart';
// import 'package:citadel_super_app/app_folder/app_text_style.dart';
// import 'package:citadel_super_app/data/state/sign_up_state.dart';
// import 'package:citadel_super_app/project_widget/document/app_document_widget.dart';
// import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class SupportingDocumentWidget extends StatefulHookConsumerWidget {
//   const SupportingDocumentWidget({
//     super.key,
//     required this.label,
//     this.type = DocumentType.supportingDocument,
//   });
//   final DocumentType type;
//   final String label;

//   @override
//   ConsumerState<SupportingDocumentWidget> createState() {
//     return SupportingDocumentWidgetState();
//   }
// }

// class SupportingDocumentWidgetState
//     extends ConsumerState<SupportingDocumentWidget> {
//   String getDescText() {
//     switch (widget.type) {
//       case DocumentType.supportingDocument:
//         return 'Supporting Document';
//       case DocumentType.proofOfAddress:
//         return 'Proof of Address Document';
//       default:
//         return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final signUpState = ref.watch(signUpProvider);
//     final signUpNotifier = ref.watch(signUpProvider.notifier);

//     return signUpState.getPepDeclarationModel.getSupportingDoc != null
//         ? (Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 getDescText(),
//                 style: AppTextStyle.label,
//               ),
//               gapHeight8,
//               AppDocumentWidget(
//                 file: signUpState.getPepDeclarationModel.getSupportingDoc,
//                 onDelete: () {
//                   signUpNotifier.setSupportingDoc(null);
//                 },
//               ),
//             ],
//           ))
//         : AppUploadDocumentWidget(
//             type: widget.type,
//             fieldKey: widget.type == DocumentType.supportingDocument
//                 ? AppFormFieldKey.supportingDocumentKey
//                 : AppFormFieldKey.proofDocKey,
//             label: widget.label);
//     // onTap: (value) {
//     //   signUpNotifier.setSupportingDoc(value);
//     // });
//   }
// }
