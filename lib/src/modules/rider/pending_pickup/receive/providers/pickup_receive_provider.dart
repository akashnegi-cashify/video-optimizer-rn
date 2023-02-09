import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/resources/pickup_receive_api_service.dart';

import '../../../pending_delivery/deliver/models/delivery_response.dart';
import '../../../../../common/searchable.dart';

class PickupReceiveProvider extends CshChangeNotifier with Searchable {
  DeliveryResponse? _response;

  List<EngineerDetail>? displayList;

  final Function(String error) errorHandler;

  PickupReceiveProvider(this.errorHandler) {
    getData();
    displayList = _response?.data;
  }

  getData() {
    _response = null;
    PickupReceiveAPIService.getData().listen((event) {
      _response = event;
      displayList = _response?.data;
    }, onDone: () {
      notifyListeners();
    }, onError: (e, s) {
      errorHandler(e);
    });
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
