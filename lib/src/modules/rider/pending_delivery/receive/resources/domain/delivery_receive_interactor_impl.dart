import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/part_receive_response.dart';

import '../../models/receive_request_model.dart';
import '../../models/receive_response_model.dart';
import '../delivery_receive_api_service.dart';
import 'delivery_receive_interactor.dart';

class DeliveryReceiveInteractorImpl implements DeliveryReceiveInteractor {
  static final DeliveryReceiveInteractorImpl _instance =
      DeliveryReceiveInteractorImpl._internal();

  factory DeliveryReceiveInteractorImpl() => _instance;

  DeliveryReceiveInteractorImpl._internal();

  @override
  Stream<Response?> getData(int pageIndex, int pageSize, bool isUrgentRequests,
      {String? searchQuery}) {
    Request request = Request();
    request.fp = FacilityPart()..isUrgent = isUrgentRequests;
    request.pageNo = pageIndex;
    request.listNo = pageSize;
    request.barcode = searchQuery;
    return DeliveryReceiveAPIService.getData(request);
  }

  @override
  Stream<PartReceiveResponse?> receivePart(int partId) =>
      DeliveryReceiveAPIService.receivePart(partId);
}
