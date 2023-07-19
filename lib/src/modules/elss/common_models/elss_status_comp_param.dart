import 'package:csh_annotation/annotation.dart';

import '../elss_qc/screens/elss_status_screen.dart';

@CshPageParam()
class ElssStatusCompParam {
  @ParamKey(key: ElssStatusCompParamKeys.arguments)
  ElssStatusScreenArg? arguments;

  ElssStatusCompParam({
    this.arguments,
  });
}

enum ElssStatusCompParamKeys with AbsParamKey {
  arguments("args");

  @override
  final String value;

  const ElssStatusCompParamKeys(this.value);
}
