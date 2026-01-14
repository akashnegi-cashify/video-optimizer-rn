import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import 'index.dart';

class StoreInServices {
  static Stream<StoreInLocationVerifyResponse?> verifyLocBarCode(String? locationBarcode, bool mIsBinIn,
      {required BaseService service}) {
    var params = {
      "lbc": [locationBarcode.toString()]
    };

    String endUrl = mIsBinIn ? "/bin/store-in/verify-cell" : "/v1/store-in/validate-location";

    return service.get(
      endUrl,
      StoreInLocationVerifyResponse.fromJson,
      params: params,
    );
  }

  static Stream<StoreInLocationVerifyResponse?> storeInDevice(StoreInDeviceRequest request, bool mIsBinIn,
      {required BaseService service}) {
    // mIsBinIn check is only for QC; TRC always uses POST
    final isQc = service.getServiceGroup() == TRCServiceGroups.qcConsole;
    
    if (isQc && mIsBinIn) {
      final params = <String, List<String>>{
        "lbc": [request.locBarcode.toString()],
      };
      return service.get(
        "/bin/store-in/verify-location",
        StoreInLocationVerifyResponse.fromJson,
        params: params,
      );
    } else {
      // Normal store-in for QC OR all TRC calls
      const String endUrl = "/v1/store-in/verify-cell";

      var headers = service.getHeaders(null);
      headers["content-type"] = "application/json";

      return service.post(
        endUrl,
        StoreInLocationVerifyResponse.fromJson,
        body: jsonEncode(request),
        headers: headers,
      );
    }
  }
}
