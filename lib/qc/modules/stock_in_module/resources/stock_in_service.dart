import '../../../../src/services/qc_service.dart';
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

  static Stream<ValidateAwbResponse?> pushAwb(
    String awbNumber,
    String barcode,
  ) {
    Map<String, List<String>> params = {
      "awb": [awbNumber],
      "qrCode": [barcode]
    };

    return QcService().get(
      "/stock-in/push-to-qc",
      ValidateAwbResponse.fromJson,
      params: params,
    );
  }
}
