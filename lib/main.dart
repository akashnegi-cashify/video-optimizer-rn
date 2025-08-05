import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app.dart';
import 'package:flutter_trc/src/interceptors/interceptors_helper.dart';
import 'package:flutter_trc/src/utils/app_util.dart';

import 'src/app_initializer.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await AppInitializer.init(interceptors: InterceptorsHelper.getGlobalInterceptors());

    String appName = await AppUtil.getAppName();

    // Enabled below code to Specifies the style to use for the system overlays that are visible (if any)
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(
    //       statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark),
    // );

    return runApp(CashifyApp(appName));
  }, (error, stack) {
    Logger.debug('mydebug-----main', [error, stack]);

    if (error is HttpErrorResponse || !kReleaseMode) {
      return;
    }

    try {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } catch (e) {
      FirebaseCrashlytics.instance.log("FirebaseCrashlytics catch error: $e");
      FirebaseCrashlytics.instance.recordFlutterError(
        FlutterErrorDetails(exception: e, stack: StackTrace.current),
      );
    }
    // FlutterError.onError = (errorDetails) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    // };
    // // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };
  });
}
