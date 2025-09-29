import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/src/modules/part_qc/models/qc_parts_list_response.dart';

@CshPageParam()
class PqStatusChangeCompParam {
  @ParamKey(key: PqStatusChangeCompParamKeys.partDetails)
  QcPartListData? partDetails;

  PqStatusChangeCompParam({
    this.partDetails,
  });
}

enum PqStatusChangeCompParamKeys with AbsParamKey {
  partDetails("pd");

  @override
  final String value;

  const PqStatusChangeCompParamKeys(this.value);
}
