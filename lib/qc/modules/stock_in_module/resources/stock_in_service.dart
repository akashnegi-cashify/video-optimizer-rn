import 'dart:convert';

import '../../../../src/services/qc_service.dart';
import '../models/stock_in_submit_response.dart';
import '../models/stock_in_sumit_request.dart';
import '../models/validate_awb_response.dart';

class StockInService {
  static Stream<ValidateAwbResponse?> validateAwb(
    String awbNumber,
    String barcode,
  ) {
    Map<String, List<String>> params = {
      "awb": [awbNumber],
      "qrCode": [barcode]
    };

    return QcService().get(
      "/stock-in/validate-awb",
      ValidateAwbResponse.fromJson,
      params: params,
    );
  }

  static Stream<StockInSubmitResponse?> pushAwb(StockInSubmitRequest request) {

    return QcService().post(
      "/stock-in/push-to-qc",
      StockInSubmitResponse.fromJson,
      body: jsonEncode(request),
    );
  }
}
