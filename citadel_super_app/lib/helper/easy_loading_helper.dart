import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingHelper {
  static void show() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black, dismissOnTap: false);
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}
