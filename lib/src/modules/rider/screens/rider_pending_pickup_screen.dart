import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/pending_pickup_widget.dart';

class RiderPendingPickupScreen extends StatelessWidget {
  static String route = "/rider_pending_pickup";
  const RiderPendingPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Pending Pickup"),
      body: PendingPickupWidget(),
    );
  }
}
