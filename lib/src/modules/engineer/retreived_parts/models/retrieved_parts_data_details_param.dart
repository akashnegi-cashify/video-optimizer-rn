import 'dart:ui';

import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

@CshPageParam()
class RetrievedDataDetailsParamModel {
  @ParamKey(key: RetrievedDataDetailsParamModelKeys.partInfo)
  EngineerPartInfo? partInfo;

  @ParamKey(key: RetrievedDataDetailsParamModelKeys.onSuccess)
  VoidCallback? onSuccess;

  RetrievedDataDetailsParamModel({
    this.partInfo,
    this.onSuccess,
  });
}

enum RetrievedDataDetailsParamModelKeys with AbsParamKey {
  partInfo("pInfo"),
  onSuccess("onSuccess");

  @override
  final String value;

  const RetrievedDataDetailsParamModelKeys(this.value);
}
