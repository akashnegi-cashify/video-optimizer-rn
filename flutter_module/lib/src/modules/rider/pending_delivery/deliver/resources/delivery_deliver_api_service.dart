import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';

import '../../../../../services/trc_service.dart';
import '../models/engineer_parts_response.dart';

class DeliveryDeliverAPIService {
  static Stream<DeliveryResponse?> getData(bool isUrgent) {
    Map<String, List<String>> paramData = {
      "isUrgent": [isUrgent.toString()]
    };
    return TrcService()
        .get("/rider/delivery/pending/received/engineer-list", DeliveryResponse.fromJson, params: paramData);
  }

  static Stream<EngineerPartsResponse?> getEngineerParts(int engineerId) {
    Map<String, List<String>> paramData = {
      "eId": [engineerId.toString()]
    };
    return TrcService()
        .get("/rider/delivery/pending/received/parts", EngineerPartsResponse.fromJson, params: paramData);
  }
}
