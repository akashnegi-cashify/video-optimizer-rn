import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

@CshPageParam()
class StoreInCompParam {
  @ParamKey(key: StoreInCompParamKeys.header)
  String? header;

  @ParamKey(key: StoreInCompParamKeys.scannerCallback)
  Function(String scannedData, MlScannerController? controller)? onScanDetected;

  @ParamKey(key: StoreInCompParamKeys.binStoreIn)
  bool? binStoreIn;

  StoreInCompParam({this.header,this.onScanDetected,this.binStoreIn,});
}

enum StoreInCompParamKeys with AbsParamKey {
  scannerCallback("sc"),
  header("h"),
  binStoreIn("bsi");


  @override
  final String value;

  const StoreInCompParamKeys(this.value);
}
