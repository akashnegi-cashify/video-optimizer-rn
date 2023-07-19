import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../providers/barcode_scanner_provider.dart';

class BarcodeFieldWidget extends StatefulWidget {
  const BarcodeFieldWidget({Key? key}) : super(key: key);

  @override
  State<BarcodeFieldWidget> createState() => BarcodeFieldWidgetState();
}

class BarcodeFieldWidgetState extends State<BarcodeFieldWidget> {
  final TextEditingController _barcodeFieldController = TextEditingController();
  bool _isFieldActive = false;

  setScannedBarcodeData(String data) {
    _barcodeFieldController.clear();
    _barcodeFieldController.text = data.trim();
    setState(() {});
  }

  @override
  void initState() {
    _barcodeFieldController.addListener(() {
      if (_barcodeFieldController.text.isNotEmpty) {
        _isFieldActive = true;
      } else {
        _isFieldActive = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.orEnterManually,
            style: theme.primaryTextTheme.headlineMedium,
          ),
          const SizedBox(height: Dimens.space_12),
          CshTextFormField(
            controller: _barcodeFieldController,
            maxLines: 1,
            hintText: l10n.enterBarcode,
          ),
          const SizedBox(height: Dimens.space_16),
          Align(
            alignment: Alignment.center,
            child: CshMediumButton(
              onPressed: _isFieldActive
                  ? () {
                      FocusScope.of(context).unfocus();
                      String data = _barcodeFieldController.text.trim();
                      _scanBarcodeMethod(theme, context, data);
                    }
                  : null,
              text: l10n.submit,
            ),
          )
        ],
      ),
    );
  }

  _scanBarcodeMethod(ThemeData theme, BuildContext context, String data) {
    var provider = BarcodeScannerProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.scanBarcodeData(data).then((value) {
      if (value) {
        CshLoading().hideLoading(context);
        _barcodeFieldController.clear();
        CshSnackBar.success(
            context: context,
            message: "Barcode Scanned Successfully",
            snackBarPosition: SnackBarPosition.TOP,
            duration: SnackBarDuration.SHORT);
        setState(() {});
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(
        context: context,
        message: error,
        duration: SnackBarDuration.MEDIUM,
        snackBarPosition: SnackBarPosition.TOP,
      );
    });
  }
}
