import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_widget.dart';

import 'deliver/widgets/pickup_deliver_widget.dart';

class PendingPickupWidget extends StatefulWidget {
  const PendingPickupWidget({Key? key}) : super(key: key);

  @override
  State<PendingPickupWidget> createState() => _PendingPickupWidgetState();
}

class _PendingPickupWidgetState extends State<PendingPickupWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    L10n l10n = L10n(context);
    return Column(
      children: [
        CshTabBar(
            tabs: [CshTab(label: l10n.receive), CshTab(label: l10n.deliver)],
            controller: _controller,
            labelPadding: EdgeInsets.zero),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: const [PickupReceiveWidget(), PickupDeliverWidget()],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
