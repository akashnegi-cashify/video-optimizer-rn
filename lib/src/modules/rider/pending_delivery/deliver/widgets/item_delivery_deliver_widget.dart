import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/engineer_card_widget.dart';

import '../delivery_deliver_engineer_parts_screen.dart';
import '../models/delivery_response.dart';

// requires DeliveryDeliverProvider
class ItemDeliveryDeliverWidget extends StatelessWidget {
  // item to display
  final EngineerDetail item;

  const ItemDeliveryDeliverWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DeliveryDeliverEngineerPartsScreenArguments args =
            DeliveryDeliverEngineerPartsScreenArguments(engineerDetail: item);
        Navigator.of(context).pushNamed(DeliveryDeliverEngineerPartsScreen.route, arguments: args);
      },
      child: EngineerCardWidget(detail: item),
    );
  }
}
