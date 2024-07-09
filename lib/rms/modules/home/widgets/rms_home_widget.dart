import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/resources/receive_device_service.dart';
import 'package:flutter_trc/rms/modules/receive_device/widgets/barcode_type_selection_dialog.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

class RmsHomeWidget extends StatelessWidget {
  const RmsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshBigButton(text: "Receive Device", onPressed: () => _onReceiveDeviceButtonClicked(context)),
        ],
      ),
    );
  }

  _onReceiveDeviceButtonClicked(BuildContext context) {
    showBarcodeTypeSelectionDialog(
      context,
      onSelected: (barcodeType) {
        Navigator.pop(context); // Close the dialog
        CshMlScannerUtil().openScanner(
          context,
          onScanned: (scannedData, controller) {
            Navigator.pop(context); // Close the dialog
            ReceiveDeviceService.receiveDevice(scannedData, barcodeType).listen((event) {
              CshSnackBar.success(context: context, message: "Device received successfully");
            }, onError: (error) {
              String? errorMessage = ApiErrorHelper.getErrorMessage(error);
              CshSnackBar.error(context: context, message: errorMessage.toString());
            });
          },
        );
      },
    );
  }
}
