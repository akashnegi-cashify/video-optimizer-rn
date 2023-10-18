import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class AddAgentCompParam {
  @ParamKey(key: AddAgentCompParamKeys.agentList)
  List<String>? agentList;

  @ParamKey(key: AddAgentCompParamKeys.header)
  String? header;

  AddAgentCompParam({
    this.agentList,
    this.header,
  });
}

enum AddAgentCompParamKeys with AbsParamKey {
  header('h'),
  agentList("al");

  @override
  final String value;

  const AddAgentCompParamKeys(this.value);
}
