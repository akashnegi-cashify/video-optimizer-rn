import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class CalculatorMediaCaptureParam {
  @ParamKey(key: CalculatorMediaCaptureParamKeys.isComingFromCalJourney)
  bool? isComingFromCalJourney;

  @ParamKey(key: CalculatorMediaCaptureParamKeys.deviceBarcode)
  String? deviceBarcode;

  @ParamKey(key: CalculatorMediaCaptureParamKeys.categoryId)
  int? categoryId;

  CalculatorMediaCaptureParam({
    this.isComingFromCalJourney,
    this.deviceBarcode,
    this.categoryId,
  });
}

enum CalculatorMediaCaptureParamKeys with AbsParamKey {
  isComingFromCalJourney("icfcj"),
  deviceBarcode("dbr"),
  categoryId("cid");

  @override
  final String value;

  const CalculatorMediaCaptureParamKeys(this.value);
}
