import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/color_selection_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/product_list_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/lob_device_detail_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

class LobDeviceScannerWidget extends StatelessWidget {
  const LobDeviceScannerWidget({super.key});

  _oSearched(BuildContext context, int selectedCategoryId, int selectedBrandId) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    ProductListScreen.navigateTo(
      context,
      provider.deviceBarcode!,
      selectedCategoryId,
      selectedBrandId,
      provider.getCategoryList() ?? [],
      provider.deviceDetails?.imei1 ?? provider.deviceDetails?.imei2,
      (productItem, variantItem) {
        _getCalculator(context, productItem, selectedCategoryId, variantItem: variantItem);
      },
    );
  }

  _getCalculator(BuildContext context, LobProductListData item, int selectedCategoryId,
      {VariantListData? variantItem}) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getLobCalculator(item.productMasterId, item.productId, selectedCategoryId, variantItem).then(
        (calculatorResponse) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        calculatorResponse?.brandId ??= item.brandId;
        CalculatorDataHolderModel().startCalculatorJourney(
          calculatorResponse,
          provider.deviceBarcode,
          deviceType: DeviceType.lob_device,
          selectedCategoryId: selectedCategoryId,
          variantData: variantItem,
        );
        ColorSelectionScreen.navigateTo(context, item.productId, provider.deviceBarcode, (color) {
          Navigator.pop(context); // Dismiss color selection screen
          CalculatorDataHolderModel().setSelectedColor(color);
          Navigator.pushReplacementNamed(context, CalculationScreen.route);
        });
      }
    }, onError: (error) {
      if (context.mounted) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = LobDeviceScannerProvider.of(context);

    if (provider.isLoading) {
      return const CshShimmer();
    }

    if (!provider.isLoading && provider.errorMsg != null) {
      return Center(
        child: Column(
          children: [
            CshTextNew.subTitle1(provider.errorMsg!),
            const SizedBox(height: Dimens.space_16),
            CshMediumButton(
              text: "Retry",
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  onScanned: (scannedData, controller) {
                    Navigator.pop(context);
                    provider.getDeviceDetail(newDeviceBarcode: scannedData);
                  },
                );
              },
            ),
          ],
        ),
      );
    }

    if (provider.deviceDetails != null) {
      return LobDeviceDetailWidget(
        scannedData: provider.deviceBarcode!,
        deviceDetails: provider.deviceDetails,
        onSearchClicked: (selectedBrandId, selectedCategoryId) {
          _oSearched(context, selectedCategoryId, selectedBrandId);
        },
      );
    }
    return const SizedBox.shrink();
  }
}
