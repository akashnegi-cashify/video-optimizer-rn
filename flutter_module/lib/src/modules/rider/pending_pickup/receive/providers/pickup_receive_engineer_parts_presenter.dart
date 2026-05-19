import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/part_receive_response.dart';

import '../resources/pickup_receive_api_service.dart';

class PickupReceiveEngineerPartsPresenter {
  Stream<PartReceiveResponse?> receivePart(int partId, String barcode) =>
      PickupReceiveAPIService.receivePart(partId, barcode);
}
