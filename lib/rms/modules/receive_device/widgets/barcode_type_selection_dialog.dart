import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';

showBarcodeTypeSelectionDialog(BuildContext context, {required Function(BarcodeTypes barcodeType) onSelected}) {
  showCshBottomSheet(
    context: context,
    child: Container(
      padding: const EdgeInsets.all(Dimens.space_24),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CshTextNew.h3("Select Barcode Type"),
          const Divider(thickness: 1),
          const SizedBox(height: Dimens.space_24),
          CshBigButton(
              text: "Reference Number",
              onPressed: () {
                onSelected(BarcodeTypes.refNumber);
              }),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
              text: "Awb Number",
              onPressed: () {
                onSelected(BarcodeTypes.awb);
              }),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
              text: "Barcode",
              onPressed: () {
                onSelected(BarcodeTypes.barcode);
              }),
        ],
      ),
    ),
  );
}
