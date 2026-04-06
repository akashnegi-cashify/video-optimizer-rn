import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class PixelTestingParamModel {
  @ParamKey(key: PixelTestingParamKeys.deviceQrCode)
  String? deviceQrCode;

  PixelTestingParamModel({
    this.deviceQrCode,
  });
}

enum PixelTestingParamKeys with AbsParamKey {
  deviceQrCode("dqc");

  @override
  final String value;

  const PixelTestingParamKeys(this.value);
}
