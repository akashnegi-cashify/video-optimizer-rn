import 'dart:convert';

import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class StoreInServices {
  static Stream<StoreInLocationVerifyResponse?> verifyLocBarCode(String locationBarcode, bool mIsBinIn) {
    var params = {
      "lbc": [locationBarcode]
    };

    String endUrl = mIsBinIn ? "/bin/store-in/verify-cell" : "/store-in/verify-cell";

    return QcService().get(
      endUrl,
      StoreInLocationVerifyResponse.fromJson,
      params: params,
    );
  }

  static Stream<StoreInLocationVerifyResponse?> storeInDevice(StoreInDeviceRequest request, bool mIsBinIn) {
    String endUrl = mIsBinIn ? "/bin/store-in/verify-cell" : "/store-in/verify-cell-v1";

    var headers = QcService().getHeaders(null);
    headers["content-type"] = "application/x-www-form-urlencoded";

    return QcService().post(
      endUrl,
      StoreInLocationVerifyResponse.fromJson,
      body: mIsBinIn
          ? {
              "stockBarcode": request.stockBarcode,
              "locBarcode": request.locBarcode,
            }
          : jsonEncode(request),
      headers: mIsBinIn ? headers : null,
    );
  }
}
