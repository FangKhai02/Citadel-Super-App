import 'dart:convert';

import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:flutter/material.dart';

class FormValidationHelper {
  void resolveValidationError(
      GlobalKey<AppFormState> formKey, String errorMsgMap) {
    try {
      Map<String, dynamic> error = jsonDecode(errorMsgMap);
      for (var element in (error['fields'] as List)) {
        String fieldKey = element.split('Vo.').last;

        if (fieldKey == 'identityCardFrontImage' ||
            fieldKey == 'identityCardBackImage') {
          fieldKey = AppFormFieldKey.documentImageKey;
        }

        switch (fieldKey) {
          case AppFormFieldKey.emailKey:
            formKey.currentState!
                .setError(fieldKey: fieldKey, errorMsg: 'Invalid Email Format');
            break;
          case AppFormFieldKey.mobileNumberKey:
            formKey.currentState!.setError(
                fieldKey: fieldKey, errorMsg: 'Invalid Mobile Number');
            break;
          case AppFormFieldKey.agentReferralCodeKey:
            formKey.currentState!.setError(
                fieldKey: fieldKey, errorMsg: 'Invalid Referral Code');
            break;
          default:
            formKey.currentState!.setError(fieldKey: fieldKey);
            break;
        }
      }
    } catch (e) {
      appDebugPrint(e);
    }
  }
}
