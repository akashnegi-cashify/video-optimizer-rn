import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class BodyShopService {
  static Stream<BaseActionResponse?> markDevice(String barcode, bool isDone, {int? reasonId}) {
    Map<String, List<String>> params = {
      "dbr": [barcode],
      "isDone": [isDone.toString()],
      if (reasonId != null) "rsnId": [reasonId.toString()],
    };
    return TrcService().post(
      "/laptop/body-shop/device/done",
      BaseActionResponse.fromJson,
      params: params,
    );
  }
}
