import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';

class StockTransferListItemWidget extends StatelessWidget {
  final StockTransferListData? item;
  final int index;

  const StockTransferListItemWidget(this.item, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return CshCard(
      cardWidth: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextNew.h3("#${index + 1} - ${item?.lotName}"),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.bodyText1("Destination - ${item?.destinationFacility}"),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.bodyText1("Status - ${item?.status}"),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.bodyText1("(Click to view list or add ore devices)"),
        ],
      ),
    );
  }
}
