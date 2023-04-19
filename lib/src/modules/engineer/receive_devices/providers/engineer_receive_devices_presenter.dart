import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

import '../widget/receive_devices_button_widget.dart';

class EngineerReceiveDevicePresenter {
  final ViewActions view;

  EngineerReceiveDevicePresenter(this.view);

  void Function(String barcode, {MlScannerController? controller}) barcodeResult() =>
      (String barcode, {MlScannerController? controller}) {
        receiveDevice(barcode, controller);
      };

  void receiveDevice(String barcode, MlScannerController? controller) {
    view.handleLoading(true);
    EngineerAPIService.receiveDevice(barcode).listen((receiveDevicesResponse) {
      if (controller != null) {
        controller.stop();
      }
      view.handleLoading(false);
      if (receiveDevicesResponse == null) {
        view.displayErrorBottomSheet(() {});
        return;
      }
      if (receiveDevicesResponse.errorMsg != null) {
        view.displayErrorBottomSheet(() {}, message: receiveDevicesResponse.errorMsg!);
        return;
      }
      if (receiveDevicesResponse.deviceInfo != null) {
        view.displayDataInBottomSheet(receiveDevicesResponse, () {});
      }
    })
      ..onError((e) {
        if (controller != null) {
          controller.stop();
        }
        view.handleLoading(false);
        view.displayErrorBottomSheet(() {}, message: ApiErrorHelper.getErrorMessage(e));
      })
      ..onDone(() {
        if (controller != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            controller.start();
          });
        }
      });
  }
}
