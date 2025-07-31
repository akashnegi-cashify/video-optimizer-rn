import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/resources/journey_type.dart';

@CshPageParam()
class CalculatorMediaCaptureParam {
  @ParamKey(key: CalculatorMediaCaptureParamKeys.journeyType)
  JourneyType? journeyType;

  @ParamKey(key: CalculatorMediaCaptureParamKeys.deviceBarcode)
  String? deviceBarcode;

  @ParamKey(key: CalculatorMediaCaptureParamKeys.categoryId)
  int? categoryId;

  @ParamKey(key: CalculatorMediaCaptureParamKeys.onMediaListUpdated)
  Function(List<MediaSubmitRequest> mediaList)? onMediaListUpdated;

  CalculatorMediaCaptureParam({
    this.journeyType,
    this.deviceBarcode,
    this.categoryId,
    this.onMediaListUpdated,
  });
}

enum CalculatorMediaCaptureParamKeys with AbsParamKey {
  journeyType("icfcj"),
  deviceBarcode("dbr"),
  onMediaListUpdated("omlu"),
  categoryId("cid");

  @override
  final String value;

  const CalculatorMediaCaptureParamKeys(this.value);
}
