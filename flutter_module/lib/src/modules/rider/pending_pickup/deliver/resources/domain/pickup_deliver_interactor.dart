import '../../../../pending_delivery/receive/models/receive_response_model.dart';

abstract class PickupDeliverInteractor {
  Stream<Response?> getData(int pageIndex, int pageSize, {String? searchQuery});
}
