import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/part_receive_response.dart';

import '../../models/receive_response_model.dart';

abstract class DeliveryReceiveInteractor {
  Stream<Response?> getData(int pageIndex, int pageSize, bool isUrgentRequests, {String? searchQuery});

  Stream<PartReceiveResponse?> receivePart(int partId);
}
