import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DeviceInfoHandler {
  static final DeviceInfoHandler _instance = DeviceInfoHandler._internal();

  String DRAWABLE_MDPI = "mdpi";
  String DRAWABLE_HDPI = "hdpi";
  String DRAWABLE_XHDPI = "xhdpi";
  String DRAWABLE_XXHDPI = "xxhdpi";
  String DRAWABLE_XXXHDPI = "xxxhdpi";

  String? densityFolder;

  factory DeviceInfoHandler() {
    return _instance;
  }

  DeviceInfoHandler._internal();

  syncDeviceDetails(BuildContext context) {
    getDeviceRatio(context);
  }

  void getDeviceRatio(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    var dpi = (data.devicePixelRatio) * 160;
    if (dpi >= 400) {
      densityFolder = DRAWABLE_XXHDPI;
    } else if (dpi >= 320) {
      densityFolder = DRAWABLE_XHDPI;
    } else if (dpi >= 240) {
      densityFolder = DRAWABLE_HDPI;
    } else if (dpi >= 100) {
      densityFolder = DRAWABLE_MDPI;
    } else {
      densityFolder = DRAWABLE_XHDPI;
    }
    Logger.log('Device Ratio==>  ${data.devicePixelRatio}  $densityFolder');
  }
}
