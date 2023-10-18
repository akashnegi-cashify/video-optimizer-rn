import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class ReasonSelectionCompParam {
  @ParamKey(key: ReasonSelectionCompParamKeys.header)
  String? header;

  @ParamKey(key: ReasonSelectionCompParamKeys.code)
  String? code;

  @ParamKey(key: ReasonSelectionCompParamKeys.reasonList)
  List<String>? reasonList;

  @ParamKey(key: ReasonSelectionCompParamKeys.roleType)
  int? roleType;

  @ParamKey(key: ReasonSelectionCompParamKeys.markId)
  int? markId;

  ReasonSelectionCompParam({
    this.header,
    this.reasonList,
    this.code,
    this.roleType,
    this.markId,
  });
}

enum ReasonSelectionCompParamKeys with AbsParamKey {
  header("h"),
  code("code"),
  roleType("rt"),
  markId("mi"),
  reasonList("rl");

  @override
  final String value;

  const ReasonSelectionCompParamKeys(this.value);
}
