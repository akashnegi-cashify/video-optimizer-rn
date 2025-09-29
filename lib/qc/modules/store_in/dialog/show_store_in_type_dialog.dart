import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_location_scan_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../l10n.dart';

void showStoreInTypeDialog(BuildContext context, {required Function(String qrCode, bool isBinStoreIn) onScanned}) {
  var l10n = L10n(context, listen: false);
  showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: CshTextNew.h3(l10n.selectStorageType),
          contentPadding: const EdgeInsets.all(Dimens.space_12),
          actions: <Widget>[
            CshMediumButton(
              text: l10n.binStorage,
              onPressed: () {
                _onPressed(context, true, l10n, onScanned);
              },
            ),
            CshMediumButton(
              text: l10n.storeIn,
              onPressed: () {
                _onPressed(context, false, l10n, onScanned);
              },
            ),
          ],
        );
      });
}

void _onPressed(BuildContext context, bool isBinStoreIn, L10n l10n, Function(String qrCode, bool isBinStoreIn) onScanned) {
  var message = isBinStoreIn ? l10n.scanBinLocationQrCode : l10n.scanLocationQrCode;
  Navigator.pop(context); // Close dialog
  CshMlScannerUtil().openScanner(
    context,
    header: message,
    hintText: message,
    scanFormatList: [BarcodeFormat.qrCode],
    onScanned: (scannedData, controller) {
      Navigator.pop(context); // Close scanner screen
      onScanned(scannedData, isBinStoreIn);
    },
  );
}
