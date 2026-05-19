import 'package:csh_annotation/annotation.dart';

import '../screens/assign_part_barcode_scanner.dart';

@CshPageParam()
class AssignPartBarcodeScannerParam {
  @ParamKey(key: AssignPartBarcodeScannerParamKeys.arguments)
  AssignBarcodeScannerArguments? arguments;

  AssignPartBarcodeScannerParam({
    this.arguments,
  });
}

enum AssignPartBarcodeScannerParamKeys with AbsParamKey {
  arguments("arg");

  @override
  final String value;

  const AssignPartBarcodeScannerParamKeys(this.value);
}
