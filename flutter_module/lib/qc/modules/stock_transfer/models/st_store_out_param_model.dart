import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class StStoreOutParamModel {
  @ParamKey(key: StStoreOutParamModelKeys.lotId)
  int? lotId;

  StStoreOutParamModel({this.lotId});
}

enum StStoreOutParamModelKeys with AbsParamKey {
  lotId('lotId');

  @override
  final String value;

  const StStoreOutParamModelKeys(this.value);
}
