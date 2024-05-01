import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class ActionItemParams {
  @ParamKey(key: ActionItemParamKey.barcode)
  String? barcode;

  ActionItemParams({this.barcode});
}

enum ActionItemParamKey with AbsParamKey {
  barcode("bc");

  @override
  final String value;

  const ActionItemParamKey(this.value);
}
