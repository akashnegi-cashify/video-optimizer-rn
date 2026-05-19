import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class PendingDispatchDetailParamModel {
  @ParamKey(key: PendingDispatchDetailParamModelKeys.lotName)
  String? lotName;

  @ParamKey(key: PendingDispatchDetailParamModelKeys.invoiceNo)
  String? scannedInvoiceNo;

  PendingDispatchDetailParamModel({this.lotName, this.scannedInvoiceNo});
}

enum PendingDispatchDetailParamModelKeys with AbsParamKey {
  invoiceNo('invoiceNo'),
  lotName('lotName');

  @override
  final String value;

  const PendingDispatchDetailParamModelKeys(this.value);
}
