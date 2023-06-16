import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/device_scanner_screen.dart';

import '../l10n.dart';

class TRCExecutiveScreen extends StatelessWidget {
  static String route = "/trc_executive";

  const TRCExecutiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader(l10n.fieldExecutive, showLogoutButton: true),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimens.space_16),
        child: CshMediumButton(
          text: l10n.receiveDevice,
          onPressed: () => Navigator.pushNamed(context, DeviceScannerScreen.route),
        ),
      ),
    );
  }
}
