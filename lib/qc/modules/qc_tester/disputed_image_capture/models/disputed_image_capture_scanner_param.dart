import 'package:csh_annotation/annotation.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

@CshPageParam()
class DisputedImageCaptureScannerParam {
  @ParamKey(key: DisputedImageCaptureScannerParamKeys.scannerCallback)
  Function(String scannedData, MlScannerController? controller)? onScanDetected;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.header)
  String? header;

  @ParamKey(key: DisputedImageCaptureScannerParamKeys.hintText)
  String? hintText;

  DisputedImageCaptureScannerParam({
    this.onScanDetected,
    this.hintText,
    this.header,
  });
}

enum DisputedImageCaptureScannerParamKeys with AbsParamKey {
  scannerCallback("sc"),
  header("h"),
  hintText("ht");

  @override
  final String value;

  const DisputedImageCaptureScannerParamKeys(this.value);
}
