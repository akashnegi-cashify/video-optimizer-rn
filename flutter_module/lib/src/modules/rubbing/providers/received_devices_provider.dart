import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../resources/domain/received_devices_interactor_Impl.dart';

class ReceivedDevicesProvider extends CshChangeNotifier with Searchable {
  late ReceivedDevicesInteractor interactor;
  late final RubbingModuleRoleType roleType;
  List<GlassChangeFailReasonItem>? _failReasonList;

  ReceivedDevicesProvider({String? query}) {
    roleType = UserDetails().getRubbingRoleType();
    interactor = ReceivedDevicesInteractorImpl();
    super.searchQuery = query;
    if (roleType != RubbingModuleRoleType.rubbing) {
      _getFailReasonList();
    }
  }

  List<GlassChangeFailReasonItem>? get glassChangeFailReasonList => _failReasonList;

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceViaScanning(String barcode) =>
      interactor.receiveDeviceForRubbing(barcode, roleType: roleType);

  void _getFailReasonList() {
    interactor.getFailReasonList(roleType).listen((event) {
      _failReasonList = event?.reasonList;
    }, onError: (error) {
      Logger.debug('mydebug-----ReceivedDevicesProvider._getFailReasonList', []);
    });
  }

  Future<RubbingDoneResponse?> markRubbing(String barcode, bool isDone, String? partBarcode, String? selectedReason) {
    var completer = Completer<RubbingDoneResponse?>();

    if (roleType != RubbingModuleRoleType.rubbing && Validator.isTrue(isDone) && !Validator.isNullOrEmpty(partBarcode)) {
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
      roleType: roleType,
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
      interactor.attachBarcode(barcode, partBarcode, roleType);

  @override
  set searchQuery(String? value) {
    super.searchQuery = value;
    notifyListeners();
  }
}
