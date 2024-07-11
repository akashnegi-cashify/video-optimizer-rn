import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/widgets/receive_device_create_video_module.dart';

import '../../receive_device/widgets/receive_device_module.dart';

class RmsHomeWidget extends StatelessWidget {
  const RmsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReceiveDeviceModule(),
          SizedBox(height: Dimens.space_16),
          ReceiveDeviceCreateVideoModule(),
        ],
      ),
    );
  }
}
