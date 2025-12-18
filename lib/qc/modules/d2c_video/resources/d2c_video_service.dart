import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_device_list_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class D2CVideoService {
  static Stream<BaseResponse> saveVideo(String? deviceBarcode, String? videoUrl) {
    var req = {
      'url': videoUrl,
    };
    return QcService().post("/device/recording/$deviceBarcode/save", BaseResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<D2CDeviceDetailResponse> getDeviceDetails(String? deviceBarcode) {
    return QcService().get("/device/recording/$deviceBarcode/detail", D2CDeviceDetailResponse.fromJson);
  }

  static Stream<List<D2cLotDeviceListData>> getLotDeviceList(int lotId, String groupLotName) {
    return QcService()
        .getArray("/device/recording/pending-lot-device-list?lotId=$lotId", D2cLotDeviceListData.fromJson);
  }

  static Stream<BaseResponse> updateLotStatus(int lotId, String groupLotName) {
    Map<String, dynamic> req = {
      'lotId': lotId,
      'groupLotName': groupLotName,
    };
    return QcService().post("/device/recording/update-group", BaseResponse.fromJson, body: jsonEncode(req));
  }
}
