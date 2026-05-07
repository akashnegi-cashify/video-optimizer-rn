import 'package:flutter_trc/src/common/mark_to_tl/mark_to_tl_reasons_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class MarkToTlService {
  static Stream<MarkToTlReasonsResponse?> getReasons() {
    return TrcService().get(
      "/console/manage/tl/laptop/mark-tl/reasons",
      MarkToTlReasonsResponse.fromJson,
    );
  }
}
