import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/lob_device_detail_widget.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/product_list_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:provider/provider.dart';

class LobDeviceScannerWidget extends StatelessWidget {
  const LobDeviceScannerWidget({super.key});

  _oSearched(BuildContext context, bool isManual, int selectedCategoryId) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider
        .getProductsList(
      provider.deviceBarcode!,
      provider.deviceDetails?.imei1,
      provider.deviceDetails?.serialNo,
      isManual,
      selectedCategoryId,
    )
        .then((value) {
      CshLoading().hideLoading(context);
      _showProductListDialog(context, value!, provider.deviceBarcode!, provider, selectedCategoryId);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
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
        onSearchClicked: (isManual, selectedCategoryId) {
          _oSearched(context, isManual, selectedCategoryId);
        },
      );
    }
    return const SizedBox.shrink();
  }

  void _showProductListDialog(BuildContext context, List<LobProductListData> productList, String deviceBarcode,
      LobDeviceScannerProvider provider, int selectedCategoryId) {
    showCshBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: ProductListWidget(productList, deviceBarcode, selectedCategoryId),
      ),
    );
  }
}
