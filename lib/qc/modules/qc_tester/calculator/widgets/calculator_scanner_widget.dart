import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/calculator_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/select_brand_bottom_sheet.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_category_id_type.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/color_selection_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/product_list_screen.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class CalculatorScannerWidget extends StatefulWidget {
  const CalculatorScannerWidget({super.key});

  @override
  State<CalculatorScannerWidget> createState() => _CalculatorScannerWidgetState();
}

class _CalculatorScannerWidgetState extends State<CalculatorScannerWidget> {
  String? _deviceBarcode;
  String? _pQuote;
  bool _isDeviceBarcodeScanned = false;
  bool _isShowScannerTransitionWidget = false;

  CategoryData? _category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorScannerProvider(),
      lazy: false,
      builder: (builderContext, _) {
        return _getBuildWidget(builderContext);
      },
    );
  }

  Widget _getBuildWidget(BuildContext builderContext) {
    var l10n = L10n(context);
    if (_isShowScannerTransitionWidget) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: Dimens.space_16),
            CshTextNew.subTitle1(l10n.startScanningCdpQrCode),
          ],
        ),
      );
    } else {
      String key = _isDeviceBarcodeScanned ? "pQoute" : "deviceBarcode";
      return TRCScannerWidget(
        key: ValueKey(key),
        hintText: _isDeviceBarcodeScanned ? l10n.scanCdpQrCode : l10n.scanDeviceBarcode,
        scanFormatList: _isDeviceBarcodeScanned ? [BarcodeFormat.qrCode] : [BarcodeFormat.code128],
        onScanDetected: (scannedData, controller, {isManualEntry}) {
          var provider = CalculatorScannerProvider.of(builderContext, listen: false);
          if (!_isDeviceBarcodeScanned) {
            _onDeviceBarcodeScanned(scannedData, provider);
          } else {
            _onPQuoteScanned(scannedData, provider, controller);
          }
        },
      );
    }
  }

  _onDeviceBarcodeScanned(String scannedData, CalculatorScannerProvider provider) {
    _deviceBarcode = scannedData;
    setState(() {
      _isShowScannerTransitionWidget = true;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isShowScannerTransitionWidget = false;
        _isDeviceBarcodeScanned = true;
      });
    });
  }

  Future<void> _onPQuoteScanned(
      String scannedData, CalculatorScannerProvider provider, MlScannerController? controller) async {
    _pQuote = scannedData;
    CshLoading().showLoading(context);
    try {
      _category = await provider.getCategory(_deviceBarcode!, scannedData);
      if (context.mounted) {
        if (_category?.id == DeviceCategoryIdType.mobile.value) {
          CshLoading().hideLoading(context);
          _getCalculator(provider, controller, DeviceType.mobile_device);
        } else {
          controller?.stop();
          try {
            var brandList = await provider.getBrandList(_category!.id!);
            if (context.mounted) {
              CshLoading().hideLoading(context);
              selectBrandBottomSheet(context, brandList, isDismissible: false, onBrandSelect: (selectedBrand) {
                ProductListScreen.navigateTo(
                  context,
                  _deviceBarcode!,
                  _category!.id!,
                  selectedBrand.brandId!,
                  [_category!],
                  null,
                  (productItem, variantItem) {
                    Navigator.pop(context); // Dismiss brand selection screen
                    _getCalculator(provider, controller, DeviceType.lob_device,
                        productItem: productItem, variantItem: variantItem);
                  },
                );
              });
            }
          } catch (e) {
            controller?.start();
            CshLoading().hideLoading(context);
            CshSnackBar.error(context: context, message: e.toString());
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: e.toString());
      }
    }
  }

  _getCalculator(CalculatorScannerProvider provider, MobileScannerController? controller, DeviceType deviceType,
      {LobProductListData? productItem, VariantListData? variantItem}) {
    controller?.stop();
    CshLoading().showLoading(context);
    provider.getCalculatorRequest(_pQuote, _deviceBarcode, productItem?.productId).then((value) {
      if (mounted) {
        CshLoading().hideLoading(context);
        CalculatorDataHolderModel().startCalculatorJourney(value, _deviceBarcode,
            selectedCategoryId: _category?.id, variantData: variantItem, deviceType: DeviceType.mobile_device);

        ColorSelectionScreen.navigateTo(context, value.productId, _deviceBarcode, (color) {
          Navigator.pop(context); // Dismiss color selection screen
          CalculatorDataHolderModel().setSelectedColor(color);
          Navigator.pushReplacementNamed(context, CalculationScreen.route);
        });
      }
    }, onError: (error) {
      if (mounted) {
        controller?.start();
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
      }
    });
  }
}
