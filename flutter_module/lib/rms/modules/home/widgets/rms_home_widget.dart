import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/widgets/receive_device_create_video_module.dart';
import 'package:flutter_trc/src/common/facility_list/widgets/current_facility_widget.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';

import '../../receive_device/widgets/receive_device_module.dart';

class RmsHomeWidget extends StatelessWidget {
  RmsHomeWidget({super.key});

  final GlobalKey<CurrentFacilityWidgetState> currentFacilityKey = GlobalKey<CurrentFacilityWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurrentFacilityWidget(
            key: currentFacilityKey,
            getFacility: AppPreferences.rms.getFacility,
            setFacility: AppPreferences.rms.setFacility,
          ),
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
