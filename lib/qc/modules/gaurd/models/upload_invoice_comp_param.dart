import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class UploadInvoiceCompParam {
  @ParamKey(key: UploadInvoiceCompParamKeys.selectedAgent)
  String? selectedAgent;

  @ParamKey(key: UploadInvoiceCompParamKeys.deviceCount)
  int? deviceCount;

  UploadInvoiceCompParam({
    this.selectedAgent,
    this.deviceCount,
  });
}

enum UploadInvoiceCompParamKeys with AbsParamKey {
  deviceCount('deviceCount'),
  selectedAgent("selectedAgent");

  @override
  final String value;

  const UploadInvoiceCompParamKeys(this.value);
}
