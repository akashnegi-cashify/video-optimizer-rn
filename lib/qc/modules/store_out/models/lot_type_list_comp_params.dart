import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class LotTypeListCompParams {
  @ParamKey(key: LotTypeListCompParamKeys.header)
  String? header;

  @ParamKey(key: LotTypeListCompParamKeys.lotType)
  List<int>? lotType;

  LotTypeListCompParams({this.header, this.lotType});
}

enum LotTypeListCompParamKeys with AbsParamKey {
  header("h"),
  lotType("lt");

  @override
  final String value;

  const LotTypeListCompParamKeys(this.value);
}
