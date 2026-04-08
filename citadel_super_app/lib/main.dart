import 'dart:async';

import 'package:citadel_super_app/app_folder/app_theme.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/screen/splash_page.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:citadel_super_app/service/one_signal_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final globalRef = ProviderContainer();

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb) {
      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(kReleaseMode);
    }

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set system UI overlay style
    // The opt-out flag in styles.xml handles the edge-to-edge behavior
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    runApp(
      UncontrolledProviderScope(container: globalRef, child: const MainApp()),
    );
  }, (error, stack) => appDebugPrint(error));
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (!kIsWeb) {
        OneSignalService.instance.init();
      }
      return null;
    }, []);

    return LayoutBuilder(builder: (context, constraints) {
      final double maxWidth =
          constraints.maxWidth < 600 ? double.infinity : 400;

      return ColoredBox(
        color: Colors.black,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              child: MaterialApp(
                navigatorKey: navigatorKey,
                theme: AppTheme.citadelTheme,
                onGenerateRoute: kIsWeb
                    ? CustomRouter.generateWebRoute
                    : CustomRouter.generateRoute,
                initialRoute:
                    kIsWeb ? CustomRouter.webAgreement : CustomRouter.splash,
                builder: EasyLoading.init(builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: MediaQuery.of(context)
                          .textScaler
                          .clamp(minScaleFactor: 1, maxScaleFactor: 1.4),
                    ),
                    child: child!,
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
