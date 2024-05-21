import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/trc_scanner_widget.dart';
import '../l10n.dart';
import '../models/device_receive_response.dart';
import '../providers/device_scanner_provider.dart';

class DeviceScannerWidget extends StatelessWidget {
  const DeviceScannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeviceScannerProvider(),
      lazy: false,
      builder: (builderContext, _) {
        var provider = DeviceScannerProvider.of(builderContext);
        return TRCScannerWidget(
          onScanDetected: (String scannedData, MlScannerController? controller, {isManualEntry}) {
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
