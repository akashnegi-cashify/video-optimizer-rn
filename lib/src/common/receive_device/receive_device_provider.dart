import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/receive_device/laptop_receive_device_enum.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_response.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_service.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:provider/provider.dart';

class ReceiveDeviceProvider extends CshChangeNotifier {
  final LaptopReceiveDeviceEnum deviceType;

  ReceiveDeviceProvider({required this.deviceType});

  static ReceiveDeviceProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReceiveDeviceProvider>(context, listen: listen);
  }

  Stream<ReceiveDeviceResponse?> receiveDevice(String barcode) {
    int facilityId = AppPreferences.trc.getFacility()?.id ?? 0;
    return ReceiveDeviceService.scanDevice(barcode, deviceType, facilityId);
  }
}
