import 'package:csh_annotation/annotation.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

@CshPageParam()
class DisputedImageCaptureScannerParam {
  @ParamKey(key: DisputedImageCaptureScannerParamKeys.scannerCallback)
  Function(String scannedData, MlScannerController? controller)? onScanDetected;

  DisputedImageCaptureScannerParam({
    this.onScanDetected,
  });
}

enum DisputedImageCaptureScannerParamKeys with AbsParamKey {
  scannerCallback("sc");

  @override
  final String value;

  const DisputedImageCaptureScannerParamKeys(this.value);
}
