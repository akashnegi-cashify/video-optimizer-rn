import 'dart:ui';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';
import 'package:provider/provider.dart';

import '../providers/delivery_deliver_provider.dart';
import 'item_delivery_deliver_widget.dart';

class DeliveryDeliverListWidget extends StatefulWidget {
  const DeliveryDeliverListWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryDeliverListWidget> createState() =>
      _DeliveryDeliverListWidgetState();
}

class _DeliveryDeliverListWidgetState extends State<DeliveryDeliverListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryDeliverProvider>(
        builder: (context, provider, widget) {
      var list = provider.displayList;
      if (!Validator.isListNullOrEmpty(list)) {
        return CshList<EngineerDetail>(
          isSwipeToRefreshAllow: true,
          rowCount: list!.length,
          onRefresh: () {
            provider.getData();
          },
          getRowWidget: (index) {
            return ItemDeliveryDeliverWidget(item: list[index]);
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
