import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';

import '../l10n.dart';

class TRCScannerWidget extends StatefulWidget {
  final Function(String scannedData, MlScannerController? controller) onScanDetected;
  final List<ScanFormats> scanFormatList;

  const TRCScannerWidget({Key? key, required this.onScanDetected, this.scanFormatList = const [ScanFormats.barcode]})
      : super(key: key);

  @override
  State<TRCScannerWidget> createState() => _TRCScannerWidgetState();
}

class _TRCScannerWidgetState extends State<TRCScannerWidget> {
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
                scanFormatList: widget.scanFormatList,
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
                  hintText: l10n.enterBarcode,
                  labelText: l10n.enterBarcode,
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
              text: l10n.submit,
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
