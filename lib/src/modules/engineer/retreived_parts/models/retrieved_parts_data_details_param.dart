import 'package:csh_annotation/annotation.dart';

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

  RetrievedDataDetailsParamModel({
    this.dataModel,
    this.deviceBarcode,
    this.isProgressCase = true,
    this.orderDataList,
  });
}

enum RetrievedDataDetailsParamModelKeys with AbsParamKey {
  orderPartDataList("opdl"),
  inProgressCase("ipc"),
  deviceBarcode("dbr"),
  dataModel("dm");

  @override
  final String value;

  const RetrievedDataDetailsParamModelKeys(this.value);
}
