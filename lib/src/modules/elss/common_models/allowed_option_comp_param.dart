import 'package:csh_annotation/annotation.dart';

import '../elss_qc/screens/allowed_option_screen.dart';

@CshPageParam()
class AllowedOptionCompParam {
  @ParamKey(key: AllowedOptionCompParamKeys.arguments)
  AllowedOptionScreeArguments? arguments;

  AllowedOptionCompParam({
    this.arguments,
  });
}

enum AllowedOptionCompParamKeys with AbsParamKey {
  arguments("args");

  @override
  final String value;

  const AllowedOptionCompParamKeys(this.value);
}
