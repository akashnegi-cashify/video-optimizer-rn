import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_location_scan_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:ml_barcode_scanner/resources/scan_formats.dart';

import '../l10n.dart';

void showStoreInTypeDialog(BuildContext context) {
  var theme = Theme.of(context);
  var l10n = L10n(context, listen: false);
  showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: CshTextNew.h3(l10n.storeIn),
          contentPadding: const EdgeInsets.all(Dimens.space_12),
          actions: <Widget>[
            TextButton(
              child: CshTextNew(
                l10n.binStoreIn,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                _onPressed(context, true);
              },
            ),
            TextButton(
              child: CshTextNew(
                l10n.storeIn,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                _onPressed(context, false);
              },
            ),
          ],
        );
      });
}

void _onPressed(BuildContext context, bool isBinStoreIn) {
  Navigator.pop(context);
  CshMlScannerUtil().openScanner(
    context,
    header: "Scan location Qr Code",
    hintText: "Scan location Qr Code",
    scanFormatList: [ScanFormats.qrCode],
    onScanned: (scannedData, controller) {
      Navigator.pop(context);
      StoreInLocationScanScreen.navigateTo(context, barcode: scannedData, isBinStoreIn: isBinStoreIn);
    },
  );
}
