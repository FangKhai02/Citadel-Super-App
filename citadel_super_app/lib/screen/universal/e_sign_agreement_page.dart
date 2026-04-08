import 'dart:convert';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/screen/universal/component/signature_container.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signature/signature.dart';

class ESignAgreementPage extends HookConsumerWidget {
  final String? path;
  final Function(String signature, [String? name, String? userId, String? role])
      onSubmit;
  late final SignatureController signatureController;
  late final TextEditingController nameController;
  late final TextEditingController documentNumberController;
  late final TextEditingController roleController;
  final loadingProvider = StateProvider<bool>((ref) => false);
  final bool requiredIdentity;
  final bool requiredCompanyRole;
  final List<Widget> widgetsList;
  final String? clientId;

  ESignAgreementPage(
      {super.key,
      required this.path,
      required this.onSubmit,
      this.requiredIdentity = false,
      this.requiredCompanyRole = false,
      this.widgetsList = const [],
      this.clientId}) {
    signatureController = SignatureController(penColor: AppColor.labelBlack);
    nameController = TextEditingController();
    documentNumberController = TextEditingController();
    roleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = useState(0);
    final showOverlay = useState(true);
    final enableButton = useState(false);
    final showSignature = useState(false);

    emptyChecking() {
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

    if (requiredCompanyRole) {
      final profile = ref.watch(profileProvider(clientId));
      final corporateProfile = ref.watch(corporateProfileProvider(clientId));

      profile.whenData((profileData) {
        if (nameController.text.isEmpty &&
            profileData.personalDetails?.name != null) {
          nameController.text = profileData.personalDetails!.name!;
        }
        if (documentNumberController.text.isEmpty &&
            profileData.personalDetails?.identityCardNumber != null) {
          documentNumberController.text =
              profileData.personalDetails!.identityCardNumber!;
        }
      });
      corporateProfile.whenData((corporateProfileData) {
        if (roleController.text.isEmpty &&
            corporateProfileData.corporateDetails?.contactDesignation != null) {
          roleController.text =
              corporateProfileData.corporateDetails!.contactDesignation!;
        }
      });

      emptyChecking();
    }

    useEffect(() {
      if (currentStep.value == widgetsList.length) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          showOverlay.value = false;
        });
      }

      return;
    }, [currentStep.value]);

    signatureController.addListener(() {
      emptyChecking();
    });

    nameController.addListener(() {
      emptyChecking();
    });
    documentNumberController.addListener(() {
      emptyChecking();
    });
    roleController.addListener(() {
      emptyChecking();
    });

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
          ? PDFSignature(
              path: path,
              showSignature: showSignature,
              signatureController: signatureController,
              requiredIdentity: requiredIdentity,
              requiredCompanyRole: requiredCompanyRole,
              nameController: nameController,
              documentNumberController: documentNumberController,
              roleController: roleController,
              enableButton: enableButton,
              onSubmit: onSubmit,
              currentStep: currentStep,
              totalStep: widgetsList.length + 1,
              showOverlay: showOverlay)
          : Agreement(
              widgetsList: widgetsList,
              currentStep: currentStep,
            ),
    );
  }
}

class PageProgressHeader extends StatelessWidget {
  final int current;
  final int total;

  const PageProgressHeader({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    if (total == 1) return const SizedBox.shrink();

    double progress = current / total;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Page $current/$total',
            style: AppTextStyle.label.copyWith(color: AppColor.mainBlack),
          ),
          SizedBox(height: 4.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColor.lineGray,
            color: AppColor.cyan,
            minHeight: 8.0,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          gapHeight24,
        ],
      ),
    );
  }
}

class Agreement extends StatefulWidget {
  const Agreement(
      {super.key, required this.widgetsList, required this.currentStep});

  final List<Widget> widgetsList;
  final ValueNotifier<int> currentStep;

  @override
  AgreementState createState() => AgreementState();
}

class AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    int current = widget.currentStep.value + 1;
    int total = widget.widgetsList.length + 1;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            PageProgressHeader(current: current, total: total),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.widgetsList[widget.currentStep.value],
                  ],
                ),
              ),
            ),
            gapHeight32,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
              child: SafeArea(
                child: PrimaryButton(
                  title: 'Continue',
                  onTap: () {
                    if (widget.currentStep.value != widget.widgetsList.length) {
                      widget.currentStep.value += 1;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFSignature extends HookConsumerWidget {
  const PDFSignature(
      {super.key,
      required this.path,
      required this.showSignature,
      required this.signatureController,
      required this.requiredIdentity,
      required this.requiredCompanyRole,
      required this.nameController,
      required this.documentNumberController,
      required this.roleController,
      required this.enableButton,
      required this.onSubmit,
      required this.showOverlay,
      required this.currentStep,
      required this.totalStep});

  final String? path;
  final ValueNotifier<bool> showSignature;
  final SignatureController signatureController;
  final bool requiredIdentity;
  final bool requiredCompanyRole;
  final TextEditingController nameController;
  final TextEditingController documentNumberController;
  final TextEditingController roleController;
  final ValueNotifier<bool> enableButton;
  final Function(String signature, [String? name, String? userId, String? role])
      onSubmit;
  final ValueNotifier<bool> showOverlay;
  final ValueNotifier<int> currentStep;
  final int totalStep;

  double _calculateOverlayHeight(
      bool requiredIdentity, bool requiredCompanyRole) {
    double baseHeight = 48.h + // Close button
        200.h + // Signature container (approximate)
        16.h + // gapHeight16
        32.h + // gapHeight32
        56.h + // Primary button
        16.h; // Bottom padding

    if (requiredIdentity) {
      baseHeight += 80.h; // Full Name field
      baseHeight += 80.h; // MyKad/Passport field

      if (requiredCompanyRole) {
        baseHeight += 80.h; // Role field
      }
    }

    // Ensure minimum height and don't exceed 80% of screen
    return (baseHeight).clamp(400.h, 0.7.sh);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int current = currentStep.value + 1;
    int total = totalStep;

    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageProgressHeader(current: current, total: total),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.lineGray),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PDFView(
                      filePath: path,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageFling: false,
                      pageSnap: true,
                      defaultPage: 0,
                      fitPolicy: FitPolicy.BOTH,
                      preventLinkNavigation: false,
                      backgroundColor: Colors.white,
                      onRender: (pages) {},
                      onError: (error) {},
                      onPageError: (page, error) {},
                      onViewCreated: (PDFViewController pdfViewController) {},
                      onLinkHandler: (String? uri) {},
                      onPageChanged: (int? page, int? total) {},
                    ),
                  ),
                ),
              ),

              // Sign Now Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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

        // Signature Overlay
        if (showSignature.value)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _calculateOverlayHeight(
                  requiredIdentity, requiredCompanyRole),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SignatureContainer(
                      signatureController: signatureController,
                    ),
                  ),
                  gapHeight16,

                  // Identity Fields
                  if (requiredIdentity) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: AppTextFormField(
                        label: 'Full Name (same as NRIC/Passport)',
                        padding: EdgeInsets.zero,
                        controller: nameController,
                        fieldKey: AppFormFieldKey.nameKey,
                        textStyle: AppTextStyle.bodyText
                            .copyWith(color: AppColor.mainBlack),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: AppTextFormField(
                        label: 'MyKad/Passport Number',
                        controller: documentNumberController,
                        fieldKey: AppFormFieldKey.documentNumberKey,
                        maxLength: 20,
                        textStyle: AppTextStyle.bodyText
                            .copyWith(color: AppColor.mainBlack),
                      ),
                    ),
                    if (requiredCompanyRole) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: AppTextFormField(
                          label: 'Role in the Company',
                          controller: roleController,
                          fieldKey: AppFormFieldKey.roleKey,
                          textStyle: AppTextStyle.bodyText
                              .copyWith(color: AppColor.mainBlack),
                        ),
                      ),
                    ],
                  ],

                  gapHeight32,
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 16.h, left: 8.w, right: 8.w),
                    child: SafeArea(
                      child: PrimaryButton(
                        title: 'I have read and confirmed',
                        onTap: enableButton.value
                            ? () async {
                                final result =
                                    await signatureController.toPngBytes();
                                if (result == null) return;
                                await onSubmit(
                                    base64Encode(result),
                                    nameController.text,
                                    documentNumberController.text,
                                    roleController.text);
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        if (showOverlay.value)
          Center(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: showOverlay.value ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.zoom_out_map, color: Colors.white, size: 32.w),
                      gapHeight16,
                      Text(
                        "Pinch to Zoom",
                        style: AppTextStyle.header2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
