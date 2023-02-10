  import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app.dart';
import 'package:flutter_trc/src/interceptors/interceptors_helper.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/sentry/sentry_helper.dart';
import 'package:flutter_trc/src/utils/app_util.dart';

import 'src/app_initializer.dart';

void main() async {
  await SentryHelper.init(RUNNING_SYSTEM_ENV, () async {
    WidgetsFlutterBinding.ensureInitialized();

    await AppInitializer.init(
        trackers: AnalyticsController.getTrackers(), interceptors: InterceptorsHelper.getGlobalInterceptors());

    String appName = await AppUtil.getAppName();

    // TODO: Enabled below code to Specifies the style to use for the system overlays that are visible (if any)
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(
    //       statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark),
    // );

    return runApp(CashifyApp(appName));
  });
}
