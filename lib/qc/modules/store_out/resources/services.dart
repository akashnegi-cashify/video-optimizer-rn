import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import '../../../../src/common/resources/lot_list_request.dart';
import '../../../../src/common/resources/lot_type_filter_response.dart';
import 'index.dart';

class StoreOutServices {
  static Stream<StoreOutBinListResponse?> fetchStoreOutBinList() {
    return QcService().get('/bin/lot/store-out/list', StoreOutBinListResponse.fromJson);
  }

  static Stream<StoreOutLotListResponse?> fetchStoreOutLotList(LotListRequest request) {
    return QcService().post(
      '/store-out/v2',
      StoreOutLotListResponse.fromJson,
      body: jsonEncode(request),
    );
  }

  static Stream<LotTypeFilterResponse?> storeOutLotTypeFilters() {
    return QcService().get(
      "/store-out/v2/list-lot-types",
      LotTypeFilterResponse.fromJson,
    );
  }

  static Stream<BinOutVerifyResponse?> binOutVerifyBarCodeService(BinOutRequest request) {
    var header = QcService().getHeaders(null);
    header["content-type"] = "application/x-www-form-urlencoded";
    return QcService().post("/bin/lot/store-out", BinOutVerifyResponse.fromJson,
        body: {
          "stockBarcode": request.stockBarcode,
          "locBarcode": request.locBarcode,
        },
        headers: header);
  }

  static Stream<ScanNormalLotListResponse?> fetchNormalScanLotList(String lotName, int lotType) {
    var param = {
      "gln": [lotName]
    };
    return QcService().get(
      "/store-out/v2/devices",
      ScanNormalLotListResponse.fromJson,
      params: param,
    );
  }

  static Stream<ScanBinLotListResponse?> fetchBinScanLotList(String lotName, int lotType) {
    var param = {
      "ln": [lotName]
    };
    return QcService().get(
      "/bin/lot/store-out/device/list",
      ScanBinLotListResponse.fromJson,
      params: param,
    );
  }


  static Stream<NormalLotVerifyResponse?> normalLotVerifyBarCodeService(NormalLotOutRequest request) {
    var header = QcService().getHeaders(null);
    return QcService().post("/store-out/v2/device", NormalLotVerifyResponse.fromJson,
        body: jsonEncode(request),
        headers: header);
  }
}
