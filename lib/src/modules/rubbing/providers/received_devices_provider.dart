import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../resources/domain/received_devices_interactor_Impl.dart';

class ReceivedDevicesProvider extends CshChangeNotifier with Searchable {
  late ReceivedDevicesInteractor interactor;
  late final bool isGlassChangeRole;

  ReceivedDevicesProvider({String? query}) {
    isGlassChangeRole = UserDetails().isGlassChangeRole();
    interactor = ReceivedDevicesInteractorImpl();
    super.searchQuery = query;
  }

  Stream<RubbingDevicesResponse?> getDataStream(
    int pageIndex,
    int pageSize,
    String? searchQuery,
  ) =>
      interactor.getData(pageIndex, pageSize, searchQuery, isGlassChange: isGlassChangeRole);

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceViaScanning(String barcode) =>
      interactor.receiveDeviceForRubbing(barcode, isGlassChange: isGlassChangeRole);

  Future<RubbingDoneResponse?> markRubbing(String barcode, bool isDone, String? partBarcode) {
    var completer = Completer<RubbingDoneResponse?>();

    if (Validator.isTrue(isGlassChangeRole) && Validator.isTrue(isDone)) {
      _attachBarcode(barcode, partBarcode).listen((event) {
        interactor.markRubbing(barcode, isDone, isGlassChangeRole: isGlassChangeRole, partBarcode: partBarcode).listen(
            (event) {
          completer.complete(event);
        }, onError: (error) {
          completer.completeError(error);
        });
      }, onError: (error) {
        completer.completeError(error);
      });
    } else {
      interactor.markRubbing(barcode, isDone, isGlassChangeRole: isGlassChangeRole, partBarcode: partBarcode).listen(
          (event) {
        completer.complete(event);
      }, onError: (error) {
        completer.completeError(error);
      });
    }

    return completer.future;
  }

  Stream<RubbingDoneResponse?> _attachBarcode(String barcode, String? partBarcode) =>
      interactor.attachBarcode(barcode, partBarcode);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }
}
