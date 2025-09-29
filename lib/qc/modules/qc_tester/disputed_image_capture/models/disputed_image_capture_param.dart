import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class DisputedImageCaptureScreenParam {
  @ParamKey(key: DisputedImageCaptureScreenParamKeys.barcode)
  String? barcode;

  DisputedImageCaptureScreenParam({this.barcode});
}

enum DisputedImageCaptureScreenParamKeys with AbsParamKey {
  barcode("bc");

  @override
  final String value;

  const DisputedImageCaptureScreenParamKeys(this.value);
}
