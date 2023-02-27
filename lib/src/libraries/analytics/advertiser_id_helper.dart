import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class AdvertiserIdHelper {
  static String? _advertisingId;

  static Future init() async {
    // TODO add channel id here
    const MethodChannel platform = MethodChannel('<channel id>');

    try {
      _advertisingId = await platform.invokeMethod('getAdvertisingId');
      if (_advertisingId == null || _advertisingId!.isEmpty) {
        await onError();
      }
    } on PlatformException {
      await onError();
    }
  }

  static onError() async {
    DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
    if (isWeb()) {
      return;
    }
    if (isAndroid()) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      _advertisingId = androidInfo.id;
    } else if (isIOS()) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      _advertisingId = iosInfo.identifierForVendor;
    } else {
      //TODO: get DeviceId from backend API
    }
  }

  static String getAdvertisingId() {
    return _advertisingId ?? 'invalid_advertiser_id';
  }
}
