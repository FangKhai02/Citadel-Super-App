import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/screen/maintenance/maintenance_page.dart';
import 'package:citadel_super_app/service/base_web_service.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:citadel_super_app/service/session_service.dart';
import 'package:flutter/material.dart';

extension FutureExtension<T> on Future<T> {
  Future baseThen(
    BuildContext context, {
    required Function(T value) onResponseSuccess,
    Function(ResponseErrorException e, StackTrace s)? onResponseError,
  }) {
    return then(onResponseSuccess)
        .invalidSessionError(context)
        .serverUnderMaintenance(context)
        .serverError(context)
        .responseError(context, onResponseError)
        .genericError(context);
  }
}

extension FutureErrorExtension on Future {
  Future invalidSessionError(BuildContext context) {
    return onError((InvalidSessionException e, s) {
      context.showWarningSnackBar("Session Expired");
      SessionService.removeSession();
      Navigator.pushNamedAndRemoveUntil(
          context, CustomRouter.login, (route) => false);
    });
  }

  Future serverError(BuildContext context) {
    return onError((ServerError e, s) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AppDialog(
                title: 'Something went wrong',
                message: 'Please try again in awhile.',
                isRounded: true,
                positiveOnTap: () {
                  Navigator.pop(context);
                },
                showNegativeButton: false,
                positiveText: 'Ok');
          });
    });
  }

  Future serverUnderMaintenance(BuildContext context) {
    return onError((ServerUnderMaintenance e, s) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        CustomRouter.maintenance,
        (route) => false,
        arguments: MaintenancePage(
          startDatetime: e.startDatetime ?? "N/A",
          endDatetime: e.endDatetime ?? "N/A",
        ),
      );
    });
  }

  Future responseError(BuildContext context,
      Function(ResponseErrorException e, StackTrace s)? onResponseError) {
    return onError((ResponseErrorException e, s) {
      if (e.message.equalsIgnoreCase('api.agent.of.client.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'You don’t have an agent assigned to you. Please contact our customer support.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.bank.details.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bank details not found. Try again'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.agreement.signed')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'This agreement has already been signed, please contact support'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.duplicate.email.between.profiles')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'This email address is already associated with another account. Please use a different email or contact our customer service team for assistance.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.beneficiary.exist')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'This beneficiary name already exists. Please enter a different name.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.company.registration.number.has.taken')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'The company registration number has been taken by another user.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.duplicate.request')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please retry.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.corporate.account.update.not.allowed')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'The corporate account is not able to be updated. Please try again.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.missing.required.details')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please ensure all details are filled in.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.client.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User does not exist'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.user.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User does not exist'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.agent.profile.terminated')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Agent has been terminated. Contact customer support for assistance'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.corporate.client.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corporate user not found'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.shareholder.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shareholder details is not found'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.invalid.file.format')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'File format is invalid. Ensure the following format is accepted. PDF, JPEG,JPG and PNG only.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.invalid.shareholdings.percentage')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Shareholder value is invalid. Please key in value within 1-100.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.corporate.shareholder.limit.5.exceeded')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Number of shareholder has exceeded 5'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.pep.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PEP details is not found'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.corporate.beneficiary.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corporate beneficiary details is not found'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.guardian.exist')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Guardian details already exists. Please enter another guardian user details.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.corporate.guardian.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corporate guardian is not found'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.minimum.two.documents.required')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Minimum 2 documents is required to be uploaded.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.maximum.six.documents.allowed')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Maximum 6 document is required to be uploaded'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.duplicate.file.names')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File uploaded is duplicated. Please check.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.corporate.beneficiary.limit.10.exceeded')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corporate beneficiary has exceeded maximum 10'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message
          .equalsIgnoreCase('api.corporate.bank.details.limit.2.exceeded')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Corporate bank has exceeded 2.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.bank.account.exists')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bank account does not exists'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else if (e.message.equalsIgnoreCase('api.product.order.not.found')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Product order is not found. Please contact customer support for assistance.'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      } else {
        if (onResponseError != null) {
          onResponseError.call(e, s);
        } else {
          context.showErrorSnackBar(e.message);
        }
      }
    });
  }

  Future genericError(BuildContext context) {
    return catchError((e, s) {
      recordError(e, s);
      context.showErrorSnackBar("Something Went Wrong");
    });
  }
}
