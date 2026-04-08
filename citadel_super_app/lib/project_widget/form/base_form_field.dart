import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_folder/app_color.dart';

abstract class BaseFormFieldState<T extends StatefulWidget> extends State<T> {
  String errorMsg = '';

  bool get isValid => errorMsg.isEmpty;

  bool validate();

  dynamic onSaved();

  void setError(String error) {
    setState(() {
      errorMsg = error;
    });
  }
}

// abstract class BaseRefFormFieldState<T extends StatefulHookConsumerWidget> extends BaseFormFieldState<T> {}

// abstract class BaseFormFieldConsumerState<T extends StatefulHookConsumerWidget>
//     extends ConsumerState<T> {
//   String errorMsg = '';

//   bool get isValid => errorMsg.isEmpty;

//   bool validate();

//   dynamic onSaved();
// }

// abstract class BaseRefFormField<T extends ConsumerState> extends BaseFormField{
//   BaseRefFormField({required super.label, required super.fieldKey});
// }

abstract class BaseFormField extends StatefulHookWidget {
  final String fieldKey;
  final String Function(dynamic value)? validator;
  final bool isRequired;
  final bool isEnabled;
  final String initialValue;
  final String label;
  final String? hint;
  final Function(dynamic)? onChanged;

  const BaseFormField({
    super.key,
    this.validator,
    this.hint,
    this.onChanged,
    this.isRequired = true,
    this.isEnabled = true,
    this.initialValue = '',
    required this.label,
    required this.fieldKey,
  });

  // static const height = 70.0;
  static const _ITCAvantGarde = 'ITCAvantGardeStd';

  static const textStyle = TextStyle(
    fontSize: 16,
    color: AppColor.white,
    fontWeight: FontWeight.w500,
    fontFamily: _ITCAvantGarde,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 16,
    color: AppColor.mainBlack,
    fontWeight: FontWeight.w500,
    fontFamily: _ITCAvantGarde,
  );

  static const labelStyle = TextStyle(
    fontSize: 12,
    color: AppColor.labelBlack,
    fontWeight: FontWeight.w300,
    fontFamily: _ITCAvantGarde,
  );

  static var inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.only(bottom: 8.h),
      hintStyle: const TextStyle(
        fontSize: 14,
        color: AppColor.placeHolderBlack,
        fontFamily: _ITCAvantGarde,
      ),
      labelStyle:
          AppTextStyle.description.copyWith(color: AppColor.placeHolderBlack),
      floatingLabelStyle:
          AppTextStyle.action.copyWith(color: AppColor.labelGray),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.white.withOpacity(0.4),
          width: 1,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.brightBlue,
          width: 1,
        ),
      ),
      counterText: '');

  static var blackTextInputDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.only(bottom: 8.h),
    hintStyle: const TextStyle(
      fontSize: 14,
      color: AppColor.placeHolderBlack,
      fontFamily: _ITCAvantGarde,
    ),
    labelStyle: const TextStyle(
      fontSize: 16,
      color: AppColor.mainBlack,
      fontWeight: FontWeight.w300,
      fontFamily: _ITCAvantGarde,
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.lineGray,
        width: 1,
      ),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.lineGray,
        width: 1,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.brightBlue,
        width: 1,
      ),
    ),
  );

  static TextStyle? get formErrorStyle => const TextStyle(
        color: AppColor.errorRed,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        fontFamily: _ITCAvantGarde,
      );
}
