import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/screen/sign_up/set_password_page.dart';
import 'package:flutter/cupertino.dart';

class DeeplinkService {
  static const String resetPassword = "reset-password";
  static final DeeplinkService instance = DeeplinkService._();

  DeeplinkService._();

  StreamSubscription startListen(
    BuildContext context,
  ) {
    final appLinks = AppLinks(); // AppLinks is singleton

    return appLinks.uriLinkStream.listen((uri) {
      handleLink(getAppContext() ?? context, uri);
    });
  }

  void handleLink(BuildContext context, Uri uri) {
    final host = uri.host;
    final path = uri.path;
    final query = uri.queryParameters;

    switch (host) {
      case resetPassword:
        _handleResetPassword(context, path, query);
    }
  }

  void _handleResetPassword(
      BuildContext context, String token, Map<String, String> query) async {
    if (token.isEmpty) {
      return;
    }

    Navigator.pushNamed(
      context,
      CustomRouter.setPassword,
      arguments: SetPasswordPage(
        base64ResetToken: token.replaceFirst('/', ''),
      ),
    );
  }
}
