import 'dart:convert';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/sign_up_repository.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/existing_client_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
import 'package:citadel_super_app/service/document_capture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientIdDetailsPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  ClientIdDetailsPage({super.key});

  @override
  ConsumerState<ClientIdDetailsPage> createState() =>
      ClientIdDetailsPageState();
}

class ClientIdDetailsPageState extends ConsumerState<ClientIdDetailsPage> {
  late final TextEditingController nameController;
  late final TextEditingController documentNumberController;
  late final TextEditingController dobController;
  late final TextEditingController genderController;
  late final TextEditingController nationalityController;
  late final TextEditingController documentTypeController;

  String _documentType = 'MYKAD';
  String? _frontImageBase64;
  String? _backImageBase64;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    documentNumberController = TextEditingController();
    dobController = TextEditingController();
    genderController = TextEditingController();
    nationalityController = TextEditingController();
    documentTypeController = TextEditingController(text: 'MYKAD');
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(clientSignUpProvider);
    ref.watch(existingClientProvider);

    final constants = ref.read(appProvider).constants ?? [];
    final genderConstants = constants.firstWhere(
        (element) => element.category == AppConstantsKey.gender);
    final genderOptions = genderConstants.list!
        .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
        .toList();

    final countries = ref.read(countryCodeProvider).countryCodes ?? [];
    final nationalityOptions = countries
        .map((country) => AppDropDownItem(
            value: country.countryName ?? '',
            text: country.countryName ?? ''))
        .toList();

    final documentTypeOptions = [
      AppDropDownItem(value: 'MYKAD', text: 'MyKad'),
      AppDropDownItem(value: 'PASSPORT', text: 'Passport'),
      AppDropDownItem(value: 'MYPR', text: 'MyPR'),
      AppDropDownItem(value: 'IKAD', text: 'iKad'),
      AppDropDownItem(value: 'MYTENTERA', text: 'MyTentera'),
    ];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Identity Verification'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: widget.formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Bar
                  const SignUpProgressBar(currentStep: 3),
                  gapHeight4,

                  // Header Section with Icon
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColor.brightBlue.withValues(alpha: 0.15),
                          AppColor.brightBlue.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColor.brightBlue.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.brightBlue.withValues(alpha: 0.15),
                            border: Border.all(
                              color: AppColor.brightBlue.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.verified_user_outlined,
                              size: 28.sp,
                              color: AppColor.brightBlue,
                            ),
                          ),
                        ),
                        gapHeight16,
                        Text('Confirm ID Details',
                          style: AppTextStyle.header1.copyWith(
                            fontSize: 28.spMin,
                            height: 1.3,
                            letterSpacing: -0.5,
                          )
                        ),
                        gapHeight8,
                        Text(
                          'Verify your identity with your government-issued document',
                          style: AppTextStyle.bodyText.copyWith(
                            color: AppColor.brightBlue.withValues(alpha: 0.9),
                            fontSize: 14.spMin,
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapHeight32,

                  // Document Information Section
                  _buildSectionCard(
                    children: [
                      _buildSectionHeader(
                        icon: Icons.description_outlined,
                        title: 'Document Information',
                      ),
                      gapHeight20,

                      // Document Type Selection
                      AppDropdown(
                        formKey: widget.formKey,
                        label: 'Document Type',
                        fieldKey: AppFormFieldKey.documentTypeKey,
                        hintText: 'Select document type',
                        textController: documentTypeController,
                        options: documentTypeOptions,
                        onSelected: (selected) {
                          final newValue = selected.value;
                          if (_documentType != newValue) {
                            setState(() {
                              _documentType = newValue;
                              _frontImageBase64 = null;
                              _backImageBase64 = null;
                            });
                          }
                          widget.formKey.currentState?.validateFormButton();
                        },
                      ),
                      gapHeight20,

                      // Document Number
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: '$_documentType Number',
                        controller: documentNumberController,
                        fieldKey: AppFormFieldKey.documentNumberKey,
                        keyboardType: (_documentType == 'PASSPORT' ||
                                _documentType == 'MYTENTERA')
                            ? TextInputType.text
                            : const TextInputType.numberWithOptions(
                                signed: true),
                        inputFormatters: (_documentType == 'PASSPORT' ||
                                _documentType == 'MYTENTERA')
                            ? []
                            : [FilteringTextInputFormatter.digitsOnly],
                        maxLength: _documentType == 'MYKAD' ? 12 : null,
                        validator: (value) {
                          if (_documentType == 'MYKAD') {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ID number';
                            }
                            if (value.length < 12) {
                              return 'Invalid MyKad number';
                            }
                          }
                          return '';
                        },
                        hint: 'eg. 123456789012',
                      ),
                    ],
                  ),
                  gapHeight24,

                  // Personal Information Section
                  _buildSectionCard(
                    children: [
                      _buildSectionHeader(
                        icon: Icons.person_outline,
                        title: 'Personal Information',
                      ),
                      gapHeight20,

                      // Full Name
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: 'Full Name (same as ID)',
                        controller: nameController,
                        fieldKey: AppFormFieldKey.nameKey,
                        hint: 'eg. John Doe',
                      ),
                      gapHeight20,

                      // Date of Birth
                      AppDatePickerFormField(
                        formKey: widget.formKey,
                        label: 'Date of Birth',
                        controller: dobController,
                        isEnabled: true,
                      ),
                      gapHeight20,

                      // Gender & Nationality Row
                      _buildGenderNationalityRow(genderOptions, nationalityOptions),
                    ],
                  ),
                  gapHeight24,

                  // Document Upload Section
                  _buildSectionCard(
                    children: [
                      _buildSectionHeader(
                        icon: Icons.photo_camera_outlined,
                        title: 'Document Upload',
                      ),
                      gapHeight20,

                      // Document Image Upload
                      _ManualDocumentUploadSection(
                        documentType: _documentType,
                        frontImageBase64: _frontImageBase64,
                        backImageBase64: _backImageBase64,
                        onFrontImageCaptured: _onFrontImageCaptured,
                        onBackImageCaptured: _onBackImageCaptured,
                        onClearFront: _onClearFront,
                        onClearBack: _onClearBack,
                      ),
                    ],
                  ),
                  gapHeight32,

                  // Continue Button
                  _buildContinueButton(context),
                ],
              ),
            ),
          ),
        ));
  }

  /// Check if user is at least 18 years old
  /// Expected date format: MM-dd-yyyy (from AppDatePickerFormField)
  bool _isUserAtLeast18(String dobString) {
    if (dobString.isEmpty) return false;

    try {
      // Date format is MM-dd-yyyy (e.g., "01-15-1990")
      final parts = dobString.split('-');
      if (parts.length != 3) return false;

      final month = int.parse(parts[0]);
      final day = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final dob = DateTime(year, month, day);
      final today = DateTime.now();

      // Calculate age, accounting for whether birthday has passed this year
      int age = today.year - dob.year;
      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }

      return age >= 18;
    } catch (e) {
      return false;
    }
  }

  /// Show age restriction dialog
  void _showAgeRestrictionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AppDialog(
          title: 'Age Restriction',
          message: 'You must be at least 18 years old to use this application.',
          isRounded: true,
          positiveOnTap: () {
            Navigator.pop(context);
          },
          showNegativeButton: false,
        );
      },
    );
  }

  void _onFrontImageCaptured(String base64) {
    setState(() {
      _frontImageBase64 = base64;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formKey.currentState?.validateFormButton();
    });
  }

  void _onBackImageCaptured(String base64) {
    setState(() {
      _backImageBase64 = base64;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formKey.currentState?.validateFormButton();
    });
  }

  void _onClearFront() {
    setState(() {
      _frontImageBase64 = null;
    });
  }

  void _onClearBack() {
    setState(() {
      _backImageBase64 = null;
    });
  }

  Future<void> validateClientId(
      BuildContext context, WidgetRef ref, formData) async {
    SignUpRepository repo = SignUpRepository();

    final req = ParameterHelper().clientIdentifyValidationParam(
      _documentType,
      formData,
      frontImage: _frontImageBase64,
      backImage: _backImageBase64,
    );

    EasyLoadingHelper.show();
    await repo.clientIdentityValidation(req).baseThen(
      context,
      onResponseSuccess: (response) {
        globalRef
            .read(clientSignUpProvider.notifier)
            .setClientIdentityDetailsRequestVo(req);

        Navigator.pushNamed(context, CustomRouter.personalDetails);
      },
      onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper()
              .resolveValidationError(widget.formKey, e.message);
        } else {
          if (e.message.equalsIgnoreCase(
              'api.account.registered.with.identity.card.number')) {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AppDialog(
                    title: 'Identity Card Used',
                    message:
                        'This identity card number is already registered. Please contact our support team for assistance.',
                    isRounded: true,
                    positiveOnTap: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (routes) {
                        if ([
                          CustomRouter.signUp,
                        ].contains(routes.settings.name)) {
                          return true;
                        }
                        return false;
                      });
                    },
                    showNegativeButton: false,
                  );
                });
          } else {
            ScaffoldMessenger.of(getAppContext() ?? context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        }
      },
    ).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  /// Build section card with consistent styling
  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.mainBlack.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  /// Build section header with icon and title
  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: AppColor.brightBlue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColor.brightBlue, size: 18.sp),
        ),
        gapWidth12,
        Text(
          title,
          style: AppTextStyle.label.copyWith(
            color: AppColor.white,
            fontWeight: FontWeight.w600,
            fontSize: 14.spMin,
          ),
        ),
      ],
    );
  }

  /// Build gender and nationality row
  Widget _buildGenderNationalityRow(
      List<AppDropDownItem> genderOptions, List<AppDropDownItem> nationalityOptions) {
    return Row(
      children: [
        Expanded(
          child: AppDropdown(
            formKey: widget.formKey,
            label: 'Gender',
            fieldKey: AppFormFieldKey.genderKey,
            hintText: 'Select',
            textController: genderController,
            options: genderOptions,
            onSelected: (selected) {
              genderController.text = selected.text;
              widget.formKey.currentState?.validateFormButton();
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: AppDropdown(
            formKey: widget.formKey,
            label: 'Nationality',
            fieldKey: AppFormFieldKey.nationalityKey,
            hintText: 'Select',
            textController: nationalityController,
            options: nationalityOptions,
            onSelected: (selected) {
              nationalityController.text = selected.text;
              widget.formKey.currentState?.validateFormButton();
            },
          ),
        ),
      ],
    );
  }

  /// Build continue button with enhanced styling
  Widget _buildContinueButton(BuildContext context) {
    return PrimaryButton(
      key: const Key(AppFormFieldKey.primaryButtonValidateKey),
      onTap: () async {
        FocusScope.of(context).unfocus();

        if (dobController.text.isNotEmpty) {
          if (!_isUserAtLeast18(dobController.text)) {
            _showAgeRestrictionDialog(context);
            return;
          }
        }

        final isPassport = _documentType == 'PASSPORT';
        if (!isPassport && (_frontImageBase64 == null || _backImageBase64 == null)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please upload both front and back of your ID'),
              backgroundColor: AppColor.errorRed,
            ),
          );
          return;
        }
        if (isPassport && _frontImageBase64 == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please upload the front of your passport'),
              backgroundColor: AppColor.errorRed,
            ),
          );
          return;
        }

        await widget.formKey.currentState!.validate(
            onSuccess: (formData) async {
          await validateClientId(context, ref, formData);
        });
      },
      title: 'Continue',
    );
  }
}

/// Manual document upload section - no OCR, just image capture
class _ManualDocumentUploadSection extends StatelessWidget {
  final String documentType;
  final String? frontImageBase64;
  final String? backImageBase64;
  final Function(String) onFrontImageCaptured;
  final Function(String) onBackImageCaptured;
  final VoidCallback onClearFront;
  final VoidCallback onClearBack;

  const _ManualDocumentUploadSection({
    required this.documentType,
    this.frontImageBase64,
    this.backImageBase64,
    required this.onFrontImageCaptured,
    required this.onBackImageCaptured,
    required this.onClearFront,
    required this.onClearBack,
  });

  @override
  Widget build(BuildContext context) {
    final isPassport = documentType.equalsIgnoreCase('PASSPORT');
    final needsBackImage = !isPassport;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Instructions Container
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.brightBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColor.brightBlue.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.brightBlue.withValues(alpha: 0.15),
                ),
                child: Center(
                  child: Icon(
                    Icons.info_outlined,
                    color: AppColor.brightBlue,
                    size: 16.sp,
                  ),
                ),
              ),
              gapWidth12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Clear document images required',
                      style: AppTextStyle.label.copyWith(
                        color: AppColor.brightBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    gapHeight4,
                    Text(
                      'Ensure all details are visible and well-lit',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColor.brightBlue.withValues(alpha: 0.8),
                        fontSize: 11.spMin,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        gapHeight24,

        // Front Image Upload
        _ImageUploadCard(
          label: '$documentType (Front)',
          imageBase64: frontImageBase64,
          onCapture: () => _showImageSourcePicker(
            context,
            onImageSelected: onFrontImageCaptured,
          ),
          onClear: onClearFront,
        ),

        if (needsBackImage) ...[
          gapHeight16,
          // Back Image Upload
          _ImageUploadCard(
            label: '$documentType (Back)',
            imageBase64: backImageBase64,
            onCapture: () => _showImageSourcePicker(
              context,
              onImageSelected: onBackImageCaptured,
              isBack: true,
            ),
            onClear: onClearBack,
          ),
        ],
      ],
    );
  }

  void _showImageSourcePicker(
    BuildContext context, {
    required Function(String) onImageSelected,
    bool isBack = false,
  }) async {
    // Store navigator context before showing bottom sheet
    final navigatorContext = Navigator.of(context).context;

    final source = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.mainBlack,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            gapHeight24,

            // Title
            Text(
              isBack ? 'Capture Back of Document' : 'Capture Front of Document',
              style: AppTextStyle.header2.copyWith(
                color: AppColor.white,
                fontSize: 20.spMin,
              ),
            ),
            gapHeight8,
            Text(
              'Choose how to upload your document image',
              style: AppTextStyle.caption.copyWith(
                color: AppColor.white.withValues(alpha: 0.6),
              ),
            ),
            gapHeight32,

            // Camera Option
            _SourceOptionCard(
              icon: Icons.camera_alt_rounded,
              iconColor: AppColor.brightBlue,
              title: 'Take Photo',
              description: 'Use your camera',
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            gapHeight12,

            // Gallery Option
            _SourceOptionCard(
              icon: Icons.photo_library_rounded,
              iconColor: const Color(0xFF8B5CF6),
              title: 'Choose from Gallery',
              description: 'Select from your device',
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            gapHeight24,
          ],
        ),
      ),
    );

    if (source == null) return;

    // Use document capture service to get image
    final documentCaptureService = DocumentCaptureService();
    String? imageBase64;

    if (source == 'camera') {
      imageBase64 = await documentCaptureService.captureFromCamera(
        context: navigatorContext,
        isBackSide: isBack,
      );
    } else {
      imageBase64 = await documentCaptureService.pickFromGallery();
    }

    if (imageBase64 != null) {
      onImageSelected(imageBase64);
    }
  }
}

/// Source option card
class _SourceOptionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _SourceOptionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        splashColor: iconColor.withValues(alpha: 0.2),
        highlightColor: iconColor.withValues(alpha: 0.1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          constraints: BoxConstraints(minHeight: 56.h),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 52.w,
                height: 52.h,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: iconColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: iconColor, size: 24.sp),
              ),
              gapWidth16,

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.label.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.spMin,
                      ),
                    ),
                    gapHeight2,
                    Text(
                      description,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColor.white.withValues(alpha: 0.6),
                        fontSize: 12.spMin,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.white.withValues(alpha: 0.25),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Image upload card with tap to capture
class _ImageUploadCard extends StatelessWidget {
  final String label;
  final String? imageBase64;
  final VoidCallback onCapture;
  final VoidCallback onClear;

  const _ImageUploadCard({
    required this.label,
    this.imageBase64,
    required this.onCapture,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.brightBlue.withValues(alpha: 0.15),
              ),
              child: Center(
                child: Icon(
                  Icons.badge_outlined,
                  size: 14.sp,
                  color: AppColor.brightBlue,
                ),
              ),
            ),
            gapWidth12,
            Text(
              label,
              style: AppTextStyle.label.copyWith(
                color: AppColor.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (imageBase64 != null) ...[
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColor.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: AppColor.green.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 14.sp, color: AppColor.green),
                    gapWidth4,
                    Text(
                      'Uploaded',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColor.green,
                        fontSize: 10.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        gapHeight12,

        // Upload Area
        GestureDetector(
          onTap: onCapture,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 180.h,
            decoration: BoxDecoration(
              color: imageBase64 != null
                  ? AppColor.green.withValues(alpha: 0.05)
                  : AppColor.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: imageBase64 != null
                    ? AppColor.green.withValues(alpha: 0.4)
                    : AppColor.white.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: imageBase64 != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.memory(
                          base64Decode(imageBase64!),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Dark overlay for buttons
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              AppColor.mainBlack.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                      // Action Buttons
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Retake Photo Button
                            GestureDetector(
                              onTap: onCapture,
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: AppColor.brightBlue.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                            gapWidth8,
                            // Remove Photo Button
                            GestureDetector(
                              onTap: onClear,
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: AppColor.errorRed.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: AppColor.brightBlue.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.brightBlue.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: AppColor.brightBlue,
                          size: 28.sp,
                        ),
                      ),
                      gapHeight16,
                      Text(
                        'Tap to upload',
                        style: AppTextStyle.label.copyWith(
                          color: AppColor.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapHeight4,
                      Text(
                        'Camera or Gallery',
                        style: AppTextStyle.caption.copyWith(
                          color: AppColor.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}