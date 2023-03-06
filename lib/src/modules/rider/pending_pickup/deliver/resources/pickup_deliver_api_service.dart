import 'dart:convert';

import '../../../../../services/trc_service.dart';
import '../../../pending_delivery/receive/models/receive_request_model.dart';
import '../../../pending_delivery/receive/models/receive_response_model.dart';

class PickupDeliverAPIService {
  static Stream<Response?> getData(Request request) {
    return TrcService().post("/rider/return/picked", Response.fromJson, body: jsonEncode(request.toJson()));
  }
}
