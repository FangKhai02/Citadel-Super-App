import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'base_web_service.dart';

void appDebugPrint(Object message) {
  if (!kReleaseMode) {
    debugPrint(message.toString());
  }
}

recordError(
  dynamic exception,
  StackTrace? stack,
) {
  bool skipErrorLogging = exception is NoInternetException;
  if (skipErrorLogging) {
    return;
  }

  if (exception is BaseException) {
    if (exception is StatusCodeException) {
      FirebaseCrashlytics.instance.recordError(
        "URL: ${exception.url} Status code: ${exception.statusCode}, ${exception.message}",
        stack ?? StackTrace.current,
      );
    } else if (exception is ApiException) {
      FirebaseCrashlytics.instance.recordError(
        "URL: ${exception.url}, MESSAGE: ${exception.message}",
        stack ?? StackTrace.current,
      );
    } else {
      FirebaseCrashlytics.instance.recordError(
        exception.message,
        stack ?? StackTrace.current,
      );
    }

    return;
  }

  FirebaseCrashlytics.instance.recordError(
    exception,
    stack ?? StackTrace.current,
  );
}

recordFlutterError(FlutterErrorDetails errorDetails) async {
  // final errorDescriptions = errorDetails.context?.value;
  // final errorException = errorDetails.exceptionAsString();
  // bool isImageWidgetError =
  //     errorDetails.library?.contains('image resource service') ?? false;

  // if (!isImageWidgetError) {
  //   return FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  // }
}
