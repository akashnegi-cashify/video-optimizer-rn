import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/modules/laptop_analyzer/resources/analyzer_status_type.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class LaptopAnalyzerService {
  static Stream<BaseActionResponse?> updateStatus(int deviceId, AnalyzerStatusType statusType) {
    Map<String, List<String>> params = {
      "did": [deviceId.toString()],
      "st": [statusType.value.toString()],
    };
    return TrcService().post(
      "/device/update-status",
      BaseActionResponse.fromJson,
      params: params,
    );
  }
}
