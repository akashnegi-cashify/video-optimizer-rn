import 'package:flutter_trc/shipex/modules/dispatch/models/delivery_partner_list_response.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/resources/delivery_partner_list_type.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/resources/scanned_awb_list_response.dart';
import 'package:flutter_trc/shipex/shipex_service.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';

class PendingDispatchService {
  static Stream<DeliveryPartnerListResponse> getPendingDispatchProviderList(DeliveryPartnerListTye type) {
    return ShipexService().get('/app/delivery/list-with-count/${type.val}', DeliveryPartnerListResponse.fromJson);
  }

  static Stream<ScannedAwbListResponse> getAwbList(String deliveryPartnerKey) {
    return ShipexService().get('/app/delivery/list-scanned-awb/$deliveryPartnerKey', ScannedAwbListResponse.fromJson);
  }

  static Stream<BaseActionResponse> removeAwbNumber(String awbNumber) {
    return ShipexService().delete('/app/delivery/remove-scanned-awb/$awbNumber', BaseActionResponse.fromJson);
  }
}
