import 'package:csh_annotation/annotation.dart';
import 'package:ml_barcode_scanner/resources/scan_formats.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

@CshPageParam()
class StoreInCompParam {
  @ParamKey(key: StoreInCompParamKeys.header)
  String? header;

  @ParamKey(key: StoreInCompParamKeys.scannerCallback)
  Function(String scannedData, MlScannerController? controller)? onScanDetected;

  @ParamKey(key: StoreInCompParamKeys.binStoreIn)
  bool? binStoreIn;

  @ParamKey(key: StoreInCompParamKeys.scanFormats)
  List<ScanFormats>? scanFormatList;

  StoreInCompParam({
    this.header,
    this.onScanDetected,
    this.binStoreIn,
    this.scanFormatList,
  });
}

enum StoreInCompParamKeys with AbsParamKey {
  scannerCallback("sc"),
  header("h"),
  scanFormats("sf"),
  binStoreIn("bsi");

  @override
  final String value;

  const StoreInCompParamKeys(this.value);
}
