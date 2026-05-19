import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';

showPackagingVideoSelectionDialog(
  BuildContext context, {
  String? cameraBarcode,
  bool isCheckValidation = false,
  required Function(bool? isSelectResetOption) onMonitoringAppSelected,
  required Function(String scannedCameraBarcode, {bool? isSelectResetOption}) onCCTVCameraSelected,
}) {
  var l10n = L10n(context);
  showCshBottomSheet(
    context: context,
    child: Padding(
      padding: const EdgeInsets.all(Dimens.space_20),
      child: Column(
        children: [
          CshTextNew.subTitle2(l10n.selectTheCaptureProcess),
          const SizedBox(height: Dimens.space_20),
          SizedBox(
            width: double.infinity,
            child: CshBigOutlineButton(
              text: l10n.monitoringApp,
              isPrimary: true,
              onPressed: () {
                if (isCheckValidation) {
                  // When user change recording mode
                  if (!Validator.isNullOrEmpty(cameraBarcode)) {
                    _showConfirmationDialogToReset(
                      context,
                      l10n,
                      onPositive: () {
                        Navigator.pop(context); // dismiss dialog
                        onMonitoringAppSelected(true);
                      },
                    );
                    return;
                  }
                }
                Navigator.pop(context); //dismiss dialog
                onMonitoringAppSelected(false);
              },
            ),
          ),
          const SizedBox(height: Dimens.space_12),
          SizedBox(
            width: double.infinity,
            child: CshBigButton(
              text: l10n.cctv,
              onPressed: () {
                if (isCheckValidation) {
                  // When user change recording mode
                  if (Validator.isNullOrEmpty(cameraBarcode)) {
                    _showConfirmationDialogToReset(context, l10n, onPositive: () {
                      Navigator.pop(context); // dismiss dialog
                      CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                        Navigator.of(context).pop(); // pop camera scanner screen
                        onCCTVCameraSelected(scannedData, isSelectResetOption: true);
                      });
                    });
                    return;
                  }
                }
                Navigator.pop(context); // dismiss dialog
                CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                  Navigator.of(context).pop(); // pop camera scanner screen
                  if (isCheckValidation) {
                    // When user scan different camera barcode
                    if (!Validator.isNullOrEmpty(cameraBarcode) && scannedData != cameraBarcode) {
                      _showErrorDialog(context, l10n, cameraBarcode, scannedData);
                      return;
                    }
                  }
                  onCCTVCameraSelected(scannedData);
                });
              },
            ),
          )
        ],
      ),
    ),
  );
}

_showErrorDialog(BuildContext context, L10n l10n, String? cameraBarcode, String scannedBarcode) {
  showAlertDialog(
    context,
    title: l10n.wrongCameraScanned,
    desc: l10n.wrongCameraScannedDesc(cameraBarcode ?? "", scannedBarcode),
    onPosBtnPressed: (_) => Navigator.pop(context), // dismiss popup
  );
}

_showConfirmationDialogToReset(BuildContext context, L10n l10n, {required VoidCallback onPositive}) {
  showPopup(context, title: l10n.recordingModeChanged, desc: l10n.allDeviceNeedTpPackageAgain, actions: [
    CshMediumButton(text: l10n.no, onPressed: () => Navigator.pop(context)),
    CshMediumButton(
      text: l10n.yes,
      onPressed: () {
        Navigator.pop(context); // dismiss popup
        onPositive();
      },
    ),
  ]);
}
