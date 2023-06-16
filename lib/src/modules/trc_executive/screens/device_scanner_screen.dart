import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/device_scanner_provider.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class DeviceScannerScreen extends StatelessWidget {
  static var route = "/device-receive";

  const DeviceScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader(l10n.barcodeScanner),
      body: ChangeNotifierProvider(
        create: (_) => DeviceScannerProvider(),
        lazy: false,
        builder: (builderContext, _) {
          var provider = DeviceScannerProvider.of(builderContext);
          return TRCScannerWidget(
            onScanDetected: (String scannedData, MlScannerController? controller) {
              controller?.stop();
              CshLoading().showLoading(context);
              provider.onDeviceScanned(scannedData).then((value) {
                CshLoading().hideLoading(context);
                _showDeviceDetails(value, context).whenComplete(() {
                  FocusScope.of(context).unfocus();
                  controller?.start();
                });
              }, onError: (error) {
                controller?.start();
                CshLoading().hideLoading(context);
                CshSnackBar.error(context: context, message: error.toString());
              });
            },
          );
        },
      ),
    );
  }

  Future _showDeviceDetails(DeviceReceiveData value, BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return showCshBottomSheet(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleValue(l10n.deviceBarcode, value.deviceBarcode.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            _buildTitleValue(l10n.productTitle, value.productTitle.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            if (!Validator.isNullOrEmpty(value.elssEngineerName)) ...[
              _buildTitleValue(l10n.elssEngineerName, value.elssEngineerName.toString(), theme),
              const SizedBox(height: Dimens.space_16),
            ],
            _buildTitleValue(l10n.status, value.status.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            _buildTitleValue(l10n.repairType, value.repairType.toString(), theme),
            const SizedBox(height: Dimens.space_16),
            SizedBox(
              width: double.infinity,
              child: CshMediumButton(text: l10n.close, onPressed: () => Navigator.pop(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleValue(String title, String value, ThemeData theme) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyText1,
        text: "$title : ",
        children: [TextSpan(text: value, style: theme.textTheme.subtitle1)],
      ),
    );
  }
}
