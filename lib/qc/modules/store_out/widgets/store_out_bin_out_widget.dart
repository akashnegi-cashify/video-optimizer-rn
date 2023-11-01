import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';

import '../l10n.dart';
import '../providers/index.dart';
import '../resources/index.dart';
import 'index.dart';

class StoreOutBinOutWidget extends StatefulWidget {
  const StoreOutBinOutWidget({super.key});

  @override
  State<StoreOutBinOutWidget> createState() => _StoreOutBinOutWidgetState();
}

class _StoreOutBinOutWidgetState extends State<StoreOutBinOutWidget> {
  late TextEditingController _locationTextController;
  late TextEditingController _barcodeTextController;
  late ValueNotifier<String> instructionText;

  @override
  void initState() {
    super.initState();
    _locationTextController = TextEditingController();
    _barcodeTextController = TextEditingController();
    instructionText = ValueNotifier('Please Scan Location Barcode');
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var labelTextStyle = theme.textTheme.headlineMedium;
    var valueTextStyle = theme.primaryTextTheme.displaySmall;

    return Container(
      padding: const EdgeInsets.only(bottom: Dimens.space_8),
      child: LotScanWidget(
        onScannerDetected: (String value, MlScannerController controller) {
          if (isNotEmpty(value)) {
            if (_locationTextController.text.isEmpty) {
              _locationTextController.text = value;
              instructionText.value = l10n.pleaseScanDeviceBarcode;
            } else if (_barcodeTextController.text.isEmpty) {
              _barcodeTextController.text = value;
              instructionText.value = "";
              _onScanBtnClick(context, l10n);
            }
          }
        },
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ValueListenableBuilder(
              valueListenable: instructionText,
              builder: (BuildContext context, value, Widget? child) {
                return Center(
                    child: value.isNotEmpty
                        ? CshTextNew(
                            value,
                            textStyle: theme.textTheme.displayMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          )
                        : const SizedBox.shrink());
              },
            ),
            const SizedBox(height: Dimens.space_8),
            ValueListenableBuilder(
              valueListenable: _locationTextController,
              builder: (BuildContext context, value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: CshTextNew(l10n.location, textStyle: labelTextStyle)),
                      Expanded(flex: 2, child: CshTextNew(_locationTextController.text, textStyle: valueTextStyle)),
                    ],
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _barcodeTextController,
              builder: (BuildContext context, value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: CshTextNew(l10n.barCode, textStyle: labelTextStyle)),
                      Expanded(flex: 2, child: CshTextNew(_barcodeTextController.text, textStyle: valueTextStyle)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onScanBtnClick(BuildContext context, L10n l10n) {
    if (_locationTextController.text.isEmpty) {
      CshSnackBar.error(context: context, message: l10n.pleaseScanLocationBarcode);
    } else if (_barcodeTextController.text.isEmpty) {
      CshSnackBar.error(context: context, message: l10n.pleaseScanDeviceBarcode);
    } else {
      var provider = StoreOutProvider.of(context, listen: false);
      FocusManager.instance.primaryFocus?.unfocus();
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
        instructionText.value = l10n.pleaseScanLocationBarcode;
      }, onError: (error, stack) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
        _locationTextController.clear();
        _barcodeTextController.clear();
        instructionText.value = l10n.pleaseScanLocationBarcode;
      });
    }
  }
}
