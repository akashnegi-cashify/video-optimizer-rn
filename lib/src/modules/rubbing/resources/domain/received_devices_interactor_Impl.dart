import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_request.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_api_service.dart';

import '../../model/search_query.dart';

class ReceivedDevicesInteractorImpl implements ReceivedDevicesInteractor {
  @override
  Stream<RubbingDevicesResponse?> getData(int pageIndex, int pageSize, String? query, {bool isGlassChange = false}) {
    RubbingDeviceListRequest request = RubbingDeviceListRequest();
    if (query != null) {
      request.searchQuery = SearchQuery()..br = query;
    }
    request.pageNo = pageIndex;
    request.pageSize = pageSize;
    return RubbingAPIService.getReceivedDeviceList(request, isGlassChange);
  }

  @override
  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool rubbing,
      {bool isGlassChangeRole = false, String? partBarcode}) {
    return RubbingAPIService.markRubbing(barcode, rubbing, isGlassChangeRole);
  }

  @override
  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode, {bool isGlassChange = false}) {
    return RubbingAPIService.scanDevice(barcode, isGlassChange);
  }

  @override
  Stream<RubbingDoneResponse?> attachBarcode(String barcode, String? partBarcode) {
    return RubbingAPIService.attachPartBarcode(barcode, partBarcode);
  }
}
