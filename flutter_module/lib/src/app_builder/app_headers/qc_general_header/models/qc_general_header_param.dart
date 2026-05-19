import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class QcGeneralHeaderParam {
  @ParamKey(key: QcGeneralHeaderParamKeys.header)
  String? header;

  QcGeneralHeaderParam({
    this.header,
  });
}

enum QcGeneralHeaderParamKeys with AbsParamKey {
  header("h");

  @override
  final String value;

  const QcGeneralHeaderParamKeys(this.value);
}
