import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/widgets/option_widget.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';

class LobDeviceScannerWidget extends StatelessWidget {
  const LobDeviceScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = LobDeviceScannerProvider.of(context);
    return TRCScannerWidget(
      onScanDetected: (scannedData, controller) {
        _showDialogForImeiNumber(
          context,
          scannedData,
          onSearchClicked: (isManual, enteredValue, isImei) {
            controller?.stop();
            Navigator.pop(context);
            CshLoading().showLoading(context);
            provider.getProductsList(scannedData, enteredValue, isImei, isManual).then((value) {
              CshLoading().hideLoading(context);
              if (!Validator.isTrue(value)) {
                CshSnackBar.error(context: context, message: "Product List is empty");
                return;
              }
              _showProductListDialog(context, provider.productList!, scannedData);
            }, onError: (error) {
              CshLoading().hideLoading(context);
              CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
              controller?.start();
            });
          },
        );
      },
    );
  }

  void _showDialogForImeiNumber(BuildContext context, String scannedData,
      {required Function(bool isManual, String enteredValue, bool isImei) onSearchClicked}) {
    String? imeiOrSerialNo;
    String selectedRadioValue = "IMEI";
    showCshBottomSheet(
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
                CshTextNew.subTitle1("Enter IMEI or Serial number"),
                const SizedBox(height: Dimens.space_16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: OptionWidget(
                          keyValue: "IMEI",
                          groupValue: selectedRadioValue,
                          onValueChanged: (p0) {
                            setState(() {
                              selectedRadioValue = p0;
                            });
                          },
                          optionData: "IMEI"),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: OptionWidget(
                          keyValue: "SNO",
                          groupValue: selectedRadioValue,
                          onValueChanged: (p0) {
                            setState(() {
                              selectedRadioValue = p0;
                            });
                          },
                          optionData: "Serial No."),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.space_16),
                CshTextFormField(
                  hintText: "Enter IMEI/serial number",
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      imeiOrSerialNo = value;
                    });
                  },
                ),
                const SizedBox(height: Dimens.space_16),
                ComboButton(
                  firstBtnText: "Manual Search",
                  padding: EdgeInsets.zero,
                  secondBtnText: "Search",
                  isFirstPrimary: true,
                  buttonType: ButtonType.mini,
                  firstBtnClick: !Validator.isNullOrEmpty(imeiOrSerialNo)
                      ? () {
                          _onSearchButtonClicked(
                              innerContext, imeiOrSerialNo, selectedRadioValue, true, onSearchClicked);
                        }
                      : null,
                  secondBtnClick: !Validator.isNullOrEmpty(imeiOrSerialNo)
                      ? () {
                          _onSearchButtonClicked(
                              innerContext, imeiOrSerialNo, selectedRadioValue, false, onSearchClicked);
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

  void _onSearchButtonClicked(BuildContext innerContext, String? enteredValue, String selectedRadioValue,
      bool isManualSearch, Function(bool isManual, String enteredValue, bool isImei) onSearchClicked) {
    FocusManager.instance.primaryFocus?.unfocus();
    // if (Validator.isNullOrEmpty(enteredValue)) {
    //   CshSnackBar.error(context: innerContext, message: "Please enter value", snackBarPosition: SnackBarPosition.TOP);
    //   return;
    // }
    bool isImei = false;
    if (selectedRadioValue == "IMEI") {
      isImei = true;
      // if (!Validator.isValidIMEI(enteredValue)) {
      //   CshSnackBar.error(
      //       context: innerContext, message: "Invalid IMEI number", snackBarPosition: SnackBarPosition.TOP);
      //   return;
      // }
    }
    onSearchClicked(isManualSearch, enteredValue!, isImei);
  }

  void _showProductListDialog(BuildContext context, List<LobProductListData> productList, String deviceBarcode) {
    showCshBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      child: _ProductListWidget(productList, deviceBarcode),
    );
  }
}

class _ProductListWidget extends StatelessWidget {
  late ValueNotifier<List<LobProductListData>> _queryList;
  List<LobProductListData> productList;
  String deviceBarcode;

  _ProductListWidget(this.productList, this.deviceBarcode, {super.key}) {
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
    CshLoading().showLoading(context);
    QcCalculatorService().getLobCalculator(deviceBarcode, item.productMasterId, item.productId).listen((event) {
      CshLoading().hideLoading(context);
      event?.brandId ??= item.brandId;
      CalculatorDataHolderModel().startCalculatorJourney(event, deviceBarcode, deviceType: DeviceType.lob_device);
      Navigator.pop(context); // Dismiss Dialog
      Navigator.pushReplacementNamed(context, CalculationScreen.route);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
    });
  }
}
