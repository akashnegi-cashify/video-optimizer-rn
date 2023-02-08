import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/user/widget/logout_action_widget.dart';
import 'package:flutter_trc/src/modules/elss/screens/elss_screen.dart';

import '../l10n.dart';

class QcAndTRCOptionScreen extends StatelessWidget {
  static const String route = '/qc-and-trc-option-screen';

  const QcAndTRCOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: CshHeader(
        l10n.techRefurbishmentCenter,
        showBackBtn: false,
        // don't add const below as this list will be altered lately
        actions: [LogoutActionWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: CshMediumButton(
                  text: l10n.qc,
                  onPressed: () {
                    Navigator.of(context).pushNamed(ELSSScreen.route);
                  },
                ),
              ),
              const SizedBox(height: Dimens.space_60),
              SizedBox(
                width: double.infinity,
                child: CshMediumButton(
                  text: l10n.trc,
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
