import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_enum.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_widget.dart';
import 'package:flutter_trc/src/modules/paint_shop/screens/in_progress_devices_screen.dart';

class PaintShopHomeWidget extends StatelessWidget {
  const PaintShopHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReceiveDeviceWidget(deviceType: ReceiveDeviceEnum.paintShop),
          const SizedBox(height: Dimens.space_24),
          CshBigButton(
            text: "In Progress Devices",
            onPressed: () => InProgressDevicesScreen.open(context),
          ),
        ],
      ),
    );
  }
}
