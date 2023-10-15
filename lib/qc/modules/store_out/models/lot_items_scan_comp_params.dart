import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

@CshPageParam()
class LotItemsScanCompParam {
  @ParamKey(key: LotItemsScanCompParamKeys.header)
  String? header;

  @ParamKey(key: LotItemsScanCompParamKeys.lotName)
  String? lotName;

  @ParamKey(key: LotItemsScanCompParamKeys.lotType)
  int? lotType;

  LotItemsScanCompParam({this.header,this.lotType,this.lotName,});
}

enum LotItemsScanCompParamKeys with AbsParamKey {
  header("h"),
  lotName("ln"),
  lotType("lt");


  @override
  final String value;

  const LotItemsScanCompParamKeys(this.value);
}
