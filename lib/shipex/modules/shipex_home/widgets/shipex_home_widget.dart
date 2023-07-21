import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/dispatch_screen.dart';

import '../../l10n.dart';

class ShipexHomeWidget extends StatelessWidget {
  const ShipexHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.shipexDispatch,
              onPressed: () {
                Navigator.of(context).pushNamed(DispatchScreen.route);
              },
            ),
          ),
          const SizedBox(height: Dimens.space_20),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.shipexPackaging,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
