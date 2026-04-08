import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/state/beneficiary_distribution_state.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/inbox_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/data/state/sign_up_state.dart';
import 'package:citadel_super_app/main.dart';
import 'package:citadel_super_app/service/one_signal_service.dart';
import 'package:citadel_super_app/service/secure_storage_service.dart';

abstract class SessionService {
  static String? apiKey;

  static bool get isLogout => apiKey == null || (apiKey ?? "").isEmpty;

  static bool get isLogin => !isLogout;

  static Future<void> init() async {
    apiKey = await SecureStorageService.getString(key: AppConstant.kApiKey);
  }

  static Future<void> setSession(String? apiKey) async {
    await SecureStorageService.setString(
        key: AppConstant.kApiKey, value: apiKey);
    SessionService.apiKey = apiKey;
  }

  static Future<void> deleteSession() async {
    await SecureStorageService.deleteKey(key: AppConstant.kApiKey);
    apiKey = null;
  }

  static removeSession() async {
    SessionService.deleteSession();
    globalRef.invalidate(beneficiaryDistributionProvider);
    globalRef.invalidate(bottomNavigationProvider);
    globalRef.invalidate(inboxProvider);
    globalRef.invalidate(profileProvider);
    globalRef.invalidate(purchaseFundProvider);
    globalRef.invalidate(signUpProvider);
    await OneSignalService.instance.unsubscribe();
  }
}
