import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/lob_device_detail_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/product_search_clicked_event.dart';
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
        child: _ProductListWidget(productList, deviceBarcode, selectedCategoryId),
      ),
    );
  }
}

class _ProductListWidget extends StatelessWidget {
  late final ValueNotifier<List<LobProductListData>> _queryList;
  final List<LobProductListData> productList;
  final String deviceBarcode;
  final int selectedCategoryId;

  _ProductListWidget(this.productList, this.deviceBarcode, this.selectedCategoryId, {super.key}) {
    _queryList = ValueNotifier<List<LobProductListData>>(productList);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: CshTextNew.h3("Please select product"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: SearchBarWidget(
              hintText: "Search by product name",
              onQuery: (query) {
                _queryList.value = Validator.isNullOrEmpty(query)
                    ? productList
                    : productList
                        .where((element) => element.name!.toLowerCase().contains(query.toLowerCase()))
                        .toList();
              },
            ),
          ),
          const SizedBox(height: Dimens.space_16),
          ValueListenableBuilder<List<LobProductListData>>(
              valueListenable: _queryList,
              builder: (BuildContext context, List<LobProductListData> value, Widget? child) {
                return Expanded(
                  child: ListView.separated(
                      padding: const EdgeInsets.all(Dimens.space_16),
                      itemBuilder: (_, index) {
                        var item = value[index];
                        return GestureDetector(
                          onTap: () {
                            _onItemClicked(context, item);
                          },
                          child: CshCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CshTextNew.subTitle1(item.brand ?? ""),
                                const SizedBox(height: Dimens.space_4),
                                CshTextNew.subTitle1(item.name ?? ""),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(height: Dimens.space_12),
                      itemCount: value.length),
                );
              })
        ],
      ),
    );
  }

  void _onItemClicked(BuildContext context, LobProductListData item) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    _fireAnalytics(item);
    provider.getLobCalculator(deviceBarcode, item.productMasterId, item.productId, selectedCategoryId).then(
        (calculatorResponse) {
      CshLoading().hideLoading(context);
      calculatorResponse?.brandId ??= item.brandId;
      CalculatorDataHolderModel().startCalculatorJourney(
        calculatorResponse,
        deviceBarcode,
        deviceType: DeviceType.lob_device,
        selectedCategoryId: selectedCategoryId,
      );
      Navigator.popUntil(context, (route) => route is PageRoute); // Dismiss all dialog
      Navigator.pushReplacementNamed(context, CalculationScreen.route);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
    });
  }

  _fireAnalytics(LobProductListData item) {
    AnalyticsController.logEvent(ProductSearchClickedEvent(
      barcode: deviceBarcode,
      productName: item.name,
      productId: item.productId,
      deviceCategory: selectedCategoryId.toString(),
    ));
  }
}
