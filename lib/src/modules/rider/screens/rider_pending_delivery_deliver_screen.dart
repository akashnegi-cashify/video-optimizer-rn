import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/widgets/delivery_deliver_widget.dart';

class RiderPendingDeliveryDeliverScreen extends StatelessWidget {
  static String route = "/rider-pending-delivery-deliver";

  const RiderPendingDeliveryDeliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Deliver"),
      body: Container(
        padding: EdgeInsets.all(Dimens.space_16),
        child: DeliveryDeliverWidget(),
      ),
    );
  }
}
