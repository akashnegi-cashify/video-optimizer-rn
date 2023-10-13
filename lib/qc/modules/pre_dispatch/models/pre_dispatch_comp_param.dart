import 'package:csh_annotation/annotation.dart';
import 'package:flutter/foundation.dart';

@CshPageParam()
class PreDispatchCompParam {
  @ParamKey(key: PreDispatchCompParamKeys.lotGroupName)
  String? lotGroupName;

  @ParamKey(key: PreDispatchCompParamKeys.allScanDoneCallback)
  VoidCallback? allScanDoneCallback;

  PreDispatchCompParam({
    this.lotGroupName,
    this.allScanDoneCallback,
  });
}

enum PreDispatchCompParamKeys with AbsParamKey {
  lotGroupName("lgn"),
  allScanDoneCallback("allScanDoneCallback");

  @override
  final String value;

  const PreDispatchCompParamKeys(this.value);
}
