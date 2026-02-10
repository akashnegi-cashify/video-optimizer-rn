import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_location_verify_response.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/trc_executive/resources/device_scanner_service.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/device_scanner_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_lot_list_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../l10n.dart';
import '../models/trc_executive_config_model.dart';

class TrcExecutiveWidget extends StatelessWidget {
  final TrcExecutiveConfigModel? configModel;

  const TrcExecutiveWidget({
    super.key,
    this.configModel,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Dimens.space_16,
          children: [
            CshMediumButton(
              text: l10n.storeIn,
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  header: l10n.scanStorageBarcode,
                  hintText: l10n.scanStorageBarcode,
                  scanFormatList: [BarcodeFormat.qrCode],
                  onScanned: (scannedData, controller) {
                    Navigator.pop(context);
                    _getStorageDetails(context, scannedData);
                  },
                );
              },
            ),
            CshMediumButton(
              text: l10n.storeOut,
              onPressed: () {
                Navigator.pushNamed(context, TrcExecutiveLotListScreen.route);
              },
            )
          ],
        ),
      ),
    );
  }

  _getStorageDetails(BuildContext context, String storageBarcode) {
    CshLoading().showLoading(context);
    DeviceScannerService.getStorageDetails(storageBarcode).listen((event) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        Logger.debug('mydebug-----TrcExecutiveWidget._getStorageDetails', [event]);
        _showDialog(context, event, storageBarcode);
      }
    }, onError: (error) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
      }
    });
  }

  _showDialog(BuildContext context, StoreInLocationVerifyResponse? data, String storageBarcode) {
    var theme = Theme.of(context);
    var l10n = L10n(context, listen: false);
    showCshBottomSheet(
      context: context,
      child: CshCard(
        padding: EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: "${l10n.storage} : ", style: theme.textTheme.titleMedium),
                TextSpan(
                  text: storageBarcode,
                  style: theme.textTheme.displayMedium,
                ),
              ]),
            ),
            const SizedBox(height: Dimens.space_8),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: "${l10n.totalSpace} : ", style: theme.textTheme.titleMedium),
                TextSpan(
                  text: "${data?.totalSpace ?? 0}",
                  style: theme.textTheme.displayMedium,
                ),
              ]),
            ),
            const SizedBox(height: Dimens.space_8),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: "${l10n.availableSpace} : ", style: theme.textTheme.titleMedium),
                TextSpan(
                  text: "${data?.availableSpace ?? 0}",
                  style: theme.textTheme.displayMedium,
                ),
              ]),
            ),
            SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.storeIn,
              onPressed: () {
                Navigator.pop(context); // pop alert dialog
                DeviceScannerScreen.pushNamed(context, storageBarcode);
              },
            )
          ],
        ),
      ),
    );
  }
}
