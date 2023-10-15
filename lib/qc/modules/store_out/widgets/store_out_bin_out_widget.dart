import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

import '../../stock_in_module/widgets/index.dart';
import '../providers/index.dart';
import '../resources/index.dart';
import '../l10n.dart';
import 'index.dart';


class StoreOutBinOutWidget extends StatefulWidget {
  const StoreOutBinOutWidget({super.key});

  @override
  State<StoreOutBinOutWidget> createState() => _StoreOutBinOutWidgetState();
}

class _StoreOutBinOutWidgetState extends State<StoreOutBinOutWidget> {
  late TextEditingController _locationTextController;
  late TextEditingController _barcodeTextController;

  @override
  void initState() {
    super.initState();
    _locationTextController = TextEditingController();
    _barcodeTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return LotScanWidget(
      onScannerDetected:(String value, MlScannerController controller) {

        if (isNotEmpty(value)) {
          if (_locationTextController.text.isEmpty) {
            _locationTextController.text = value;
          } else if (_barcodeTextController.text.isEmpty) {
            _barcodeTextController.text = value;
          }
        }
      },
      content: Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledTextField(
                label: l10n.location,
                hintText: '',
                controller: _locationTextController,
              ),
              const SizedBox(height: Dimens.space_8),
              LabeledTextField(
                label: l10n.barCode,
                hintText: '',
                controller: _barcodeTextController,
              ),
            ],
          )),
      footer: Padding(
        padding: const EdgeInsets.all(16),
        child: CshBigButton(
          text: l10n.scan,
          onPressed: () => _onScanBtnClick(context,l10n),
        ),
      ),
    );
  }

  void _onScanBtnClick(BuildContext context,L10n l10n) {
    if (_locationTextController.text.isEmpty) {
      CshSnackBar.error(context: context, message: l10n.pleaseScanLocationBarcode);
    } else if (_barcodeTextController.text.isEmpty) {
      CshSnackBar.error(context: context, message: l10n.pleaseScanDeviceBarcode);
    } else {
      var provider = StoreOutProvider.of(context, listen: false);

      CshLoading().showLoading(context);
      provider
          .binOutVerifyBarCode(BinOutRequest(
        locBarcode: _locationTextController.text,
        stockBarcode: _barcodeTextController.text,
      ))
          .then((value) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: l10n.binOutSuccessfully);
        _locationTextController.clear();
        _barcodeTextController.clear();
      }, onError: (error, stack) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
        _locationTextController.clear();
        _barcodeTextController.clear();
      });
    }
  }
}
