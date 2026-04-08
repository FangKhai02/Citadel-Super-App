import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color primaryBackground = Color(0xFF223050);
  static const Color darkBlue = Color(0xFF25304E);
  static const Color cyan = Color(0xFF467191);
  static const Color brightBlue = Color(0xFF5CAFE0);
  static const Color primaryUnselect = Color(0xFF1D3046);
  static const Color white = Color(0xFFFFFFFF);
  static const Color errorRed = Color(0xFFFF636F);
  static const Color mainBlack = Color(0xFF010414);
  static const Color actionBlack = Color(0xFF303031);
  static const Color disabledBlack = Color(0xFF484849);
  static const Color descriptionBlack = Color(0xFF606062);
  static const Color labelBlack = Color(0xFF78787A);
  static const Color noteBlack = Color(0xFF929293);
  static const Color placeHolderBlack = Color(0xFFABABAD);
  static const Color neutralGray = Color(0xFFC5C5C6);
  static const Color labelGray = Color(0xFFD2D2D3);
  static const Color lineGray = Color(0xFFDEDEE0);
  static const Color offWhite = Color(0xFFF8F8F9);
  static const Color popupGray = Color(0xFF4D4F5A);
  static const Color bigBlue = Color(0xFF01437b);
  static const Color green = Color(0xFF34C759);
  static const Color yellow = Color(0xFFFFCC00);
  static const Color orange = Color(0xFFFF9500);
  static const Color mint = Color(0xFF00C7BE);
  static const Color correctGreen = Color(0xFF63FFBE);
  static const Color actionYellow = Color(0xFFE0C15C);

  static const LinearGradient darkToBrightGradient = LinearGradient(
    colors: [mainBlack, cyan, brightBlue],
    stops: [0.6, 0.8, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkToBrightGradientSplash = LinearGradient(
    colors: [mainBlack, brightBlue],
    stops: [0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkToBrightGradient2 = LinearGradient(
    colors: [mainBlack, primaryUnselect],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient brightToDarkGradient = RadialGradient(
      colors: [brightBlue, darkBlue, mainBlack],
      stops: [0.0, 0.4, 0.7],
      center: Alignment.topCenter,
      radius: 1.2);

  static const LinearGradient brightToDarkGradient2 = LinearGradient(
    colors: [cyan, Color(0xFF2F2D42), mainBlack],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient blueToOrangeGradient = LinearGradient(
    colors: [primaryBackground, Color(0xFF2F2D42), mainBlack],
    stops: [0.0, 0.6, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient maintenanceGradient = RadialGradient(
      colors: [brightBlue, Color(0xFF3D5671), Color(0xFF2F2D42), mainBlack],
      stops: [0.1, 0.4, 0.8, 1.0],
      center: Alignment.topRight,
      radius: 2.2);

  static const LinearGradient loadingGradient = LinearGradient(
      colors: [Color(0xFFB2DBF3), Color(0xFF5CAFE0), Color(0xFF467191)]);
}
