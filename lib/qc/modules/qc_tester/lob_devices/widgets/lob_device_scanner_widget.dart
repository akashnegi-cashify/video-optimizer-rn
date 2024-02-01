import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/auto_search_button_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/device_verify_popup_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/manual_search_button_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/product_search_clicked_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/scan_manual_test_barcode_event.dart';
import 'package:flutter_trc/src/libraries/analytics/events/update_device_category_event.dart';
import 'package:provider/provider.dart';

class LobDeviceScannerWidget extends StatelessWidget {
  const LobDeviceScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = LobDeviceScannerProvider.of(context, listen: false);
    return TRCScannerWidget(
      onScanDetected: (scannedData, controller) {
        AnalyticsController.logEvent(ScanManualTestBarcodeEvent(scannedData));
        controller?.stop();
        CshLoading().showLoading(context);
        provider.getDeviceDetail(scannedData).then((deviceDetails) {
          CshLoading().hideLoading(context);
          _showDialogForImeiNumber(
            context,
            scannedData,
            deviceDetails,
            onSearchClicked: (bool isManual, int selectedCategoryId) {
              // Navigator.pop(context);
              CshLoading().showLoading(context);
              provider
                  .getProductsList(
                scannedData,
                deviceDetails?.imei1,
                deviceDetails?.serialNo,
                isManual,
                selectedCategoryId,
              )
                  .then((value) {
                CshLoading().hideLoading(context);
                _showProductListDialog(context, value!, scannedData, provider, selectedCategoryId);
              }, onError: (error) {
                CshLoading().hideLoading(context);
                CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
              });
            },
          ).whenComplete(() {
            controller?.start();
          });
        }, onError: (error) {
          controller?.start();
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
        });
      },
    );
  }

  Future<void> _showDialogForImeiNumber(
    BuildContext context,
    String scannedData,
    DeviceDetailResponseData? deviceDetails, {
    required Function(bool isManual, int selectedCategoryId) onSearchClicked,
  }) {
    List<DropDownItem> categoryList = [];
    DropDownItem? selectedCategory;
    deviceDetails?.categories?.forEach((key, value) {
      var dropDownItem = DropDownItem("$key", value);
      categoryList.add(dropDownItem);

      /// check if selectedCategoryId exist in category list or not
      if (deviceDetails.selectedCategoryId == key && selectedCategory == null) {
        selectedCategory = dropDownItem;
      }
    });

    AnalyticsController.logEvent(DeviceVerifyPopupEvent(scannedData, selectedCategory?.id));

    return showCshBottomSheet(
      context: context,
      isScrollControlled: true,
      child: StatefulBuilder(builder: (innerContext, setState) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(innerContext).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(Dimens.space_20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CshTextNew.subTitle1("Update Category If needed"),
                const SizedBox(height: Dimens.space_16),
                Row(
                  children: [
                    Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("Category:", isPrimary: false)),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: CshDropDown(
                        items: categoryList,
                        hintText: "Select Category",
                        selectedItem: selectedCategory,
                        onChanged: (DropDownItem? value) {
                          AnalyticsController.logEvent(
                              UpdateDeviceCategoryEvent(scannedData, selectedCategory?.id, value?.id));
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.space_16),
                Row(
                  children: [
                    Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("Barcode:", isPrimary: false)),
                    Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(scannedData)),
                  ],
                ),
                const SizedBox(height: Dimens.space_16),
                Row(
                  children: [
                    Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("IMEI:", isPrimary: false)),
                    Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(deviceDetails?.imei1 ?? "NA")),
                  ],
                ),
                const SizedBox(height: Dimens.space_16),
                Row(
                  children: [
                    Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle1("Serial No:", isPrimary: false)),
                    Flexible(flex: 4, fit: FlexFit.tight, child: CshTextNew.h3(deviceDetails?.serialNo ?? "NA")),
                  ],
                ),
                const SizedBox(height: Dimens.space_16),
                ComboButton(
                  firstBtnText: "Manual Search",
                  padding: EdgeInsets.zero,
                  secondBtnText: "Search",
                  isFirstPrimary: true,
                  buttonType: ButtonType.mini,
                  firstBtnClick: selectedCategory != null
                      ? () {
                          AnalyticsController.logEvent(
                              ManualSearchButtonClickedEvent(scannedData, selectedCategory?.id));
                          onSearchClicked(true, int.parse(selectedCategory!.id!));
                        }
                      : null,
                  secondBtnClick: selectedCategory != null
                      ? () {
                          AnalyticsController.logEvent(AutoSearchButtonClickedEvent(scannedData, selectedCategory?.id));
                          onSearchClicked(false, int.parse(selectedCategory!.id!));
                        }
                      : null,
                )
              ],
            ),
          ),
        );
      }),
    );
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
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CshTextNew.h3("Please select product"),
          const SizedBox(height: Dimens.space_16),
          SearchBarWidget(
            hintText: "Search by product name",
            onQuery: (query) {
              _queryList.value = Validator.isNullOrEmpty(query)
                  ? productList
                  : productList.where((element) => element.name!.toLowerCase().contains(query.toLowerCase())).toList();
            },
          ),
          const SizedBox(height: Dimens.space_16),
          ValueListenableBuilder<List<LobProductListData>>(
              valueListenable: _queryList,
              builder: (BuildContext context, List<LobProductListData> value, Widget? child) {
                return Expanded(
                  child: ListView.separated(
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
                      separatorBuilder: (_, index) => const SizedBox(height: Dimens.space_8),
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
        deviceName: item.name,
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
