import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';
import 'l10n.dart';

class BarcodeScannerControllerWidget extends StatefulWidget {
  static const route = "/barcode_scanner_controller";

  const BarcodeScannerControllerWidget({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerControllerWidget> createState() => _BarcodeScannerControllerWidgetState();
}

class _BarcodeScannerControllerWidgetState extends State<BarcodeScannerControllerWidget> {
  final TextEditingController _barcodeController = TextEditingController();
  bool _fieldActive = false;

  @override
  void initState() {
    _barcodeController.addListener(
      () {
        if (_barcodeController.text.isNotEmpty) {
          _fieldActive = true;
        } else {
          _fieldActive = false;
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var callback =
        ModalRoute.of(context)?.settings.arguments as Function(String result, {MlScannerController? controller})?;
    return Scaffold(
      appBar: TrcHeader(l10n.barcodeScanner),
      body: Column(
        children: [
          Expanded(
            child: MlBarcodeScannerWidget(
              allowDuplicateScan: false,
              onScannerDetected: (String value, MlScannerController mlController) {
                if (callback != null) {
                  callback(value, controller: mlController);
                }
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: Dimens.space_120,
            color: theme.backgroundColor,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CshTextFormField(
                        controller: _barcodeController,
                        counterText: "",
                        autofocus: false,
                        maxLength: 50,
                        maxLines: 1,
                        hintText: l10n.enterBarcode,
                      ),
                      if (_fieldActive)
                        GestureDetector(
                          onTap: () {
                            _barcodeController.clear();
                            _fieldActive = false;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: Dimens.space_12),
                            child: CshIcon(
                              FeatherIcons.xCircle,
                              iconSize: MobileIconSize.medium,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: Dimens.space_8),
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.space_16),
                  child: CshMediumButton(
                    text: l10n.next,
                    onPressed: _fieldActive
                        ? () {
                            if (_barcodeController.text.isNotEmpty) {
                              String data = _barcodeController.text.trim();
                              if (callback != null) {
                                callback(data);
                              }
                            }
                          }
                        : null,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
