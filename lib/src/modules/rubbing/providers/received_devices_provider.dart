import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../resources/domain/received_devices_interactor_Impl.dart';

class ReceivedDevicesProvider extends CshChangeNotifier with Searchable {
  late ReceivedDevicesInteractor interactor;
  late final bool isGlassChangeRole;
  List<GlassChangeFailReasonItem>? _glassChangeFailReasonList;

  ReceivedDevicesProvider({String? query}) {
    isGlassChangeRole = UserDetails().isGlassChangeRole();
    interactor = ReceivedDevicesInteractorImpl();
    super.searchQuery = query;
    _getGlassChangeFailReasonList();
  }

  List<GlassChangeFailReasonItem>? get glassChangeFailReasonList => _glassChangeFailReasonList;

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceViaScanning(String barcode) =>
      interactor.receiveDeviceForRubbing(barcode, isGlassChange: isGlassChangeRole);

  void _getGlassChangeFailReasonList() {
    interactor.getGlassChangeFailReasonList().listen((event) {
      _glassChangeFailReasonList = event?.reasonList;
    }, onError: (error) {
      Logger.debug('mydebug-----ReceivedDevicesProvider._getGlassChangeFailReasonList', []);
    });
  }

  Future<RubbingDoneResponse?> markRubbing(String barcode, bool isDone, String? partBarcode, String? selectedReason) {
    var completer = Completer<RubbingDoneResponse?>();

    if (Validator.isTrue(isGlassChangeRole) && Validator.isTrue(isDone)) {
      _attachBarcode(barcode, partBarcode).listen((event) {
        _markRubbing(barcode, isDone, partBarcode, completer, selectedReason: selectedReason);
      }, onError: (error) {
        completer.completeError(error);
      });
    } else {
      _markRubbing(barcode, isDone, partBarcode, completer, selectedReason: selectedReason);
    }

    return completer.future;
  }

  _markRubbing(String barcode, bool isDone, String? partBarcode, Completer completer, {String? selectedReason}) {
    interactor
        .markRubbing(
      barcode,
      isDone,
      isGlassChangeRole: isGlassChangeRole,
      partBarcode: partBarcode,
      selectedReason: selectedReason,
    )
        .listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(error);
    });
  }

  Stream<RubbingDoneResponse?> _attachBarcode(String barcode, String? partBarcode) =>
      interactor.attachBarcode(barcode, partBarcode);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }
}
