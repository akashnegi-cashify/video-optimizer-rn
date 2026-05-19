import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/receive/widgets/delivery_receive_widget.dart';

import 'deliver/widgets/delivery_deliver_widget.dart';

class PendingDeliveryWidget extends StatefulWidget {
  const PendingDeliveryWidget({Key? key}) : super(key: key);

  @override
  State<PendingDeliveryWidget> createState() => _PendingDeliveryWidgetState();
}

class _PendingDeliveryWidgetState extends State<PendingDeliveryWidget>
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
    L10n l10 = L10n(context);

    return Column(
      children: [
        CshTabBar(
            tabs: [CshTab(label: l10.receive), CshTab(label: l10.deliver)],
            controller: _controller,
            labelPadding: EdgeInsets.zero),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: const [DeliveryReceiveWidget(), DeliveryDeliverWidget()],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
