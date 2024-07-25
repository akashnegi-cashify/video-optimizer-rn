import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/widgets/receive_device_create_video_module.dart';
import 'package:flutter_trc/rms/rms_common/widgets/current_facility_widget.dart';

import '../../receive_device/widgets/receive_device_module.dart';

class RmsHomeWidget extends StatelessWidget {
  RmsHomeWidget({super.key});

  final GlobalKey<CurrentFacilityState> currentFacilityKey = GlobalKey<CurrentFacilityState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurrentFacility(key: currentFacilityKey),
          const SizedBox(height: 200),
          ReceiveDeviceModule(onFacilityChanged: _onFacilityChanged),
          const SizedBox(height: Dimens.space_16),
          const ReceiveDeviceCreateVideoModule(),
        ],
      ),
    );
  }

  _onFacilityChanged() {
    currentFacilityKey.currentState?.refresh();
  }
}
