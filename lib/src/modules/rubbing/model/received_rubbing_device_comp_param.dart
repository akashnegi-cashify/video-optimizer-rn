import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class ReceivedRubbingDeviceCompParam {
  @ParamKey(key: ReceivedRubbingDeviceCompParamKeys.searchQuery, defaultValue: "")
  String? searchQuery;

  ReceivedRubbingDeviceCompParam({
    this.searchQuery,
  });
}

enum ReceivedRubbingDeviceCompParamKeys with AbsParamKey {
  searchQuery("sq");

  @override
  final String value;

  const ReceivedRubbingDeviceCompParamKeys(this.value);
}
