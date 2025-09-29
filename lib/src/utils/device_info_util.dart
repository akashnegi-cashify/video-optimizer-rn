import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoUtil {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static String? _deviceOsVersion;
  static String? _deviceModel;

  static Future<void> init() async {
    _deviceOsVersion = await DeviceUtil.getXOSAPPHeader();
    if (isAndroid()) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      _deviceModel = androidInfo.model;
    } else {
      IosDeviceInfo iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      _deviceModel = iosDeviceInfo.model;
    }
  }

  static String? getOsVersion() {
    return _deviceOsVersion;
  }

  static String? getModelName() {
    return _deviceModel;
  }
}
