import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n.dart';

class ScanBarcodeWidget extends StatefulWidget {
  final Function(String scannedData) onScanDetected;
  final String step;

  const ScanBarcodeWidget({super.key, required this.onScanDetected, required this.step});

  @override
  State<ScanBarcodeWidget> createState() => ScanBarcodeWidgetState();
}

class ScanBarcodeWidgetState extends State<ScanBarcodeWidget> {
  Timer? _timer;
  String _scannedText = "";

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CshCard(
              elevation: CardElevation.dimen_10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    size: 150,
                    color: Colors.grey,
                  ),
                  CshTextNew.subTitle1(widget.step),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.space_50),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: CshTextFormField(
                    counterText: "",
                    autofocus: false,
                    hintText: l10n.enterAwbImeiBarcodeNumber,
                    labelText: l10n.enterAwbImeiBarcodeNumber,
                    keyboardType: TextInputType.text,
                    initialValue: _scannedText,
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    onChanged: (data) {
                      if (_timer?.isActive ?? false) _timer?.cancel();
                      _timer = Timer(
                        const Duration(milliseconds: 500),
                        () {
                          setState(() {
                            _scannedText = data.trim();
                            widget.onScanDetected(_scannedText);
                          });
                        },
                      );
                    }),
              ),
            ],
          ),
          SizedBox(
            width: Dimens.space_120,
            child: CshBigButton(
              text: l10n.submit,
              onPressed: !Validator.isNullOrEmpty(_scannedText)
                  ? () {
                      FocusScope.of(context).unfocus();
                      widget.onScanDetected(_scannedText);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
