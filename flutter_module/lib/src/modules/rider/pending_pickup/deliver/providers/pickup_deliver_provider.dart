import 'package:core_widgets/core_widgets.dart';
import '../../../pending_delivery/receive/models/receive_response_model.dart';
import '../../../../../common/searchable.dart';
import '../resources/domain/pickup_deliver_interactor.dart';
import '../resources/domain/pickup_deliver_interactor_impl.dart';

class PickupDeliverProvider extends CshChangeNotifier with Searchable {
  late PickupDeliverInteractor interactor;

  PickupDeliverProvider() {
    interactor = PickupDeliverInteractorImpl();
  }

  Stream<Response?> getDataStream(int pageIndex, int pageSize, String? searchQuery) =>
      interactor.getData(pageIndex, pageSize, searchQuery: searchQuery);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }
}
