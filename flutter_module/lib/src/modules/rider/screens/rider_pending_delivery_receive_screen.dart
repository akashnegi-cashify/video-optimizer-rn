import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../provider/pending_delivery_receive_provider.dart';

class PendingDeliveryReceiveScreen extends StatelessWidget {
  static const String route = "/rider-pending-delivery-receive";

  const PendingDeliveryReceiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader("Receive Device"),
      body: ChangeNotifierProvider(
        create: (_) => PendingDeliveryReceiveProvider(),
        lazy: false,
        builder: (builderContext, _) {
          var provider = PendingDeliveryReceiveProvider.of(builderContext, listen: false);
          return TRCScannerWidget(
            onScanDetected: (String scannedData, MlScannerController? controller, {isManualEntry}) {
              controller?.stop();
              CshLoading().showLoading(context);
              provider.onDeviceScanned(scannedData).then((value) {
                if (context.mounted) {
                  CshLoading().hideLoading(context);
                  CshSnackBar.success(
                    context: context,
                    message: "Device Received Successfully",
                    snackBarPosition: SnackBarPosition.TOP,
                  );
                  controller?.start();
                  FocusScope.of(context).unfocus();
                }
              }, onError: (error) {
                controller?.start();
                if (context.mounted) {
                  CshLoading().hideLoading(context);
                  CshSnackBar.error(context: context, message: error.toString());
                }
              });
            },
          );
        },
      ),
    );
    ;
  }
}
