import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_location_verify_response.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_in_process_response.dart';

import 'index.dart';

class StoreOutServices {
  static Stream<StoreInLocationVerifyResponse?> binOutVerifyBarCodeService(BinOutRequest request,
      {required BaseService service}) {
    return service.post("/bin/store-out", StoreInLocationVerifyResponse.fromJson,
        body: jsonEncode({
          "stockBarcode": request.stockBarcode,
          "locBarcode": request.locBarcode, 
        }));
  }

  static Stream<List<ScanNormalLotItem>?> fetchNormalScanLotList(int? lotId, int lotType,
      {required BaseService service}) {
    var param = {
      "lid": [lotId.toString()]
    };
    return service.getArray(
      "/v1/store-out/devices",
      ScanNormalLotItem.fromJson,
      params: param,
    );
  }

  static Stream<ScanBinLotListResponse?> fetchBinScanLotList(String lotName, int lotType,
      {required BaseService service}) {
    var param = {
      "ln": [lotName]
    };
    return service.get(
      "/bin/lot/store-out/device/list",
      ScanBinLotListResponse.fromJson,
      params: param,
    );
  }

  // TO DO : need to  send id
  static Stream<BaseResponse?> normalLotVerifyBarCodeService({
    required int? lotId,
    required String qrCode,
    required String displayBarcode,
    required BaseService service,
  }) {
    var header = service.getHeaders(null);
    final body = jsonEncode({
      "lotId": lotId,
      "qrCode": qrCode,
      "displayBarcode": displayBarcode,
    });
    return service.post("/v1/store-out/device", BaseResponse.fromJson, body: body, headers: header);
  }

  static Stream<StoreOutInProcessResponse?> getStoreOutInProcessStatus(int? lotId, String? groupName,
      {required BaseService service}) {
    final params = <String, List<String>>{
      "lid": [lotId.toString()],
      if (groupName != null) "gn": [groupName],
    };
    return service.get(
      "/v1/store-out/store-out-status",
      StoreOutInProcessResponse.fromJson,
      params: params,
    );
  }
}
