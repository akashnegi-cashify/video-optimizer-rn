import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/pending_delivery_widget.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/pending_pickup_widget.dart';

import '../../utils/app_util.dart';

class RiderWidget extends StatefulWidget {
  const RiderWidget({Key? key}) : super(key: key);

  @override
  State<RiderWidget> createState() => _RiderWidgetState();
}

class _RiderWidgetState extends State<RiderWidget> with TickerProviderStateMixin {
  late TabController _controller;
  late L10n l10n;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    l10n = L10n(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
            appBar: TrcHeader(
              snapshot.data ?? l10n.cashify,
              showBackBtn: false,
              showLogoutButton: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  CshTabBar(
                    tabs: [CshTab(label: l10n.pendingDelivery), CshTab(label: l10n.pendingPickup)],
                    controller: _controller,
                    labelPadding: EdgeInsets.zero,
                    height: const TabBarHeights(
                      mobile: 56,
                      tablet: 38,
                      desktop: 38,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: const [
                        PendingDeliveryWidget(),
                        PendingPickupWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
      future: AppUtil.getAppName(),
    );
  }
}
