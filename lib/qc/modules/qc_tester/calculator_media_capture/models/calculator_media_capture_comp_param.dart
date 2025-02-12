import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class CalculatorMediaCaptureParam {
  @ParamKey(key: CalculatorMediaCaptureParamKeys.isComingFromCalJourney)
  bool? isComingFromCalJourney;

  @ParamKey(key: CalculatorMediaCaptureParamKeys.deviceBarcode)
  String? deviceBarcode;

  CalculatorMediaCaptureParam({
    this.isComingFromCalJourney,
    this.deviceBarcode,
  });
}

enum CalculatorMediaCaptureParamKeys with AbsParamKey {
  isComingFromCalJourney("icfcj"),
  deviceBarcode("dbr");

  @override
  final String value;

  const CalculatorMediaCaptureParamKeys(this.value);
}
