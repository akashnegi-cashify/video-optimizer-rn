import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../l10n.dart';
import '../models/trc_executive_config_model.dart';
import '../screens/device_scanner_screen.dart';

class TrcExecutiveWidget extends StatelessWidget {
  final TrcExecutiveConfigModel? configModel;

  const TrcExecutiveWidget({
    Key? key,
    this.configModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshMediumButton(
            text: configModel?.buttonText ?? l10n.receiveDevice,
            onPressed: () => Navigator.pushNamed(context, DeviceScannerScreen.route),
          )
        ],
      ),
    );
  }
}
