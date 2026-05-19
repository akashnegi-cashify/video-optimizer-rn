import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';

@CshPageParam()
class ReQcDetailParam {
  @ParamKey(key: ReQcDetailParamKeys.reQcListData)
  ReQcListData? reQcListData;

  ReQcDetailParam({this.reQcListData});
}

enum ReQcDetailParamKeys with AbsParamKey {
  reQcListData("reQcListData");

  @override
  final String value;

  const ReQcDetailParamKeys(this.value);
}
