import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class BarcodeScannerService {
  static Stream<SuccessResponse?> scanBarcodeMethod(String data) {
    return QcService().post(
      "/assign/test/device/$data",
      userAuth: true,
      authorization: true,
      SuccessResponse.fromJson,
    );
  }
}
