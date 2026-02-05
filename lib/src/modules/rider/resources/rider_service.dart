import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class RiderService {
  static Stream<BaseResponse?> receiveDevice(String partBarcode) {
    Map<String, List<String>> paramData = {
      "prid": [partBarcode.toString()]
    };
    // TODO: need to change api
    return TrcService().put("/rider/delivery/receive-part", BaseResponse.fromJson, params: paramData);
  }
}
