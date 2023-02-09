import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/rider/urgent_request.dart';

import '../../../../../common/searchable.dart';
import '../models/delivery_response.dart';
import '../resources/domain/delivery_deliver_interactor.dart';
import '../resources/domain/delivery_deliver_interactor_impl.dart';

class DeliveryDeliverProvider extends CshChangeNotifier
    with Searchable, UrgentRequest {
  final DeliveryDeliverInteractor interactor = DeliveryDeliverInteractorImpl();

  Function(dynamic error) errorHandler;
  DeliveryResponse? _response;
  List<EngineerDetail>? displayList;

  DeliveryDeliverProvider(this.errorHandler) {
    getData();
    displayList = _response?.data;
  }

  getData() {
    _response = null;
    interactor.getEngineersList(isUrgent).listen((event) {
      _response = event;
      displayList = _response?.data;
    }, onDone: () {
      notifyListeners();
    }, onError: (error) {
      errorHandler(error);
    });
  }

  @override
  set isUrgent(bool value) {
    super.isUrgent = value;
    getData();
  }

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    applySearch();
  }

  applySearch() {
    displayList = _response?.data
        ?.where((element) =>
            element.name
                ?.toLowerCase()
                .contains(searchQuery?.toLowerCase() ?? "") ??
            false)
        .toList();
    notifyListeners();
  }
}
