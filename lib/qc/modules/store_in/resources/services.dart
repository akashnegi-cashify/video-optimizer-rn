import 'package:flutter_trc/src/services/qc_service.dart';

import 'index.dart';

class StoreInServices {
  static Stream<StoreInLocationVerifyResponse?> verifyLocBarCode(String locationBarcode) {
    var params = {
      "lbc": [locationBarcode]
    };
    return QcService().get(
      '/store-in/verify-cell',
      StoreInLocationVerifyResponse.fromJson,
      params: params,
    );
  }
}
