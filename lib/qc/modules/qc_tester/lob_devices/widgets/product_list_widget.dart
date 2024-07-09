import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/variant_list_item_widget.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/product_search_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/variant_search_clicked_event.dart';

class ProductListWidget extends StatelessWidget {
  late final ValueNotifier<List<LobProductListData>> _queryList;
  final List<LobProductListData> productList;
  final String deviceBarcode;
  final int selectedCategoryId;

  ProductListWidget(this.productList, this.deviceBarcode, this.selectedCategoryId, {super.key}) {
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
                          onTap: () => _onItemClicked(context, item),
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
    _fireAnalytics(item);
    if (provider.isAllowedVariants(selectedCategoryId)) {
      CshLoading().showLoading(context);
      provider.getVariantList(item.productId).then((value) {
        CshLoading().hideLoading(context);
        _showVariantList(context, value, item);
      }, onError: (error) {
        CshLoading().hideLoading(context);
        _showVariantListErrorDialog(context, error.toString());
      });
    } else {
      _getCalculator(context, item);
    }
  }

  _showVariantListErrorDialog(BuildContext context, String errorMessage) {
    var theme = Theme.of(context);
    showCshBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_4),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Text(
            errorMessage,
            style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
          ),
        ),
      ),
    );
  }

  _showVariantList(BuildContext context, List<VariantListData> variantList, LobProductListData productItem) {
    showCshBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_4),
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.separated(
            padding: const EdgeInsets.all(Dimens.space_16),
            itemBuilder: (_, index) {
              var item = variantList[index];
              return VariantListItemWidget(
                item,
                onTap: (item) {
                  _fireVariantAnalytics(item);
                  _getCalculator(context, productItem, variantItem: item);
                },
              );
            },
            separatorBuilder: (_, index) => const SizedBox(height: Dimens.space_12),
            itemCount: variantList.length),
      ),
    );
  }

  _getCalculator(BuildContext context, LobProductListData item, {VariantListData? variantItem}) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider
        .getLobCalculator(deviceBarcode, item.productMasterId, item.productId, selectedCategoryId, variantItem)
        .then((calculatorResponse) {
      CshLoading().hideLoading(context);
      calculatorResponse?.brandId ??= item.brandId;
      CalculatorDataHolderModel().startCalculatorJourney(
        calculatorResponse,
        deviceBarcode,
        deviceType: DeviceType.lob_device,
        selectedCategoryId: selectedCategoryId,
        variantData: variantItem,
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

  _fireVariantAnalytics(VariantListData item) {
    AnalyticsController.logEvent(VariantSearchClickedEvent(
      barcode: deviceBarcode,
      productName: item.name,
      variantId: item.id,
      deviceCategory: selectedCategoryId.toString(),
    ));
  }
}
