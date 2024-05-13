import 'dart:ui';

import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

import '../../models/retreived_part_required_list_reponse.dart';
import '../../my_devices/wip_devices/view_parts/models/order_engineer_part.dart';

@CshPageParam()
class RetrievedDataDetailsParamModel {
  @ParamKey(key: RetrievedDataDetailsParamModelKeys.dataModel)
  RetrievedPartRequiredResponse? dataModel;
  @ParamKey(key: RetrievedDataDetailsParamModelKeys.deviceBarcode)
  String? deviceBarcode;
  @ParamKey(key: RetrievedDataDetailsParamModelKeys.inProgressCase)
  bool? isProgressCase;
  @ParamKey(key: RetrievedDataDetailsParamModelKeys.orderPartDataList)
  List<OrderEngineerPart>? orderDataList;

  @ParamKey(key: RetrievedDataDetailsParamModelKeys.partInfo)
  EngineerPartInfo? partInfo;

  @ParamKey(key: RetrievedDataDetailsParamModelKeys.onSuccess)
  VoidCallback? onSuccess;

  RetrievedDataDetailsParamModel({
    this.dataModel,
    this.deviceBarcode,
    this.isProgressCase = true,
    this.orderDataList,
    this.partInfo, this.onSuccess,
  });
}

enum RetrievedDataDetailsParamModelKeys with AbsParamKey {
  orderPartDataList("opdl"),
  inProgressCase("ipc"),
  deviceBarcode("dbr"),
  partInfo("pInfo"),
  onSuccess("onSuccess"),
  dataModel("dm");

  @override
  final String value;

  const RetrievedDataDetailsParamModelKeys(this.value);
}
