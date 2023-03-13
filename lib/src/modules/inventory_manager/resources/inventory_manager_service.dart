import 'package:flutter_trc/src/services/trc_service.dart';

import '../models/inventory_location_response.dart';

class InventoryService {
  static Stream<InventoryLocationResponse?> getInvetoryLocation() {
    return TrcService().get("/location/group_list", InventoryLocationResponse.fromJson);
  }
}
