import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/screens/qr_barcode_scanner.dart';
import 'l10n.dart';

class BarcodeScanWidget extends StatefulWidget {
  static const route = "barcode_scanner";

  const BarcodeScanWidget({Key? key}) : super(key: key);

  @override
  State<BarcodeScanWidget> createState() => _BarcodeScanWidgetState();
}

class _BarcodeScanWidgetState extends State<BarcodeScanWidget> {
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
    var callback = ModalRoute.of(context)?.settings.arguments as Function(String)?;
    return Scaffold(
      appBar: CshHeader(l10n.barcodeScanner),
      body: Column(
        children: [
          Expanded(child: QrBarcodeScanner(onResultantCallback: callback ?? (String data) {})),
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
                              callback!(data);
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
