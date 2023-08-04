import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/screens/barcode_scanner_screen.dart';
import '../l10n.dart';

showPackagingVideoSelectionDialog(
  BuildContext context, {
  required VoidCallback onMonitoringAppSelected,
  required Function(String scannedCameraBarcode) onCCTVCameraSelected,
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
                Navigator.pop(context); //dismiss dialog
                onMonitoringAppSelected();
              },
            ),
          ),
          const SizedBox(height: Dimens.space_12),
          SizedBox(
            width: double.infinity,
            child: CshBigButton(
              text: l10n.cctv,
              onPressed: () {
                Navigator.pop(context); // dismiss dialog
                Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                  Navigator.of(context).pop(); // pop camera scanner screen
                  onCCTVCameraSelected(data);
                });
              },
            ),
          )
        ],
      ),
    ),
  );
}
