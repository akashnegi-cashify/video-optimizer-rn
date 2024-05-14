import 'dart:ui';

import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

@CshPageParam()
class RetrievedDataDetailsParamModel {
  @ParamKey(key: RetrievedDataDetailsParamModelKeys.partBarcode)
  String? partBarcode;

  @ParamKey(key: RetrievedDataDetailsParamModelKeys.partInfo)
  EngineerPartInfo? partInfo;

  @ParamKey(key: RetrievedDataDetailsParamModelKeys.partId)
  int? partId;

  @ParamKey(key: RetrievedDataDetailsParamModelKeys.onSuccess)
  VoidCallback? onSuccess;

  RetrievedDataDetailsParamModel({
    this.partBarcode,
    this.partId,
    this.partInfo,
    this.onSuccess,
  });
}

enum RetrievedDataDetailsParamModelKeys with AbsParamKey {
  partBarcode("br"),
  partInfo("pInfo"),
  onSuccess("onSuccess"),
  partId("pid");

  @override
  final String value;

  const RetrievedDataDetailsParamModelKeys(this.value);
}
