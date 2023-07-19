import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

import '../providers/dispute_image_capture_provider.dart';
import '../screens/disputed_image_capture_barcode_scanner_screen.dart';
import '../screens/disputed_image_capture_screen.dart';
import 'disputed_image_info_widget.dart';

class DisputedImageCaptureWidget extends StatelessWidget {
  final String barcode;

  const DisputedImageCaptureWidget({
    super.key,
    required this.barcode,
  });

  @override
  Widget build(BuildContext context) {
    var provider = DisputeImageCaptureProvider.of(context);
    var theme = Theme.of(context);
    if (Validator.isTrue(provider.isDataLoading)) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!Validator.isNullOrEmpty(provider.errorMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.errorMessage!,
                style: theme.primaryTextTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
      return (!Validator.isListNullOrEmpty(provider.mediaInfoList))
          ? _DisputeMediaWidget(
              barcode: barcode,
            )
          : Center(
              child: Center(
                child: Row(
                  children: [
                    const SizedBox.shrink(),
                    Expanded(
                      child: Text(
                        "No Data Found",
                        style: theme.primaryTextTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
    }
  }
}

class _DisputeMediaWidget extends StatefulWidget {
  final String barcode;

  const _DisputeMediaWidget({
    super.key,
    required this.barcode,
  });

  @override
  State<_DisputeMediaWidget> createState() => _DisputeMediaWidgetState();
}

class _DisputeMediaWidgetState extends State<_DisputeMediaWidget> {
  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = DisputeImageCaptureProvider.of(context, listen: false);
      provider.checkAuditAlreadyDone(() {
        if (mounted) {
          _onAlreadyDoneStatusBarcode(context);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger.debug('mydebug------_DisputeMediaWidgetState.build', ["is rebuilded"]);
    var provider = DisputeImageCaptureProvider.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.all(Dimens.space_16),
              itemBuilder: (context, index) {
                return DisputedImageInfoWidget(dataModel: provider.mediaInfoList![index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: Dimens.space_8,
                );
              },
              itemCount: provider.mediaInfoList.length),
        ),
        if (provider.checkSubmitButtonStatus()) ...[
          const SizedBox(height: Dimens.space_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: SizedBox(
              width: double.infinity,
              child: CshMediumButton(
                text: "Submit",
                onPressed: () {
                  _submitDisputeDataModel();
                },
              ),
            ),
          )
        ]
      ],
    );
  }

  _submitDisputeDataModel() {
    var provider = DisputeImageCaptureProvider.of(context, listen: false);

    CshLoading().showLoading(context);
    provider.subDisputeMediaData(widget.barcode).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Data Submitted Successfully!!");
        Navigator.of(context).pop();
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _onAlreadyDoneStatusBarcode(BuildContext context) {
    var theme = Theme.of(context);
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox.shrink(),
                    Expanded(
                      child: Text(
                        "Audit of this barcode is already done. Do you still want to continue?",
                        style: theme.primaryTextTheme.headlineMedium,
                      ),
                    )
                  ],
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                ComboButton(
                  firstBtnText: "Cancel",
                  secondBtnText: "Yes",
                  buttonType: ButtonType.mini,
                  isFirstPrimary: true,
                  padding: EdgeInsets.zero,
                  firstBtnClick: () {
                    Navigator.of(context).pop();
                    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
                        onScanDetected: (String scannedData, MlScannerController? controller) {
                      if (scannedData.isNotEmpty) {
                        Navigator.of(context).pop();
                        DisputedImageCaptureScreenArguments arg =
                            DisputedImageCaptureScreenArguments(barcode: scannedData.trim());
                        Navigator.of(context).pushNamed(DisputedImageCaptureScreen.route, arguments: arg);
                      }
                    });
                    Navigator.of(context)
                        .pushReplacementNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
                  },
                  secondBtnClick: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
