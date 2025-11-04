import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../l10n.dart';

abstract interface class ResetLastScannedBarcode {
  void resetLastScannedBarcode();
}

class TRCScannerWidget extends StatefulWidget {
  final Function(String scannedData, MlScannerController? controller, {bool? isManualEntry}) onScanDetected;
  final List<BarcodeFormat> scanFormatList;
  final bool isEditTextSubmitButtonDirectionHorizontal;
  final String? hintText;
  final Widget? bottomView;
  final Function(ResetLastScannedBarcode resetController)? onResetController;

  const TRCScannerWidget({
    super.key,
    required this.onScanDetected,
    this.scanFormatList = const [BarcodeFormat.code128],
    this.isEditTextSubmitButtonDirectionHorizontal = false,
    this.hintText,
    this.bottomView,
    this.onResetController,
  });

  @override
  State<TRCScannerWidget> createState() => _TRCScannerWidgetState();
}

class _TRCScannerWidgetState extends State<TRCScannerWidget> implements ResetLastScannedBarcode {
  final TextEditingController _textEditController = TextEditingController();
  bool _enableButton = false;
  String? _lastScannedBarcode;
  MlScannerController? _mlScannerController;

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
    widget.onResetController?.call(this);
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
                barcodeFormats: widget.scanFormatList,
                isPlayScanSound: true,
                getLastScannedBarcode: () => _lastScannedBarcode,
                zoomScale: 0.5,
                onScannerStarted: (controller) {
                  _mlScannerController = controller;
                },
                onScannerDetected: (String value, MlScannerController controller) {
                  _lastScannedBarcode = value;
                  _mlScannerController = controller;
                  widget.onScanDetected(value, _mlScannerController);
                },
              ),
            ),
          ),
          if (widget.bottomView != null) widget.bottomView!,
          if (widget.bottomView == null) ...[
            const SizedBox(height: Dimens.space_50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: CshTextFormField(
                    controller: _textEditController,
                    counterText: "",
                    autofocus: false,
                    hintText: widget.hintText ?? l10n.enterBarcode,
                    labelText: widget.hintText ?? l10n.enterBarcode,
                    keyboardType: TextInputType.text,
                  ),
                ),
                if (Validator.isTrue(widget.isEditTextSubmitButtonDirectionHorizontal))
                  Padding(padding: const EdgeInsets.only(left: Dimens.space_4), child: _buildSubmitWidget(l10n)),
              ],
            ),
            if (!Validator.isTrue(widget.isEditTextSubmitButtonDirectionHorizontal))
              SizedBox(width: Dimens.space_120, child: _buildSubmitWidget(l10n)),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmitWidget(L10n l10n) {
    return CshBigButtonWithLoader(
      text: l10n.submit,
      onPressed: _enableButton
          ? (controller) {
              controller.startLoading();
              FocusScope.of(context).unfocus();
              widget.onScanDetected(_textEditController.text, _mlScannerController, isManualEntry: true);
              _textEditController.clear();
              setState(() {});
              controller.stopLoading();
            }
          : null,
    );
  }

  @override
  void dispose() {
    _mlScannerController = null;
    super.dispose();
  }

  @override
  void resetLastScannedBarcode() {
    _lastScannedBarcode = null;
  }
}
