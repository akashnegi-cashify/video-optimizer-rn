import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/dispatch_screen.dart';
import 'package:flutter_trc/shipex/modules/packaging/shipex_packing_screen.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/screens/pending_dispatch_provider_list_screen.dart';

import '../../create_shipment/screen/sub_order_group_listing_screen.dart';
import '../../l10n.dart';

class ShipexHomeWidget extends StatelessWidget {
  const ShipexHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshMediumButton(
            text: l10n.createShipment,
            onPressed: () {
              Navigator.of(context).pushNamed(SubOrderGroupListingScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_20),
          CshMediumButton(
            text: l10n.shipexDispatch,
            onPressed: () {
              Navigator.of(context).pushNamed(DispatchScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_20),
          CshMediumButton(
            text: l10n.pendingDispatch,
            onPressed: () {
              Navigator.of(context).pushNamed(PendingDispatchProviderListScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_20),
          CshMediumButton(
            text: l10n.shipexPackaging,
            onPressed: () {
              Navigator.of(context).pushNamed(ShipexPackingScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
