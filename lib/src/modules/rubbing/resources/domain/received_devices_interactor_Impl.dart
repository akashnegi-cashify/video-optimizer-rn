import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_request.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_api_service.dart';

import '../../model/search_query.dart';

class ReceivedDevicesInteractorImpl implements ReceivedDevicesInteractor {
  @override
  Stream<RubbingDevicesResponse?> getData(int pageIndex, int pageSize, String? searchQuery) {
    RubbingDeviceListRequest request = RubbingDeviceListRequest();
    if (searchQuery != null) {
      request.searchQuery = SearchQuery()..br = searchQuery;
    }
    request.pageNo = pageIndex;
    request.pageSize = pageSize;
    return RubbingAPIService.getData(request);
  }

  @override
  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool rubbing) {
    return RubbingAPIService.markRubbing(barcode, rubbing);
  }

  @override
  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode) {
    return RubbingAPIService.scanDevice(barcode);
  }
}
