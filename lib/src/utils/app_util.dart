import 'package:console_flutter_template/src/utils/platforms.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:console_flutter_template/src/environments/environment_config.dart';
import 'package:console_flutter_template/src/environments/environments.dart';
import 'package:console_flutter_template/src/types/client_ids.dart';
import 'package:package_info_plus/package_info_plus.dart';

const CLIENT_VERSION = 'v1';

HostPlatform getHostPlatform() {
  if (isWeb()) {
    return HostPlatform.WEB;
  }
  if (isAndroid()) {
    return HostPlatform.ANDROID;
  }
  if (isIOS()) {
    return HostPlatform.IOS;
  }
  return HostPlatform.UNKNOWN;
}

String? getClientId() {
  HostPlatform platform = getHostPlatform();
  switch (platform) {
    case HostPlatform.ANDROID:
      return ClientIds.ANDROID.value;
    case HostPlatform.IOS:
      return ClientIds.IOS.value;
    case HostPlatform.WEB:
      return ClientIds.WEB.value;
    case HostPlatform.UNKNOWN:
    default:
      return null;
  }
}

int? getSourceId() {
  Environment environment = getEnvironment();
  if (environment == null || environment.sourceIds == null) {
    return -1;
  }
  HostPlatform platform = getHostPlatform();
  switch (platform) {
    case HostPlatform.ANDROID:
      return environment.sourceIds!.android;
    case HostPlatform.IOS:
      return environment.sourceIds!.iOS;
    case HostPlatform.WEB:
      return environment.sourceIds!.web;
    case HostPlatform.UNKNOWN:
      return -1;
  }
}

class AppUtil {
  static bool get isInDebugMode {
    return kDebugMode;
  }

  static Future<String?> getAppVersionName() async {
    String? projectVersion;
    if (isWeb()) {
      projectVersion = null;
    } else {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        projectVersion = packageInfo.version;
        Logger.log('projectVersion : $projectVersion');
      } on PlatformException {
        Logger.log('Failed to get project version.');
        projectVersion = null;
      }
    }
    return projectVersion;
  }

  static Future<String?> getAppVersionCode() async {
    String? projectCode;
    if (isWeb()) {
      projectCode = null;
    } else {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        projectCode = packageInfo.buildNumber;
      } on PlatformException {
        Logger.log('Failed to get build number.');
        projectCode = null;
      }
    }
    return projectCode;
  }

  static Future<String> getAppName() async {
    // TODO Change app name
    String appName = '<App Name>';
    if (isWeb()) {
      return appName;
    } else if (isAndroid() || isIOS()) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        appName = packageInfo.appName;
      } on PlatformException {
        Logger.log('Failed to get build number.');
      }
    }
    return appName;
  }
}
