import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_qrcode_response.dart';

@CshPageParam()
class ImeiValidatorScreenArgModel {
  @ParamKey(key: ImeiValidatorScreenArgModelKeys.qrcodeResponse)
  ImeiQrcodeResponse? imeiQrcodeResponse;

  ImeiValidatorScreenArgModel({this.imeiQrcodeResponse});
}

enum ImeiValidatorScreenArgModelKeys with AbsParamKey {
  qrcodeResponse('iqr');

  @override
  final String value;

  const ImeiValidatorScreenArgModelKeys(this.value);
}
