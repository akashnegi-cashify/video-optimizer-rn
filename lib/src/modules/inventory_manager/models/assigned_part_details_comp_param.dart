import 'package:csh_annotation/annotation.dart';

import '../screens/assigned_part_details_screen.dart';

@CshPageParam()
class AssignedPartDetailsCompParam {
  @ParamKey(key: AssignedPartDetailsCompParamKeys.arguments)
  AssignedPartDetailsArguments? arguments;

  AssignedPartDetailsCompParam({this.arguments});
}

enum AssignedPartDetailsCompParamKeys with AbsParamKey {
  arguments('arg');

  @override
  final String value;

  const AssignedPartDetailsCompParamKeys(this.value);
}
