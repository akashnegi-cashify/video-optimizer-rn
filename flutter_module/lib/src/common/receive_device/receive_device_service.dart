import 'package:flutter_trc/src/common/receive_device/laptop_receive_device_enum.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class ReceiveDeviceService {
  static Stream<ReceiveDeviceResponse?> scanDevice(
    String barcode,
    LaptopReceiveDeviceEnum type,
    int facilityId,
  ) {
    Map<String, List<String>> params = {
      "dbr": [barcode],
      "fid": [facilityId.toString()],
    };
    return TrcService().post(
      "/laptop/${type.value}/device/scan",
      ReceiveDeviceResponse.fromJson,
      params: params,
    );
  }
}
