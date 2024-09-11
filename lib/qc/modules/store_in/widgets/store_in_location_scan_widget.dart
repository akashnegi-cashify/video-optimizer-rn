import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/dialog/show_store_in_type_dialog.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_location_scan_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../l10n.dart';
import '../providers/store_in_provider.dart';

class StoreInLocationScanWidget extends StatelessWidget {
  const StoreInLocationScanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = StoreInProvider.of(context);
    if (provider.isScreenLoading) {
      return const CshShimmer();
    }

    if (!Validator.isTrue(provider.isScreenLoading) && !Validator.isNullOrEmpty(provider.errorMessage)) {
      return _buildErrorBody(context, provider.errorMessage!, provider);
    }

    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
              future: provider.isLoginFromQC(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == true) {
                    return CshCard(
                      margin: const EdgeInsets.only(bottom: Dimens.space_16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CshTextNew.subTitle2("${l10n.storageType}:"),
                              CshTextNew.h3(provider.isBinStoreIn ? l10n.binStorage : l10n.storeIn),
                            ],
                          ),
                          CshMediumOutlineButton(
                            text: l10n.change,
                            onPressed: () => _changeLocationType(context),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              }),
          Expanded(
            child: CshCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: l10n.trayBarcode, style: theme.textTheme.titleSmall),
                      TextSpan(
                        text: provider.locQrCode,
                        style: theme.textTheme.displaySmall,
                      ),
                    ]),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: l10n.totalSpace, style: theme.textTheme.titleSmall),
                      TextSpan(
                        text: "${provider.totalCount ?? 0}",
                        style: theme.textTheme.displaySmall,
                      ),
                    ]),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: l10n.availableSpace, style: theme.textTheme.titleSmall),
                      TextSpan(
                        text: "${provider.availableSpace ?? 0}",
                        style: theme.textTheme.displaySmall,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.space_16),
          if (provider.availableSpace != 0)
            CshBigButton(text: l10n.scanDevice, onPressed: () => _scanDevice(context, l10n)),
        ],
      ),
    );
  }

  void _changeLocationType(BuildContext context) {
    showStoreInTypeDialog(context, onScanned: (qrCode, isBinStoreIn) {
      StoreInLocationScanScreen.replaceTo(context, barcode: qrCode, isBinStoreIn: isBinStoreIn);
    });
  }

  void _scanDevice(BuildContext context, L10n l10n) {
    CshMlScannerUtil().openScanner(
      context,
      header: l10n.scanDeviceCamelCase,
      hintText: l10n.scanDeviceCamelCase,
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // pop scanner screen
        _showConfirmationDialog(context, scannedData, l10n);
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, String deviceBarcode, L10n l10n) {
    var provider = StoreInProvider.of(context, listen: false);
    var theme = Theme.of(context);
    var title = provider.isBinStoreIn ? l10n.binStorage : l10n.storeIn;

    showDialog(
      context: context,
      builder: (builderContext) {
        return AlertDialog(
          title: RichText(
            text: TextSpan(children: [
              TextSpan(text: title, style: theme.textTheme.titleSmall),
              TextSpan(
                text: " (${provider.locQrCode})",
                style: theme.textTheme.displaySmall,
              ),
            ]),
          ),
          content: RichText(
            text: TextSpan(children: [
              TextSpan(text: l10n.stockBarcode, style: theme.textTheme.titleSmall),
              TextSpan(
                text: deviceBarcode,
                style: theme.textTheme.displaySmall,
              ),
            ]),
          ),
          actions: <Widget>[
            CshMediumButton(
              text: l10n.scanOther,
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
                _scanDevice(context, l10n);
              },
            ),
            CshMediumButton(
              text: l10n.save,
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
                _storeInDevice(context, deviceBarcode, l10n);
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
      if ((value?.availableSpace ?? 0) > 0) {
        _scanDevice(context, l10n);
      } else {
        _showChangeLocationDialog(context);
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
              _onScanAnotherLocation(context, provider);
            },
          ),
        ],
      ),
    );
  }

  _onScanAnotherLocation(BuildContext context, StoreInProvider provider) {
    var l10n = L10n(context, listen: false);
    var hint = provider.isBinStoreIn ? l10n.scanBinLocationQrCode : l10n.scanLocationQrCode;
    CshMlScannerUtil().openScanner(
      context,
      header: hint,
      hintText: hint,
      scanFormatList: [BarcodeFormat.qrCode],
      onScanned: (scannedData, controller) {
        Navigator.pop(context); // pop scanner screen
        provider.locQrCode = scannedData;
        provider.verifyStoreInDetails();
      },
    );
  }

  _showChangeLocationDialog(BuildContext context) {
    var provider = StoreInProvider.of(context, listen: false);
    var l10n = L10n(context, listen: false);

    showDialog(
      context: context,
      builder: (builderContext) {
        return AlertDialog(
          title: CshTextNew.h3("${l10n.spaceIsFull}!"),
          content: CshTextNew.h3(l10n.doYouWantToChangeLocation),
          actions: <Widget>[
            CshMediumOutlineButton(
              text: l10n.goBack,
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
                Navigator.pop(context); // pop screen
              },
            ),
            CshMediumButton(
              text: l10n.scan,
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
                _onScanAnotherLocation(context, provider);
              },
            )
          ],
        );
      },
    );
  }
}
