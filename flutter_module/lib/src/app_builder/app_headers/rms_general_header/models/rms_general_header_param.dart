import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class RmsGeneralHeaderParam {
  @ParamKey(key: RmsGeneralHeaderParamKeys.header)
  String? header;

  RmsGeneralHeaderParam({
    this.header,
  });
}

enum RmsGeneralHeaderParamKeys with AbsParamKey {
  header("h");

  @override
  final String value;

  const RmsGeneralHeaderParamKeys(this.value);
}
