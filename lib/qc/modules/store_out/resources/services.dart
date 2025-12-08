import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/store_out/resources/store_out_in_process_response.dart';

import '../../../../src/common/resources/lot_list_request.dart';
import 'index.dart';

class StoreOutServices {
  static Stream<StoreOutBinListResponse?> fetchStoreOutBinList({required BaseService service}) {
    return service.get('/bin/lot/store-out/list', StoreOutBinListResponse.fromJson);
  }

  static Stream<StoreOutLotListResponse?> fetchStoreOutLotList(LotListRequest request, {required BaseService service}) {
    return service.post(
      '/v1/store-out/list',
      StoreOutLotListResponse.fromJson,
      body: jsonEncode(request),
    );
  }

  static Stream<BinOutVerifyResponse?> binOutVerifyBarCodeService(BinOutRequest request,
      {required BaseService service}) {
    var header = service.getHeaders(null);
    header["content-type"] = "application/x-www-form-urlencoded";
    return service.post("/bin/lot/store-out", BinOutVerifyResponse.fromJson,
        body: {
          "stockBarcode": request.stockBarcode,
          "locBarcode": request.locBarcode,
        },
        headers: header);
  }

  static Stream<ScanNormalLotListResponse?> fetchNormalScanLotList(String lotName, int lotType,
      {required BaseService service}) {
    var param = {
      "gln": [lotName]
    };
    return service.get(
      "/v1/store-out/devices",
      ScanNormalLotListResponse.fromJson,
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

  static Stream<NormalLotVerifyResponse?> normalLotVerifyBarCodeService({
    required String lotGroupName,
    required String qrCode,
    required String displayBarcode,
    required BaseService service,
  }) {
    var header = service.getHeaders(null);
    final body = jsonEncode({
      "lotGroupName": lotGroupName,
      "qrCode": qrCode,
      "displayBarcode": displayBarcode,
    });
    return service.post("/v1/store-out/device", NormalLotVerifyResponse.fromJson,
        body: body, headers: header);
  }

  static Stream<StoreOutInProcessResponse?> getStoreOutInProcessStatus(
      int? lotId, String? groupName, {required BaseService service}) {
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
