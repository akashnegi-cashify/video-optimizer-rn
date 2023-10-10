import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/index.dart';
import 'package:provider/provider.dart';

import '../../qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import '../l10n.dart';
import '../models/index.dart';
import '../providers/pre_dispatch_provider.dart';
import 'index.dart';

class PreDispatchItemWidget extends StatelessWidget {
  const PreDispatchItemWidget({super.key, this.status});

  final int? status;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    var provider = PreDispatchProvider.of(context: context);
    var isLoading = provider.dataState.status == RequestStatus.initial;
    var items = provider.getItemsBasedOnStatus(status);
    var itemCount = items?.length ?? 0;

    if (isLoading == false && ArrayUtil.isNullOrEmpty(items)) {
      return Center(child: CshTextNew.h3(l10n.nothingAvailable));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1), () {
                provider.fetchPreDispatchItemDetail();
              });
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(Dimens.space_12),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = items?[index];
                return CshShimmer(
                  show: isLoading,
                  child: CshCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: CshTextNew.h2('${index + 1}) ${item?.qrCode}')),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space_6),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CshTextNew.h4(l10n.brand, isPrimary: false),
                              ),
                              Expanded(flex: 4, child: CshTextNew.h3('${item?.brand}')),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space_4),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: CshTextNew.h4(l10n.model, isPrimary: false)),
                              Expanded(flex: 4, child: CshTextNew.h3('${item?.model}')),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space_4),
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: CshTextNew.h4(l10n.imei, isPrimary: false)),
                              Expanded(flex: 4, child: CshTextNew.h3('${item?.imei}')),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.space_4),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_12);
              },
              itemCount: itemCount,
            ),
          ),
        ),
        CshCard(
            child: CshBigButton(
          text: l10n.scan,
          onPressed: () {
            if (provider.isAllItemScan()) {
              _completePreDispatchLot(context);
            } else {
              _scan(context, l10n);
            }
          },
        )),
      ],
    );
  }

  void _scan(BuildContext context, L10n l10n) async {
    var provider = PreDispatchProvider.of(context: context, listen: false);

    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (String scannedData, MlScannerController? controller) {
          if (scannedData.isNotEmpty) {
            CshLoading().showLoading(context);

            provider.scanPreDispatchLot(scannedData).then((value) {
              CshLoading().hideLoading(context);

              Navigator.pop(context);
              _showScanResultUI(context, provider, l10n);
            }, onError: (error) {
              CshLoading().hideLoading(context);
              CshSnackBar.error(context: context, message: error);
            });
          }
        },
        header: l10n.scanCode,
        hintText: l10n.enterBarCode);

    Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args).then((value) {
      provider.refreshData();
    });
  }

  void _showScanResultUI(BuildContext context, PreDispatchProvider provider, L10n l10n) {
    showResponsiveOverlayPanel(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (builderContext) {
          return ChangeNotifierProvider.value(
            value: provider,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(Dimens.space_12),
                  child: OverlayHeader(label: l10n.preDispatch),
                ),
                const Expanded(child: PreDispatchScanResultWidget()),
              ],
            ),
          );
        }).then((value) {
      if (provider.scanCode() && value != null) {
        _scan(context, l10n);
      } else if (provider.isAllItemScan()) {
        _completePreDispatchLot(context);
      }
    });
  }

  void _completePreDispatchLot(BuildContext context) {
    var provider = PreDispatchProvider.of(context: context, listen: false);
    CshLoading().showLoading(context);
    provider.completePreDispatchLot().then((value) {
      CshLoading().hideLoading(context);
      if (value?.isValid() == true) {
        CshSnackBar.success(context: context, message: value?.message ?? 'Success');

        var pageProvider = PageParamProvider.of(context, listen: false);
        var callback = pageProvider.getValue(PreDispatchCompParamKeys.allScanDoneCallback) as VoidCallback?;
        callback?.call();
      } else {
        CshSnackBar.error(context: context, message: value?.errorMessage ?? 'Something Went Wrong.');
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error ?? 'Something Went Wrong.');
    });
  }
}
