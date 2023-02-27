import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/part_receive_response.dart';

import '../../../../../services/trc_service.dart';
import '../../../pending_delivery/deliver/models/engineer_parts_response.dart';

class PickupReceiveAPIService {
  static Stream<DeliveryResponse?> getData() {
    return TrcService().get("/rider/return/pending/engineer-list", DeliveryResponse.fromJson);
  }

  static Stream<EngineerPartsResponse?> getEngineerParts(int engineerId) {
    Map<String, List<String>> paramData = {
      "eId": [engineerId.toString()]
    };
    return TrcService().get("/rider/return/pending/parts", EngineerPartsResponse.fromJson, params: paramData);
  }

  static Stream<PartReceiveResponse?> receivePart(int partId, String partBarcode) {
    Map<String, List<String>> paramData = {
      "prid": [partId.toString()],
      "pbr": [partBarcode]
    };
    return TrcService().put("/rider/return/receive-part", PartReceiveResponse.fromJson, params: paramData);
  }
}
