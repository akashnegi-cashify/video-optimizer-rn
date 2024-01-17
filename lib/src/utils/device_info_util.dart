import 'package:core_widgets/core_widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoUtil {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static String? _deviceOsVersion;
  static String? _deviceModel;

  static Future<void> init() async {
    _deviceOsVersion = await DeviceUtil.getXOSAPPHeader();
    AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
    _deviceModel = androidInfo.model;
  }

  static String? getOsVersion() {
    return _deviceOsVersion;
  }

  static String? getModelName() {
    return _deviceModel;
  }
}
