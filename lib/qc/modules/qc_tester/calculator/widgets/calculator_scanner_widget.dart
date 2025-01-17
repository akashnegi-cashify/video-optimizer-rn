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

  // TODO: need to get this category from backend api
  CategoryData tempCategoryData = CategoryData(2, "Laptop", true, false);

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
          if (!_isDeviceBarcodeScanned) {
            _onDeviceBarcodeScanned(scannedData);
          } else {
            var provider = CalculatorScannerProvider.of(builderContext, listen: false);
            _onPQuoteScanned(scannedData, provider, controller);
          }
        },
      );
    }
  }

  _onDeviceBarcodeScanned(String scannedData) {
    _deviceBarcode = scannedData;
    setState(() {
      _isShowScannerTransitionWidget = true;
    });
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        setState(() {
          _isShowScannerTransitionWidget = false;
          _isDeviceBarcodeScanned = true;
        });
      },
    );
  }

  Future<void> _onPQuoteScanned(
      String scannedData, CalculatorScannerProvider provider, MlScannerController? controller) async {
    _pQuote = scannedData;
    if (tempCategoryData.id == DeviceCategoryIdType.mobile.value) {
      _getCalculator(provider, controller, DeviceType.mobile_device);
    } else {
      controller?.stop();
      CshLoading().showLoading(context);
      try {
        var brandList = await provider.getBrandList(tempCategoryData.id!);
        if (context.mounted) {
          CshLoading().hideLoading(context);
          selectBrandBottomSheet(context, brandList, isDismissible: false, onBrandSelect: (selectedBrand) {
            ProductListScreen.navigateTo(
              context,
              _deviceBarcode!,
              tempCategoryData.id!,
              selectedBrand.brandId!,
              [tempCategoryData],
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

  _getCalculator(CalculatorScannerProvider provider, MobileScannerController? controller, DeviceType deviceType,
      {LobProductListData? productItem, VariantListData? variantItem}) {
    controller?.stop();
    CshLoading().showLoading(context);
    // TODO: do we need to send productID, brandId, CategoryId
    provider.getCalculatorRequest(_pQuote, _deviceBarcode).then((value) {
      if (mounted) {
        CshLoading().hideLoading(context);
        CalculatorDataHolderModel().startCalculatorJourney(value, _deviceBarcode,
            selectedCategoryId: tempCategoryData.id, variantData: variantItem, deviceType: DeviceType.mobile_device);

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
