import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class StoreInLocationScanCompParam {
  @ParamKey(key: StoreInLocationScanCompParamKeys.header)
  String? header;

  @ParamKey(key: StoreInLocationScanCompParamKeys.barcode)
  String? barcode;

  @ParamKey(key: StoreInLocationScanCompParamKeys.binStoreIn)
  bool? binStoreIn;

  StoreInLocationScanCompParam({
    this.header,
    this.barcode,
    this.binStoreIn,
  });
}

enum StoreInLocationScanCompParamKeys with AbsParamKey {
  header("h"),
  barcode("br"),
  binStoreIn("bsi");

  @override
  final String value;

  const StoreInLocationScanCompParamKeys(this.value);
}
