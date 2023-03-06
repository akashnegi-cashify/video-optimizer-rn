import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:provider/provider.dart';

import '../models/receive_response_model.dart';
import '../providers/delivery_receive_provider.dart';

// requires DeliveryReceiveProvider
class ItemDeliveryReceiveWidget extends StatelessWidget {
  // item to display
  final Part item;

  // returned success confirmation to refresh main list
  final Function onReceiveConfirm;

  const ItemDeliveryReceiveWidget({Key? key, required this.item, required this.onReceiveConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10 = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      child: CshCard(
          child: Column(
        children: [
          KeyValueRowWidget(title: l10.partName, value: item.partName),
          KeyValueRowWidget(title: l10.partBarcode, value: item.partBarcode),
          KeyValueRowWidget(title: l10.partSku, value: item.partSku),
          KeyValueRowWidget(title: l10.pickFrom, value: item.inventoryManageName),
          CshMediumOutlineButton(
              text: l10.receiveAllCaps,
              onPressed: () {
                CshAlertPopup(context,
                    desc: l10.clickOnConfirmToReceive,
                    negBtnText: l10.cancel,
                    posBtnText: l10.confirm, onPosBtnPressed: () {
                  confirmReceiveRequest(item.partId, context);
                });
              })
        ],
      )),
    );
  }

  void confirmReceiveRequest(int itemId, BuildContext context) {
    L10n l10 = L10n(context);
    Provider.of<DeliveryReceiveProvider>(context, listen: false).confirmReceive(itemId).listen((event) {
      Navigator.pop(context);
      onReceiveConfirm();
      CshSnackBar.success(context: context, message: l10.partReceivedSuccessfully);
    }).onError((e, s) {
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(e) ?? l10.somethingWentWrong);
    });
  }
}
