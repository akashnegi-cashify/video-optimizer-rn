import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_accessories_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_detail_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_question_tab_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/device_list_tab.dart';
import 'package:flutter_trc/qc/modules/re_qc/widgets/re_qc_device_summary_tab.dart';
import 'package:flutter_trc/qc/modules/re_qc/widgets/re_qc_questions_tab.dart';
import 'package:flutter_trc/qc/modules/re_qc/widgets/re_qc_scanner_tab.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

class ReQcDetailWidget extends StatefulWidget {
  const ReQcDetailWidget({super.key});

  @override
  State<ReQcDetailWidget> createState() => _ReQcDetailWidgetState();
}

class _ReQcDetailWidgetState extends State<ReQcDetailWidget> {
  int _currentPage = 0;
  final PageController pagerController = PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    var provider = ReQcDetailProvider.of(context);
    return WillPopScope(
      onWillPop: () {
        if (_currentPage == 0) {
          return Future.value(true);
        }
        if (_currentPage == 3) {
          _animateToPage(_currentPage - 1);
        } else {
          _animateToPage(0);
        }
        return Future.value(false);
      },
      child: CshShimmer(
        show: provider.isLoading,
        child: PageView.builder(
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return ReQcScannerTab(
                  reQcListData: provider.reQcListData,
                  doneStatusCount: provider.getDoneStatusCount(),
                  onDeviceListPressed: () {
                    _animateToPage(1);
                  },
                  onScanDetected: (String scannedData, MlScannerController? controller) {
                    _onScanDetected(scannedData, controller, provider);
                  },
                );
              case 1:
                return DeviceListTab(deviceList: provider.deviceList ?? []);
              case 2:
                var lotListData = provider.getLotListData();
                return ReQcDeviceSummaryTab(
                  lotDeviceListData: lotListData,
                  reQcListData: provider.reQcListData,
                  doneStatusCount: provider.getDoneStatusCount(),
                  onAccessoriesClicked: () => _onAccessoryClicked(lotListData?.deviceId, provider),
                  onProceedClicked: () => _animateToPage(3),
                );
              case 3:
                return ChangeNotifierProvider(
                  create: (_) => ReQcQuestionsProvider(provider.deviceReportList, provider.scannedDeviceBarcode),
                  lazy: false,
                  child: ReQcQuestionsTab(
                    onReQcSubmitted: (bool isMismatchMarked) {
                      _animateToPage(0);
                      CshLoading().showLoading(context);
                      provider.getDeviceList().then((value) {
                        CshLoading().hideLoading(context);
                        if (isMismatchMarked) {
                          _showReQcSubmitDialog("Mismatch uploaded successfully", provider);
                        } else {
                          _showReQcSubmitDialog("Device matched successfully", provider);
                        }
                      }, onError: (error) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: error);
                      });
                    },
                  ),
                );
              default:
                return Container();
            }
          },
          controller: pagerController,
          itemCount: 4,
          onPageChanged: (value) {
            if (value == 0) {
              provider.scannedDeviceBarcode = null;
            }
            setState(() {
              _currentPage = value;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: true,
        ),
      ),
    );
  }

  _animateToPage(int index) {
    pagerController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  _onScanDetected(String scannedData, MlScannerController? controller, ReQcDetailProvider provider) {
    controller?.stop();
    CshLoading().showLoading(context);
    provider.getDeviceReportList(scannedData).then((value) {
      CshLoading().hideLoading(context);
      pagerController.animateToPage(2, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
      controller?.start();
    });
  }

  _onAccessoryClicked(int? deviceId, ReQcDetailProvider provider) {
    CshLoading().showLoading(context);
    provider.getDeviceAccessories(deviceId).then((value) {
      CshLoading().hideLoading(context);
      _showAccessoriesDialog(value!);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _showAccessoriesDialog(List<DeviceAccessoriesListData> list) {
    var theme = Theme.of(context);
    showCshBottomSheet(
      context: context,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        margin: const EdgeInsets.all(Dimens.space_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.space_8),
            CshTextNew.subTitle1("Accessories"),
            const SizedBox(height: Dimens.space_24),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var item = list[index];
                  return Row(
                    children: [
                      Expanded(child: CshTextNew.subTitle1(item.label ?? "")),
                      Expanded(
                        child: Text(
                          item.value ?? "",
                          style: theme.primaryTextTheme.titleMedium,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: Dimens.space_16, thickness: 1);
                },
                itemCount: list.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  _showReQcSubmitDialog(String message, ReQcDetailProvider provider) {
    showPopup(context, title: "Re-Qc Success", desc: message, actions: [
      CshMediumButton(
        text: "Next",
        onPressed: () {
          if (provider.isAllDeviceReQcComplete()) {
            Navigator.pop(context); // dismissDialog
            _showCompleteReQcDialog(provider);
          } else {
            Navigator.pop(context); // dismissDialog
          }
        },
      ),
    ]);
  }

  void _showCompleteReQcDialog(ReQcDetailProvider provider) {
    showPopup(context, title: "Complete Re-Qc", desc: "Do you want to complete Re-Qc", actions: [
      CshMediumButton(
        text: "Cancel",
        onPressed: () {
          Navigator.pop(context); // dismissDialog
        },
      ),
      CshMediumButton(
        text: "Next",
        onPressed: () {
          CshLoading().showLoading(context);
          provider.completeReQc().then((value) {
            Navigator.pop(context); // dismissDialog
            CshLoading().hideLoading(context);
            Navigator.pop(context);
          }, onError: (error) {
            Navigator.pop(context); // dismissDialog
            CshLoading().hideLoading(context);
            _showExitPopup(error);
          });
        },
      ),
    ]);
  }

  _showExitPopup(String message) {
    showPopup(context, title: "Info", desc: message, actions: [
      CshMediumButton(
        text: "Exit",
        onPressed: () {
          Navigator.pop(context); // dismissDialog
          Navigator.pop(context);
        },
      ),
    ]);
  }
}
