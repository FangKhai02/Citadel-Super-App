import 'dart:typed_data';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signature/signature.dart';

class SignatureContainer extends StatefulHookConsumerWidget {
  final GlobalKey<AppFormState>? formKey;
  late ValueNotifier<Widget>? currentWidget;
  final SignatureController signatureController;
  final String? label;

  SignatureContainer(
      {super.key,
      this.formKey,
      this.currentWidget,
      required this.signatureController,
      this.label});

  @override
  SignatureContainerState createState() => SignatureContainerState();
}

class SignatureContainerState extends ConsumerState<SignatureContainer> {
  @override
  Widget build(BuildContext context) {
    widget.currentWidget = useState(const SizedBox());
    final isSignatureEmpty = useState(true);

    widget.signatureController.addListener(() {
      final isEmpty = widget.signatureController.isEmpty;
      if (isSignatureEmpty.value != isEmpty) {
        isSignatureEmpty.value = isEmpty;
        widget.formKey?.currentState?.validateFormButton();
      }
    });

    final Widget signatureWidget = Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.lineGray),
      ),
      height: 120.h,
      width: 1.sh,
      padding: EdgeInsets.all(16.r),
      child: Signature(
        controller: widget.signatureController,
        backgroundColor: AppColor.white,
      ),
    );

    useEffect(() {
      widget.currentWidget!.value = SignatureOverlay(
        currentWidget: widget.currentWidget!,
        signatureWidget: signatureWidget,
        label: widget.label,
      );
      return;
    }, []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: AnimatedOpacity(
            opacity: isSignatureEmpty.value ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: TextButton(
              onPressed: () {
                widget.signatureController.clear();
                setState(() {
                  isSignatureEmpty.value = true;
                });
                widget.formKey?.currentState?.validateFormButton();
              },
              child: Text(
                'Clear',
                style: AppTextStyle.label.copyWith(color: AppColor.errorRed),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: GestureDetector(
              onTap: () => widget.currentWidget!.value = signatureWidget,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: widget.currentWidget!.value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SignatureOverlay extends HookWidget {
  final ValueNotifier<Widget> currentWidget;
  final Widget signatureWidget;
  final String? label;

  const SignatureOverlay({
    super.key,
    required this.currentWidget,
    required this.signatureWidget,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => currentWidget.value = signatureWidget,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.lineGray),
        ),
        height: 120.h,
        width: 1.sh,
        padding: EdgeInsets.all(16.r),
        child: Text(
          label ?? 'Sign here as confirmation',
          style: AppTextStyle.label.copyWith(color: AppColor.labelBlack),
        ),
      ),
    );
  }
}

getImageData(
    BuildContext context, SignatureController signatureController) async {
  if (signatureController.isNotEmpty) {
    final Uint8List? data = await signatureController.toPngBytes();
    if (data != null) {
      //can use Image.memory(data) to see the image.
    }
  }
}
