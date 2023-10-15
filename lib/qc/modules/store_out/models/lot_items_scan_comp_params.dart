import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class LotItemsScanCompParam {
  @ParamKey(key: LotItemsScanCompParamKeys.header)
  String? header;

  @ParamKey(key: LotItemsScanCompParamKeys.lotName)
  String? lotName;

  @ParamKey(key: LotItemsScanCompParamKeys.lotType)
  int? lotType;

  LotItemsScanCompParam({this.header,this.lotType,this.lotName,});
}

enum LotItemsScanCompParamKeys with AbsParamKey {
  header("h"),
  lotName("ln"),
  lotType("lt");


  @override
  final String value;

  const LotItemsScanCompParamKeys(this.value);
}
