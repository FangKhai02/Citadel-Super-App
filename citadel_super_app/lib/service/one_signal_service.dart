import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  //todo this is citadel one signal
  static const appId = "ffaf0368-4e24-43af-bdb5-1eaffa111ca1";
  // static const appId = "811ea829-52b1-4422-a794-8fe95d60e133";
  static final OneSignalService instance = OneSignalService._();
  Function()? _onReceived;

  OneSignalService._();

  void init() {
    //Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(appId);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);
  }

  Future<void> subscribe() async {
    await OneSignal.User.pushSubscription.optIn();
  }

  Future<void> unsubscribe() async {
    await OneSignal.User.pushSubscription.optOut();
  }

  bool didSubscribed() {
    return OneSignal.User.pushSubscription.optedIn ?? true;
  }

  ///Client
  void addSecureTagListener(Function()? onReceived) {
    _onReceived = onReceived;
    OneSignal.Notifications.addForegroundWillDisplayListener(_secureTag);
  }

  void removeSecureTagListener() {
    _onReceived = null;
    OneSignal.Notifications.removeForegroundWillDisplayListener(_secureTag);
  }

  void _secureTag(OSNotificationWillDisplayEvent items) {
    if (appContext == null) return;

    _onReceived?.call();
  }
}
