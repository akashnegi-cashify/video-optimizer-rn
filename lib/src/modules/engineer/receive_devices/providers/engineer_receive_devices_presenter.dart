import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

import '../widget/receive_devices_button_widget.dart';

class EngineerReceiveDevicePresenter {
  final ViewActions view;

  EngineerReceiveDevicePresenter(this.view);

  void Function(String barcode, {BarcodeScannerController? controller}) barcodeResult() =>
      (String barcode, {BarcodeScannerController? controller}) {
        receiveDevice(barcode, controller);
      };

  void receiveDevice(String barcode, BarcodeScannerController? controller) {
    view.handleLoading(true);
    EngineerAPIService.receiveDevice(barcode).listen((receiveDevicesResponse) {
      view.handleLoading(false);
      if (receiveDevicesResponse == null) {
        view.displayErrorBottomSheet(() {
          view.resumeScanner(controller);
        });
        return;
      }
      if (receiveDevicesResponse.errorMsg != null) {
        view.displayErrorBottomSheet(() {
          view.resumeScanner(controller);
        }, message: receiveDevicesResponse.errorMsg!);
        return;
      }
      if (receiveDevicesResponse.deviceInfo != null) {
        view.displayDataInBottomSheet(receiveDevicesResponse, () {
          view.resumeScanner(controller);
        });
      }
    }).onError((e) {
      view.handleLoading(false);
      view.displayErrorBottomSheet(() {
        view.resumeScanner(controller);
      }, message: ApiErrorHelper.getErrorMessage(e));
    });
  }
}
