import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_enum.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_provider.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ReceiveDeviceWidget extends StatelessWidget {
  final ReceiveDeviceEnum deviceType;

  const ReceiveDeviceWidget({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReceiveDeviceProvider>(
      create: (_) => ReceiveDeviceProvider(deviceType: deviceType),
      builder: (BuildContext insideContext, __) {
        return CshBigButton(
          text: "Receive Device",
          onPressed: () {
            CshMlScannerUtil().openScanner(
              context,
              onScanned: (barcode, controller) {
                _onScanned(
                  context,
                  provider: Provider.of<ReceiveDeviceProvider>(insideContext, listen: false),
                  barcode: barcode,
                  controller: controller,
                );
              },
            );
          },
        );
      },
    );
  }

  void _onScanned(
    BuildContext context, {
    required ReceiveDeviceProvider provider,
    required String barcode,
    MobileScannerController? controller,
  }) {
    controller?.stop();
    provider.receiveDevice(barcode).listen((event) {
      CshSnackBar.success(
        context: context,
        message: event?.successMsg ?? "Device scanned successfully",
      );
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      CshSnackBar.error(context: context, message: errorMessage);
    }, onDone: () {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (controller != null) {
          controller.start();
        }
      });
    });
  }
}
