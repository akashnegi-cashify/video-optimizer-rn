import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/engineer_card_widget.dart';

import '../models/delivery_response.dart';
import 'delivery_deliver_engineer_parts_widget.dart';

// requires DeliveryDeliverProvider
class ItemDeliveryDeliverWidget extends StatelessWidget {
  // item to display
  final EngineerDetail item;

  const ItemDeliveryDeliverWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            DeliveryDeliverEngineerPartsWidget.route,
            arguments: item);
      },
      child: EngineerCardWidget(detail: item),
    );
  }
}
