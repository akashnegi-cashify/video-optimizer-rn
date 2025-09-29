import 'package:csh_annotation/annotation.dart';

import '../screens/alternate_part_screen.dart';

@CshPageParam()
class AlternatePartCompParam {
  @ParamKey(key: AlternatePartCompParamKeys.arguments)
  AlternatePartArguments? arguments;

  AlternatePartCompParam({
    this.arguments,
  });
}

enum AlternatePartCompParamKeys with AbsParamKey {
  arguments("arg");

  @override
  final String value;

  const AlternatePartCompParamKeys(this.value);
}
