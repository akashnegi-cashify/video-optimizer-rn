import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_barcode_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculator_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/calculator_media_capture_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/home/resources/tester_home_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/lob_device_scanner_screen.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';
import 'package:flutter_trc/qc/qc_role_permission/widget/qc_role_permission_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/scan_manual_test_barcode_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/start_manual_testing_event.dart';

import '../../disputed_image_capture/screens/disputed_image_capture_screen.dart';

class QcTesterHomeWidget extends StatelessWidget {
  const QcTesterHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  CshMlScannerUtil().openScanner(
                    context,
                    header: "Capture Dispute Media",
                    hintText: "Scan Device Barcode",
                    onScanned: (scannedData, controller) {
                      if (scannedData.isNotEmpty) {
                        DisputedImageCaptureScreenArguments arg =
                            DisputedImageCaptureScreenArguments(barcode: scannedData.trim());
                        Navigator.of(context).pushReplacementNamed(DisputedImageCaptureScreen.route, arguments: arg);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: Dimens.space_16),
              CshBigButton(
                text: "Capture Device Media",
                onPressed: () {
                  CshMlScannerUtil().openScanner(
                    context,
                    header: "Capture Device Media",
                    hintText: "Scan Device Barcode",
                    onScanned: (scannedData, controller) {
                      if (scannedData.isNotEmpty) {
                        CalculatorDataHolderModel().startImageCaptureJourney(scannedData);
                        Navigator.of(context).pushReplacementNamed(CalculatorMediaCaptureScreen.route);
                      }
                    },
                  );
                },
              ),
              QcRolePermissionWidget(
                padding: const EdgeInsets.only(top: Dimens.space_16),
                role: QcRole.roleManualTesting,
                child: CshBigButton(
                  text: "Start Manual Testing",
                  onPressed: () {
                    AnalyticsController.logEvent(StartManualTestingEvent());
                    CshMlScannerUtil().openScanner(
                      context,
                      header: "Manual Testing",
                      hintText: "Scan Device Barcode",
                      onScanned: (scannedData, controller) {
                        if (scannedData.isNotEmpty) {
                          AnalyticsController.logEvent(ScanManualTestBarcodeEvent(scannedData));
                          Navigator.pushReplacementNamed(context, LobDeviceScannerScreen.route,
                              arguments: LobDeviceScannerScreenArg(barcode: scannedData));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: Dimens.space_16,
            left: 0,
            right: 0,
            child: StreamBuilder(
              stream: TesterHomeService.getTestingCount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  var data = snapshot.data?.testingDeviceData;
                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Keep It Up!",
                      style: theme.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: " ${data?.testingDeviceCount ?? 0} ",
                          style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary),
                        ),
                        const TextSpan(text: " Devices tested today till"),
                        TextSpan(
                          text:
                              " ${formatDate(timeStamp: data?.lastUpdatedDate ?? DateTime.now().millisecondsSinceEpoch, pattern: DateFormats.h_MM_a.value)}",
                          style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
