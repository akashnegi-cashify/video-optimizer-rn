import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingDeliveryProvider extends CshChangeNotifier {
  static PendingDeliveryProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingDeliveryProvider>(context, listen: listen);
  }

  int? eid;
  String barcode = "";

  PendingDeliveryProvider(this.eid);
}
