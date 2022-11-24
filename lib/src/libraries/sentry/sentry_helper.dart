import 'dart:async';

import 'package:console_flutter_template/src/environments/environment_config.dart';
import 'package:console_flutter_template/src/environments/types.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryHelper {
  // TODO: Dev Action Required -> add sentry dns here
  static const _DSN = '<enter DNS>';

  static Future<void> init(String environment, AppRunner appRunner) async {
    SentryFlutter.init((options) {
      options.dsn = _DSN;
      options.environment = environment;
      options.beforeSend = _beforeSend;
    }, appRunner: appRunner);
  }

  static SentryEvent? _beforeSend(SentryEvent event, {dynamic hint}) {
    if (kDebugMode) {
      Logger.log('In dev mode. Not sending report to Sentry.io.');
      return null;
    }

    List<SentryException>? exceptionList = event.exceptions;
    if (exceptionList == null) {
        return null;
    }
    if (exceptionList.isNotEmpty) {
      for (int i = 0; i < exceptionList.length; i++) {
        SentryException exception = exceptionList[i];
        if (exception.mechanism?.handled == true) {
          exceptionList.removeAt(i);
          continue;
        }
        if (exception.mechanism?.type == "_CastError") {
          exceptionList.removeAt(i);
          continue;
        }
        if (exception.mechanism?.type == "_AssertionError") {
          exceptionList.removeAt(i);
          continue;
        }
        if (exception.mechanism?.type == "FlutterError") {
          exceptionList.removeAt(i);
          continue;
        }
      }
    }
    if (environment?.mode == EnvironmentTypes.PROD.value) {
      return event;
    }
    Logger.log('In non prod mode. Not sending report to Sentry.io.');
    return null;
  }
}
