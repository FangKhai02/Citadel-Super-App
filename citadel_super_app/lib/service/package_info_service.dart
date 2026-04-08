import 'package:package_info_plus/package_info_plus.dart';

import 'log_service.dart';

class PackageInfoService {
  PackageInfoService._();

  String? packageAppName;
  String? packageName;
  String? packageVersion;
  String? packageBuildNumber;

  static PackageInfoService instance = PackageInfoService._();
  late PackageInfo packageInfo;

  Future init() async {
    try {
      packageInfo = await PackageInfo.fromPlatform();
      packageAppName = packageInfo.appName;
      packageName = packageInfo.packageName;
      packageVersion = packageInfo.version;
      packageBuildNumber = packageInfo.buildNumber;
    } catch (e, s) {
      recordError(e, s);
    }
  }
}
