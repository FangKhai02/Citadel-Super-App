import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData citadelTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.white),
    dialogTheme: const DialogThemeData(backgroundColor: AppColor.white),
    dividerTheme: const DividerThemeData(color: AppColor.lineGray, space: 0),
    primaryColor: AppColor.brightBlue,
    primaryIconTheme: const IconThemeData(color: AppColor.white),
    primaryColorDark: null,
    radioTheme: const RadioThemeData(),
    elevatedButtonTheme: null,
    outlinedButtonTheme: null,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.brightBlue.withOpacity(0.3),
      selectionHandleColor: AppColor.brightBlue,
      cursorColor: AppColor.brightBlue,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          alignment: Alignment.bottomLeft,
          backgroundColor: WidgetStateProperty.all<Color>(
              const Color.fromARGB(255, 54, 48, 48)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
        textStyle: BaseFormField.textStyle,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppColor.placeHolderBlack,
          ),
          labelStyle: TextStyle(
            fontSize: 14,
            color: AppColor.labelGray,
            fontWeight: FontWeight.w500,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.labelGray,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.labelGray,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.brightBlue,
              width: 1,
            ),
          ),
        )),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 14,
        color: AppColor.placeHolderBlack,
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        color: AppColor.labelGray,
        fontWeight: FontWeight.w500,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.labelGray,
          width: 1,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.labelGray,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.brightBlue,
          width: 1,
        ),
      ),
    ),
  );
}
