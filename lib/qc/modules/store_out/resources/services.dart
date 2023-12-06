import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';

import '../../../../src/common/resources/lot_list_request.dart';
import 'index.dart';

class StoreOutServices {
  static Stream<StoreOutBinListResponse?> fetchStoreOutBinList({required BaseService service}) {
    return service.get('/bin/lot/store-out/list', StoreOutBinListResponse.fromJson);
  }

  static Stream<StoreOutLotListResponse?> fetchStoreOutLotList(LotListRequest request, {required BaseService service}) {
    return service.post(
      '/store-out/v2',
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
      "/store-out/v2/devices",
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

  static Stream<NormalLotVerifyResponse?> normalLotVerifyBarCodeService(NormalLotOutRequest request,
      {required BaseService service}) {
    var header = service.getHeaders(null);
    return service.post("/store-out/v2/device", NormalLotVerifyResponse.fromJson,
        body: jsonEncode(request), headers: header);
  }
}
