import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/receive_device/laptop_receive_device_enum.dart';
import 'package:flutter_trc/src/common/receive_device/receive_device_widget.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/screens/assembly_in_progress_screen.dart';

class LaptopAssemblyHomeWidget extends StatelessWidget {
  const LaptopAssemblyHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReceiveDeviceWidget(deviceType: LaptopReceiveDeviceEnum.laptopAssembly),
          const SizedBox(height: Dimens.space_24),
          CshBigButton(
            text: "In Progress Devices",
            onPressed: () => AssemblyInProgressScreen.open(context),
          ),
        ],
      ),
    );
  }
}
