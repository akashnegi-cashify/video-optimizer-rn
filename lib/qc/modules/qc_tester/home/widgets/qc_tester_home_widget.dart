import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_barcode_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/barcode_scanner_module/barcode_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculator_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/lob_device_scanner_screen.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';
import 'package:flutter_trc/qc/qc_role_permission/widget/qc_role_permission_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

import '../../disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import '../../disputed_image_capture/screens/disputed_image_capture_screen.dart';

class QcTesterHomeWidget extends StatelessWidget {
  const QcTesterHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshBigButton(
            text: "Assign Device",
            onPressed: () {
              Navigator.of(context).pushNamed(BarcodeScannerScreen.route);
            },
          ),
          QcRolePermissionWidget(
            padding: const EdgeInsets.only(top: Dimens.space_16),
            role: QcRole.roleManualTesting,
            child: CshBigButton(
              text: "Start Testing",
              onPressed: () {
                Navigator.pushNamed(context, CalculatorScannerScreen.route);
              },
            ),
          ),
          QcRolePermissionWidget(
            padding: const EdgeInsets.only(top: Dimens.space_16),
            role: QcRole.roleAudit,
            child: CshBigButton(
              text: "Start Audit",
              onPressed: () {
                Navigator.of(context).pushNamed(AuditBarcodeScannerScreen.route);
              },
            ),
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: "Capture Dispute Media",
            onPressed: () {
              DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
                  onScanDetected: (String scannedData, MlScannerController? controller) {
                if (scannedData.isNotEmpty) {
                  Navigator.of(context).pop();
                  DisputedImageCaptureScreenArguments arg =
                      DisputedImageCaptureScreenArguments(barcode: scannedData.trim());
                  Navigator.of(context).pushNamed(DisputedImageCaptureScreen.route, arguments: arg);
                }
              });
              Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
            },
          ),
          QcRolePermissionWidget(
            padding: const EdgeInsets.only(top: Dimens.space_16),
            role: QcRole.roleManualTesting,
            child: CshBigButton(
              text: "Start Manual Testing",
              onPressed: () {
                Navigator.pushNamed(context, LobDeviceScannerScreen.route);
              },
            ),
          ),
        ],
      ),
    );
  }
}
