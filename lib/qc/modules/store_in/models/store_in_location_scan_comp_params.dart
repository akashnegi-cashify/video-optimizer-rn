import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class StoreInLocationScanCompParam {
  @ParamKey(key: StoreInLocationScanCompParamKeys.header)
  String? header;

  @ParamKey(key: StoreInLocationScanCompParamKeys.barcode)
  String? barcode;

  @ParamKey(key: StoreInLocationScanCompParamKeys.totalCount)
  int? totalCount;

  @ParamKey(key: StoreInLocationScanCompParamKeys.availableSpace)
  int? availableSpace;

  StoreInLocationScanCompParam({
    this.header,
    this.barcode,
    this.totalCount,
    this.availableSpace,
  });
}

enum StoreInLocationScanCompParamKeys with AbsParamKey {
  header("h"),
  barcode("br"),
  totalCount("tc"),
  availableSpace("as");

  @override
  final String value;

  const StoreInLocationScanCompParamKeys(this.value);
}
