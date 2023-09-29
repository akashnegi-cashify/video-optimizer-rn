import 'package:csh_annotation/annotation.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_perform_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/models/external_audit_enum.dart';

import 'validate_awb_response.dart';

@CshPageParam()
class MediaFileUploadCompParam {
  @ParamKey(key: MediaFileUploadCompParamKeys.selectedOptionItems)
  Map<String,Items>?  selectedOptionItems;

  MediaFileUploadCompParam({this.selectedOptionItems});
}

enum MediaFileUploadCompParamKeys with AbsParamKey {
  selectedOptionItems("selectedOptionItems");

  @override
  final String value;

  const MediaFileUploadCompParamKeys(this.value);
}
