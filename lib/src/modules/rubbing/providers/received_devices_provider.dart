import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';

import '../resources/domain/received_devices_interactor_Impl.dart';

class ReceivedDevicesProvider extends CshChangeNotifier with Searchable {
  late ReceivedDevicesInteractor interactor;

  ReceivedDevicesProvider({String? query}) {
    interactor = ReceivedDevicesInteractorImpl();
    super.searchQuery = query;
  }

  Stream<RubbingDevicesResponse?> getDataStream(
    int pageIndex,
    int pageSize,
    String? searchQuery,
  ) =>
      interactor.getData(pageIndex, pageSize, searchQuery);

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceViaScanning(String barcode) =>
      interactor.receiveDeviceForRubbing(barcode);

  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool rubbing) => interactor.markRubbing(barcode, rubbing);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }
}
