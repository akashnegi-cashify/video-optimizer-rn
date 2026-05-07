import 'dart:convert';

import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/modules/dismantle/resources/part_types_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class DismantleService {
  static Stream<PartTypesResponse?> getPartTypes() {
    return TrcService().get(
      "/laptop/dismantling/part-types",
      PartTypesResponse.fromJson,
    );
  }

  static Stream<BaseActionResponse?> markDone(
    String deviceBarcode,
    List<Map<String, String>> parts,
  ) {
    Map<String, dynamic> body = {
      "deviceBarcode": deviceBarcode,
      "parts": parts,
    };
    return TrcService().post(
      "/laptop/dismantling/device/mark-done",
      BaseActionResponse.fromJson,
      body: jsonEncode(body),
    );
  }
}
