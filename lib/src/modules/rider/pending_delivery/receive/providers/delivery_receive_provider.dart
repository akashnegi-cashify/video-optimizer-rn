import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/models/receive_response_model.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/rider/urgent_request.dart';

import '../resources/domain/delivery_receive_interactor.dart';
import '../resources/domain/delivery_receive_interactor_impl.dart';

class DeliveryReceiveProvider extends CshChangeNotifier
    with Searchable, UrgentRequest {
  late DeliveryReceiveInteractor interactor;

  DeliveryReceiveProvider() {
    interactor = DeliveryReceiveInteractorImpl();
  }

  getDataStream(int pageIndex, int pageSize, bool isUrgentRequests, String? searchQuery) =>
      interactor.getData(pageIndex, pageSize, isUrgentRequests, searchQuery: searchQuery);

  confirmReceive(int partId) => interactor.receivePart(partId);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }

  @override
  set isUrgent(bool value) {
    super.isUrgent = value;
    notifyListeners();
  }
}
