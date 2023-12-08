import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../l10n.dart';
import '../providers/store_in_provider.dart';

class StoreInLocationScanWidget extends StatelessWidget {
  const StoreInLocationScanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = StoreInProvider.of(context);
    if (provider.isScreenLoading) {
      return const CshShimmer();
    }

    if (!Validator.isTrue(provider.isScreenLoading) && !Validator.isNullOrEmpty(provider.errorMessage)) {
      return _buildErrorBody(context, provider.errorMessage!, provider);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CshTextNew.h2("${l10n.trayBarcode}${provider.locQrCode}"),
              const SizedBox(height: Dimens.space_4),
              CshTextNew.h2("${l10n.totalSpace}${provider.totalCount ?? 0}"),
              const SizedBox(height: Dimens.space_4),
              CshTextNew.h2("${l10n.totalAvailableSpace}${provider.availableSpace ?? 0}"),
              const SizedBox(height: Dimens.space_4),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Row(
            children: [
              Expanded(child: CshBigButton(text: l10n.goBack, onPressed: () => _goBack(context))),
              if (provider.availableSpace != 0)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimens.space_8),
                    child: CshBigButton(text: l10n.scanDevice, onPressed: () => _scanDevice(context, l10n)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _scanDevice(BuildContext context, L10n l10n) {
    CshMlScannerUtil().openScanner(
      context,
      header: l10n.scanDeviceCamelCase,
      hintText: l10n.scanDeviceCamelCase,
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // pop scanner screen
        _showAlert(context, scannedData, l10n);
      },
    );
  }

  void _showAlert(BuildContext context, String message, L10n l10n) {
    var provider = StoreInProvider.of(context, listen: false);
    var theme = Theme.of(context);
    var btnText = provider.isBinStoreIn ? l10n.binIn : l10n.storeIn;

    showDialog(
      context: context,
      builder: (builderContext) {
        return AlertDialog(
          title: CshTextNew.h3(btnText),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CshTextNew.h3("${l10n.stockBarcode}$message"),
              const SizedBox(height: Dimens.space_4),
              CshTextNew.h3("${l10n.locationBarcode}${provider.locQrCode}"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: CshTextNew(
                l10n.scanOther,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
                _scanDevice(context, l10n);
              },
            ),
            TextButton(
              child: CshTextNew(
                btnText,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
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
        _scanDevice(context, l10n);
      }
    }, onError: (error, stack) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _buildErrorBody(BuildContext context, String message, StoreInProvider provider) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshTextNew.h3(l10n.warning),
          const SizedBox(height: Dimens.space_8),
          Text(
            message,
            style: theme.primaryTextTheme.displaySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(height: Dimens.space_16),
          ComboButton(
            firstBtnText: l10n.cancel,
            secondBtnText: l10n.retry,
            firstBtnClick: () {
              Navigator.pop(context);
            },
            secondBtnClick: () {
              CshMlScannerUtil().openScanner(
                context,
                header: "Scan location Qr Code",
                hintText: "Scan location Qr Code",
                scanFormatList: [BarcodeFormat.qrCode],
                onScanned: (scannedData, controller) {
                  Navigator.pop(context); // pop scanner screen
                  provider.locQrCode = scannedData;
                  provider.verifyStoreInDetails();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
