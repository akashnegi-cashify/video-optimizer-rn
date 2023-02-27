import 'dart:async';

import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtil {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  // TODO Dev action required: Update the xOSApp value
  static const String xOSApp = 'CMSITE-1.0';

  static Future<String> getXOSAPPHeader() async {
    if (isWeb()) {
      return xOSApp;
    } else if (isAndroid()) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return 'AND-${androidInfo.version.release}';
    } else if (isIOS()) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return 'IOS-${iosInfo.systemVersion}';
    } else {
      return xOSApp;
    }
  }

  static Future<String?> getDeviceId() async {
    if (isWeb()) {
      return xOSApp;
    } else if (isAndroid()) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (isIOS()) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      return xOSApp;
    }
  }
}
