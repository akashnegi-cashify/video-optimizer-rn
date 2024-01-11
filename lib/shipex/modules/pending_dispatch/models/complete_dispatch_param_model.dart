import 'package:csh_annotation/annotation.dart';

@CshPageParam()
class CompleteDispatchParamModel {
  @ParamKey(key: CompleteDispatchParamModelKeys.deliveryPartnerKey)
  String? deliveryPartnerKey;

  CompleteDispatchParamModel({this.deliveryPartnerKey});
}

enum CompleteDispatchParamModelKeys with AbsParamKey {
  deliveryPartnerKey("deliveryPartnerKey");

  @override
  final String value;

  const CompleteDispatchParamModelKeys(this.value);
}
