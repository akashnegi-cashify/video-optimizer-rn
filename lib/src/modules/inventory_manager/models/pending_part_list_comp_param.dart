import 'package:csh_annotation/annotation.dart';

import '../screens/pending_part_list_screen.dart';

@CshPageParam()
class PendingPartListCompParam {
  @ParamKey(key: PendingPartListCompParamKeys.arguments)
  PendingPartListScreenArguments? arguments;

  PendingPartListCompParam({
    this.arguments,
  });
}

enum PendingPartListCompParamKeys with AbsParamKey {
  arguments("arg");

  @override
  final String value;

  const PendingPartListCompParamKeys(this.value);
}
