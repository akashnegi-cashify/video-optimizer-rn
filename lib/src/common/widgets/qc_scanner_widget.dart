import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';

import '../../l10n.dart';

class QCScannerWidget extends StatefulWidget {
  final Function(String scannedData, MlScannerController? controller) onScanDetected;

  const QCScannerWidget({Key? key, required this.onScanDetected}) : super(key: key);

  @override
  State<QCScannerWidget> createState() => _QCScannerWidgetState();
}

class _QCScannerWidgetState extends State<QCScannerWidget> {
  final TextEditingController _textEditController = TextEditingController();
  bool _enableButton = false;

  @override
  void initState() {
    _textEditController.addListener(() {
      if (_textEditController.text.trim().isNotEmpty) {
        _enableButton = true;
      } else {
        _enableButton = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          Expanded(
            child: CshCard(
              elevation: CardElevation.dimen_10,
              child: MlBarcodeScannerWidget(
                isStartDelay: true,
                scanFormatList: const [ScanFormats.barcode],
                onScannerDetected: (String value, MlScannerController controller) {
                  widget.onScanDetected(value, controller);
                },
              ),
            ),
          ),
          const SizedBox(height: Dimens.space_50),
          Row(
            children: [
              Expanded(
                child: CshTextFormField(
                  controller: _textEditController,
                  counterText: "",
                  autofocus: false,
                  hintText: "Enter Barcode",
                  labelText: "Enter Barcode",
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: Dimens.space_120,
            child: CshBigButton(
              text: "Submit",
              onPressed: _enableButton
                  ? () {
                      FocusScope.of(context).unfocus();
                      widget.onScanDetected(_textEditController.text, null);
                      _textEditController.clear();
                      setState(() {});
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
