import 'package:flutter_trc/qc/modules/device_details/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/device_details/resources/stock_movement_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class DeviceDetailService {
  static Stream<DeviceDetailResponse?> getDeviceDetails(String deviceBarcode) {
    return QcService().get("/device/detail?qrcode=$deviceBarcode", DeviceDetailResponse.fromJson);
  }

  static Stream<StockMovementResponse?> getDeviceStockMovement(String deviceBarcode) {
    return QcService().get("/device/stock-movement/$deviceBarcode", StockMovementResponse.fromJson);
  }
}
