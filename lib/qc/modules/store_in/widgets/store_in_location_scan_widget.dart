import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';
import 'package:provider/provider.dart';

import '../../qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import '../l10n.dart';
import '../providers/store_in_provider.dart';

class StoreInLocationScanWidget extends StatelessWidget {
  final String? locBarcode;
  final int? availableSpace;
  final int? totalCount;
  final bool isBinStoreIn;

  const StoreInLocationScanWidget({
    super.key,
    required this.isBinStoreIn,
    this.locBarcode,
    this.availableSpace,
    this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => StoreInProvider(
        availableSpace: availableSpace,
        totalCount: totalCount,
        locBarcode: locBarcode,
        isBinStoreIn: isBinStoreIn,
      ),
      child: Builder(builder: (builderContext) {
        var provider = StoreInProvider.of(builderContext);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CshTextNew.h2("${l10n.trayBarcode}$locBarcode"),
                const SizedBox(height: Dimens.space_4),
                CshTextNew.h2("${l10n.totalSpace}${provider.totalCount ?? 0}"),
                const SizedBox(height: Dimens.space_4),
                CshTextNew.h2("${l10n.totalAvailableSpace}${provider.availableSpace ?? 0}"),
                const SizedBox(height: Dimens.space_4),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Row(
                children: [
                  Expanded(child: CshBigButton(text: l10n.goBack, onPressed: () => _goBack(builderContext))),
                  const SizedBox(width: Dimens.space_8),
                  if (provider.availableSpace != 0)
                    Expanded(
                        child: CshBigButton(text: l10n.scanDevice, onPressed: () => _scanDevice(builderContext, l10n))),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _scanDevice(BuildContext context, L10n l10n) {
    _launchScanner(context, l10n);
  }

  void _launchScanner(BuildContext context, L10n l10n) {
    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (String scannedData, MlScannerController? controller) {
      if (scannedData.isNotEmpty) {
        Navigator.pop(context); // pop scanner screen
        _showAlert(context, scannedData, l10n);
      }
    },
        header:l10n.scanDeviceCamelCase,
    );
    Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
  }

  void _showAlert(BuildContext context, String message, L10n l10n) {
    var theme = Theme.of(context);
    var btnText = isBinStoreIn ? l10n.binIn : l10n.storeIn;

    showDialog(
      context: context,
      builder: (builderContext) {
        return AlertDialog(
          title: CshTextNew.h3(isBinStoreIn ? l10n.binIn : l10n.storeIn),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CshTextNew.h3("${l10n.stockBarcode}$message"),
              const SizedBox(height: Dimens.space_4),
              CshTextNew.h3("${l10n.locationBarcode}$locBarcode"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: CshTextNew(
                l10n.scanOther,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                _launchScanner(context, l10n);
              },
            ),
            TextButton(
              child: CshTextNew(
                btnText,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                _storeInDevice(context, message, l10n);
              },
            )
          ],
        );
      },
    );
  }

  void _storeInDevice(BuildContext context, String deviceBarcode, L10n l10n) {
    var provider = StoreInProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.storeInDevice(deviceBarcode).then((value) {
      CshLoading().hideLoading(context);
      CshSnackBar.success(context: context, message: value?.message ?? 'Success');
      if (value != null && value.availableSpace != 0) {
        _launchScanner(context, l10n);
      }
    }, onError: (error, stack) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
