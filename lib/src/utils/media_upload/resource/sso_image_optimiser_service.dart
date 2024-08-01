import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/utils/media_upload/resource/image_optimiser_service.dart';

class SSOImageOptimizerService extends ImageOptimizerService {
  @override
  Map<String, String> getHeaders(bool? isToAddAuth) {
    return {
      ...(isToAddAuth ?? isToAddUserAuth()) ? CoreHeaders.xSSOToken : {},
    };
  }
}
