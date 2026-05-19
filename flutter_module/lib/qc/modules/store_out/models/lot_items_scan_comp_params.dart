import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class LotItemsScanCompParam {
  @ParamKey(key: LotItemsScanCompParamKeys.header)
  String? header;

  @ParamKey(key: LotItemsScanCompParamKeys.lotName)
  String? lotName;

  @ParamKey(key: LotItemsScanCompParamKeys.lotId)
  int? lotId;

  @ParamKey(key: LotItemsScanCompParamKeys.lotType)
  int? lotType;

  LotItemsScanCompParam({this.header,this.lotType,this.lotName,this.lotId,});
}

enum LotItemsScanCompParamKeys with AbsParamKey {
  header("h"),
  lotName("ln"),
  lotId("lid"),
  lotType("lt");


  @override
  final String value;

  const LotItemsScanCompParamKeys(this.value);
}
