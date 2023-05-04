import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';

import '../../../pending_delivery/receive/models/receive_response_model.dart';

class PickupReceiveBarcodeScannerWidget extends StatelessWidget {
  final Function(String) onPartReceive;
  final Part part;

  PickupReceiveBarcodeScannerWidget({Key? key, required this.onPartReceive, required this.part}) : super(key: key);

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader(l10n.engineerReceiveDevice),
      body: Column(
        children: [
          CshCard(
              child: Column(
            children: [
              KeyValueRowWidget(title: l10n.partName, value: part.partName),
              KeyValueRowWidget(
                title: l10n.partSku,
                value: part.partSku,
              ),
              KeyValueRowWidget(
                title: l10n.partColor,
                value: part.partColor,
              ),
            ],
          )),
          Expanded(
            child: BarCodeScannerWidget(
              resultCallback: (result, {BarcodeScannerController? controller}) {
                onPartReceive(result);
              },
            ),
          ),
          // Expanded(child: Container(color: Colors.orange,)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
            child: CshTextNew.h1(l10n.orAllCAPs),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: CshTextFormField(
              hintText: l10n.enterThePartBarcode,
              controller: textController,
            ),
          ),
          CshBigButton(
            text: l10n.submit,
            onPressed: () {
              onPartReceive(textController.text);
            },
          )
        ],
      ),
    );
  }
}
