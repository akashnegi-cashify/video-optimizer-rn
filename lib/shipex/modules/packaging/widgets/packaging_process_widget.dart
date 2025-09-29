import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/modal/packaging_video_selection_dialog.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/packaging_provider.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/packaging_process_step_one_widget.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/video_creation_process_widget.dart';
import 'package:provider/provider.dart';

import '../models/group_lot_list_repsonse.dart';

class PackagingProcessWidget extends StatefulWidget {
  final GroupLotListData? dataModel;
  final bool? isGroupLotPending;

  final bool isCCTVCameraSelected;

  const PackagingProcessWidget({super.key, this.dataModel, this.isGroupLotPending, this.isCCTVCameraSelected = false});

  @override
  State<PackagingProcessWidget> createState() => _PackagingProcessWidgetState();
}

class _PackagingProcessWidgetState extends State<PackagingProcessWidget> {
  PageController _pageController = PageController(initialPage: 0);

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  late bool _isCCTVCameraSelected;

  final GlobalKey<PackagingProcessStepOneWidgetState> _stepAwbRef = GlobalKey<PackagingProcessStepOneWidgetState>();

  final GlobalKey<PackagingProcessStepOneWidgetState> _stepInvoiceRef = GlobalKey<PackagingProcessStepOneWidgetState>();

  final GlobalKey<PackagingProcessStepOneWidgetState> _stepDeviceRef = GlobalKey<PackagingProcessStepOneWidgetState>();

  final GlobalKey<VideoCreationProcessWidgetState> _videCreationProcess = GlobalKey<VideoCreationProcessWidgetState>();

  @override
  void initState() {
    _isCCTVCameraSelected = widget.isCCTVCameraSelected;
    if (Validator.isTrue(widget.isGroupLotPending)) {
      _currentIndex.value = 3;
      _pageController = PageController(initialPage: 3);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_currentIndex.value == 0) {
          return Future.value(true);
        }
        _showConfirmationPopup(context);
        return Future.value(false);
      },
      child: ChangeNotifierProvider<PackagingProvider>(
        create: (_) => PackagingProvider(widget.dataModel, widget.isGroupLotPending),
        lazy: false,
        builder: (BuildContext insideContext, __) {
          var provider = PackagingProvider.of(insideContext, listen: false);
          return ValueListenableBuilder(
            builder: (context, int value, __) {
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                          case 1:
                          case 2:
                            PackagingStep step = PackagingStep.getPackagingStepByIndex(index);
                            GlobalKey<PackagingProcessStepOneWidgetState> ref = _getPackagingRefByIndex(index);
                            return PackagingProcessStepOneWidget(
                              key: ref,
                              step: step,
                              lotName: widget.dataModel?.name,
                              quantity: widget.dataModel?.quantity,
                              onProcessFinished: (String data, PackagingStep step) {
                                switch (step) {
                                  case PackagingStep.scanAWB:
                                    _onAwbScanned(data, provider, context, ref);
                                    break;
                                  case PackagingStep.scanInvoice:
                                    _onInvoiceScanned(data, provider, context, ref);
                                    break;
                                  case PackagingStep.scanDeviceBarcode:
                                    _onDeviceScanned(data, provider, context, ref);
                                    break;
                                }
                              },
                            );
                          default:
                            return VideoCreationProcessWidget(key: _videCreationProcess, _isCCTVCameraSelected);
                        }
                      },
                      itemCount: 4,
                      pageSnapping: true,
                      allowImplicitScrolling: false,
                    ),
                  )
                ],
              );
            },
            valueListenable: _currentIndex,
          );
        },
      ),
    );
  }

  _onAwbScanned(String data, PackagingProvider provider, BuildContext context,
      GlobalKey<PackagingProcessStepOneWidgetState> ref) {
    if (!provider.isValidAwbNumber(data)) {
      CshSnackBar.error(context: context, message: "Wrong awb number - $data");
      ref.currentState?.resetScannerValue();
      return;
    }
    provider.awbNumber = data;
    _currentIndex.value = 1;
    provider.getSubOrderItems();
    _pageController.animateToPage(_currentIndex.value,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    Future.delayed(
      const Duration(milliseconds: 300),
      () => _stepInvoiceRef.currentState?.requestFocus(),
    );
  }

  _onInvoiceScanned(String data, PackagingProvider provider, BuildContext context,
      GlobalKey<PackagingProcessStepOneWidgetState> ref) {
    if (!provider.isValidInvoice(data)) {
      CshSnackBar.error(context: context, message: "Invalid Invoice number - $data");
      ref.currentState?.resetScannerValue();
      return;
    }
    provider.invoiceNumber = data;
    _currentIndex.value = 2;
    _pageController.animateToPage(_currentIndex.value,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    Future.delayed(
      const Duration(milliseconds: 300),
      () => _stepDeviceRef.currentState?.requestFocus(),
    );
  }

  _startPackaging(BuildContext context, PackagingProvider provider, String deviceBarcode,
      GlobalKey<PackagingProcessStepOneWidgetState> ref) {
    CshLoading().showLoading(context);
    provider.startPackaging(deviceBarcode).then((value) {
      CshLoading().hideLoading(context);
      _moveToVideoCreationProcess();
    }, onError: (error) {
      CshLoading().hideLoading(context);
      ref.currentState?.resetScannerValue();
      CshSnackBar.error(context: context, message: error);
    });
  }

  _showPackagingVideoSelectionDialog(BuildContext context, PackagingProvider provider,
      {required VoidCallback onProceed}) {
    showPackagingVideoSelectionDialog(context, onMonitoringAppSelected: (_) {
      onProceed();
    }, onCCTVCameraSelected: (scannedCameraBarcode, {bool? isSelectResetOption}) {
      _isCCTVCameraSelected = true;
      CshLoading().showLoading(context);
      provider.addCCTVCameraBarcode(scannedCameraBarcode).then((value) {
        CshLoading().hideLoading(context);
        onProceed();
      }, onError: (error) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error.toString());
      });
    });
  }

  _moveToVideoCreationProcess() {
    _currentIndex.value = 3;
    _pageController.animateToPage(_currentIndex.value,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  _onDeviceScanned(String data, PackagingProvider provider, BuildContext context,
      GlobalKey<PackagingProcessStepOneWidgetState> ref) {
    _showPackagingVideoSelectionDialog(context, provider, onProceed: () {
      _startPackaging(context, provider, data, ref);
    });
  }

  _getPackagingRefByIndex(int index) {
    if (index == 0) {
      return _stepAwbRef;
    } else if (index == 1) {
      return _stepInvoiceRef;
    } else {
      return _stepDeviceRef;
    }
  }

  _showConfirmationPopup(BuildContext context) {
    showPopup(context,
        title: "Are you sure?",
        desc: "The complete Progress will be lost.!!",
        actions: [
          CshMediumButton(
            text: "Yes",
            onPressed: () async {
              if (!widget.isCCTVCameraSelected) {
                await _videCreationProcess.currentState?.disposeCamera();
              }
              Navigator.pop(context); // Dismiss dialog
              Navigator.pop(context);
            },
          ),
          CshMediumButton(
            text: "No",
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        barrierDismissible: false);
  }
}
