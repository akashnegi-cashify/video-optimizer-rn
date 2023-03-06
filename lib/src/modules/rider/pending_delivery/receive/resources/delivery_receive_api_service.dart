import 'dart:convert';

import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/part_receive_response.dart';

import '../../../../../services/trc_service.dart';
import '../models/receive_request_model.dart';
import '../models/receive_response_model.dart';

class DeliveryReceiveAPIService {
  static Stream<Response?> getData(Request request) {
    return TrcService().post("/rider/delivery/pickup/pending", Response.fromJson, body: jsonEncode(request.toJson()));
  }

  static Stream<PartReceiveResponse?> receivePart(int receivedPartId) {
    Map<String, List<String>> paramData = {
      "prid": [receivedPartId.toString()]
    };
    return TrcService().put("/rider/delivery/receive-part", PartReceiveResponse.fromJson, params: paramData);
  }
}
