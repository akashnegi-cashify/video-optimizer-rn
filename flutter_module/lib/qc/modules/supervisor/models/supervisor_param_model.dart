import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class SupervisorParamModel {
  @ParamKey(key: SupervisorParamModelKeys.deviceBarcode)
  String? deviceBarcode;

  SupervisorParamModel({this.deviceBarcode});
}

enum SupervisorParamModelKeys with AbsParamKey {
  deviceBarcode("db");

  @override
  final String value;

  const SupervisorParamModelKeys(this.value);
}
