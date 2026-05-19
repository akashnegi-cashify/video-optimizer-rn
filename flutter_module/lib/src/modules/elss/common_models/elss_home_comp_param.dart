import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class ElssHomeCompParam {
  @ParamKey(key: ElssHomeCompParamKeys.isLogicFromQC, defaultValue: false)
  bool? isLogicFromQC;

  ElssHomeCompParam({
    this.isLogicFromQC,
  });
}

enum ElssHomeCompParamKeys with AbsParamKey {
  isLogicFromQC("ql");

  @override
  final String value;

  const ElssHomeCompParamKeys(this.value);
}
