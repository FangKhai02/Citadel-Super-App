import 'dart:convert';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/screen/universal/component/signature_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

class WebESignAgreementPage extends HookWidget {
  final String? pdfUrl;
  final Function(String signature, [String? name, String? userId, String? role])
      onSubmit;
  final bool requiredIdentity;
  final bool requiredCompanyRole;
  final List<Widget> widgetsList;

  const WebESignAgreementPage({
    super.key,
    required this.pdfUrl,
    required this.onSubmit,
    this.requiredIdentity = false,
    this.requiredCompanyRole = false,
    this.widgetsList = const [],
  });

  @override
  Widget build(BuildContext context) {
    final signatureController =
        useMemoized(() => SignatureController(penColor: AppColor.labelBlack));
    final nameController = useMemoized(() => TextEditingController());
    final documentNumberController = useMemoized(() => TextEditingController());
    final roleController = useMemoized(() => TextEditingController());
    final enableButton = useState(false);
    final showSignature = useState(false);
    final currentStep = useState(0);
    final viewId = useMemoized(
        () => 'pdf-viewer-${DateTime.now().millisecondsSinceEpoch}');

    void emptyChecking() {
      if (requiredIdentity) {
        bool identityValid = nameController.text.isNotEmpty &&
            documentNumberController.text.isNotEmpty;
        bool roleValid = !requiredCompanyRole || roleController.text.isNotEmpty;
        if (requiredCompanyRole) {
          enableButton.value =
              signatureController.isNotEmpty && identityValid && roleValid;
        } else {
          enableButton.value = signatureController.isNotEmpty && identityValid;
        }
      } else {
        enableButton.value = signatureController.isNotEmpty;
      }
    }

    useEffect(() {
      signatureController.addListener(emptyChecking);
      nameController.addListener(emptyChecking);
      documentNumberController.addListener(emptyChecking);
      roleController.addListener(emptyChecking);

      return () {
        signatureController.removeListener(emptyChecking);
        nameController.removeListener(emptyChecking);
        documentNumberController.removeListener(emptyChecking);
        roleController.removeListener(emptyChecking);
      };
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.pureWhite,
      appBar: CitadelAppBar(
        title: 'E-sign Agreement',
        titleColor: AppColor.mainBlack,
        leading: currentStep.value == 0
            ? null
            : IconButton(
                icon: Image.asset(
                  Assets.images.icons.back.path,
                  width: 24,
                  height: 24,
                  color: AppColor.mainBlack,
                ),
                onPressed: () {
                  currentStep.value -= 1;
                },
              ),
      ),
      child: (currentStep.value == widgetsList.length || widgetsList.isEmpty)
          ? SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Main Content
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // PDF Viewer
                          Container(
                            height: 0.75.sh,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.lineGray),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: WebPDFViewer(
                                viewId: viewId,
                                showSignature: showSignature.value,
                              ),
                            ),
                          ),

                          // Sign Now Button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: PrimaryButton(
                              title: 'Sign Now',
                              onTap: () {
                                showSignature.value = true;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Signature Overlay
                  if (showSignature.value)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 0.7.sh,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        color: AppColor.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                color: AppColor.mainBlack,
                                onPressed: () {
                                  showSignature.value = false;
                                },
                              ),
                            ),
                            // Signature Container
                            SignatureContainer(
                              signatureController: signatureController,
                            ),
                            gapHeight16,

                            // Identity Fields
                            if (requiredIdentity) ...[
                              AppTextFormField(
                                label: 'Full Name (same as NRIC/Passport)',
                                padding: EdgeInsets.zero,
                                controller: nameController,
                                fieldKey: AppFormFieldKey.nameKey,
                                textStyle: AppTextStyle.bodyText
                                    .copyWith(color: AppColor.mainBlack),
                              ),
                              AppTextFormField(
                                label: 'MyKad/Passport Number',
                                controller: documentNumberController,
                                fieldKey: AppFormFieldKey.documentNumberKey,
                                maxLength: 20,
                                textStyle: AppTextStyle.bodyText
                                    .copyWith(color: AppColor.mainBlack),
                              ),
                              if (requiredCompanyRole) ...[
                                AppTextFormField(
                                  label: 'Role in the Company',
                                  controller: roleController,
                                  fieldKey: AppFormFieldKey.roleKey,
                                  textStyle: AppTextStyle.bodyText
                                      .copyWith(color: AppColor.mainBlack),
                                ),
                              ],
                            ],

                            gapHeight32,
                            Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: SafeArea(
                                  child: PrimaryButton(
                                    title: 'I have read and confirmed',
                                    onTap: enableButton.value
                                        ? () async {
                                            final result =
                                                await signatureController
                                                    .toPngBytes();
                                            if (result == null) return;
                                            await onSubmit(
                                                base64Encode(result),
                                                nameController.text,
                                                documentNumberController.text,
                                                roleController.text);
                                          }
                                        : null,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          : WebAgreementSteps(
              widgetsList: widgetsList,
              currentStep: currentStep,
            ),
    );
  }
}

class WebPDFViewer extends HookWidget {
  final String viewId;
  final bool showSignature;

  const WebPDFViewer(
      {super.key, required this.viewId, required this.showSignature});

  @override
  Widget build(BuildContext context) {
    final pdfController = useMemoized(() {
      final pdfUrl = context
              .findAncestorWidgetOfExactType<WebESignAgreementPage>()
              ?.pdfUrl ??
          '';
      return PdfController(
        document: PdfDocument.openData(
          http.get(Uri.parse(pdfUrl)).then((response) => response.bodyBytes),
        ),
      );
    });

    return AbsorbPointer(
      absorbing: showSignature,
      child: Container(
        color: AppColor.white,
        child: PdfView(
          controller: pdfController,
          scrollDirection: Axis.vertical,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class WebAgreementSteps extends StatelessWidget {
  final List<Widget> widgetsList;
  final ValueNotifier<int> currentStep;

  const WebAgreementSteps({
    super.key,
    required this.widgetsList,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Progress indicator
          if (widgetsList.length > 1)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step ${currentStep.value + 1}/${widgetsList.length}',
                    style:
                        AppTextStyle.label.copyWith(color: AppColor.mainBlack),
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: (currentStep.value + 1) / widgetsList.length,
                    backgroundColor: AppColor.lineGray,
                    color: AppColor.lineGray,
                    minHeight: 8.0,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ],
              ),
            ),

          // Current step widget
          Expanded(
            child: SingleChildScrollView(
              child: widgetsList[currentStep.value],
            ),
          ),

          // Continue button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: PrimaryButton(
              title: 'Continue',
              onTap: () {
                if (currentStep.value < widgetsList.length - 1) {
                  currentStep.value += 1;
                } else {
                  currentStep.value = widgetsList.length; // Move to PDF step
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
