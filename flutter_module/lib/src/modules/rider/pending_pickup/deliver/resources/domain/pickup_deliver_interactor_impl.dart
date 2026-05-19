import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/resources/domain/pickup_deliver_interactor.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/resources/pickup_deliver_api_service.dart';

import '../../../../pending_delivery/receive/models/receive_request_model.dart';
import '../../../../pending_delivery/receive/models/receive_response_model.dart';

class PickupDeliverInteractorImpl implements PickupDeliverInteractor {
  @override
  Stream<Response?> getData(int pageIndex, int pageSize, {String? searchQuery}) {
    Request request = Request();
    request.pageNo = pageIndex;
    request.listNo = pageSize;
    request.barcode = searchQuery;
    return PickupDeliverAPIService.getData(request);
  }
}
