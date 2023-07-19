import 'package:csh_annotation/annotation.dart';

import '../screens/pending_part_details_screen.dart';

@CshPageParam()
class PendingPartDetailsCompParam {
  @ParamKey(key: PendingPartDetailsCompParamKeys.arguments)
  PendingPartDetailsScreenArguments? arguments;

  PendingPartDetailsCompParam({this.arguments});
}

enum PendingPartDetailsCompParamKeys with AbsParamKey {
  arguments("arg");

  @override
  final String value;

  const PendingPartDetailsCompParamKeys(this.value);
}
