import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/string_utils.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/widgets/labeled_text.dart';
import '../l10n.dart';
import '../providers/lot_scan_provider.dart';
import '../resources/index.dart';
import '../screens/index.dart';
import 'index.dart';

class NormalLotScanContainer extends StatelessWidget {
  final String lotName;
  final int lotType;

  const NormalLotScanContainer({
    super.key,
    required this.lotName,
    required this.lotType,
  });

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var labelTextStyle = theme.textTheme.headlineMedium;
    var valueTextStyle = theme.primaryTextTheme.displayMedium?.copyWith(color: theme.primaryColor);

    return ChangeNotifierProvider(
      create: (_) => LotScanProvider(lotType: lotType, lotName: lotName),
      lazy: false,
      child: Builder(builder: (builderContext) {
        var provider = LotScanProvider.of(builderContext);
        var isLoading = provider.dataState.status == RequestStatus.initial;
        var itemList = provider.dataState.data;
        var itemCount = itemList?.length ?? 0;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.dataState.status == RequestStatus.failure) {
          return Center(
            child: Text(
              provider.dataState.errorMsg ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
            ),
          );
        }

        return LotScanWidget(
          topContent: Selector<LotScanProvider, int>(
            builder: (BuildContext context, value, Widget? child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: Dimens.space_100, child: LinearProgressIndicator(value: (value / itemCount))),
                    const SizedBox(height: Dimens.space_4),
                    CshTextNew.h4('$value/$itemCount')
                  ],
                ),
              );
            },
            selector: (BuildContext context, LotScanProvider provider) {
              return provider.scanPosition;
            },
          ),
          onScannerDetected: (value, controller) => _onScannerDetected(builderContext, value, controller, l10n),
          content: Selector<LotScanProvider, int>(
            builder: (BuildContext context, value, Widget? child) {
              if (value >= itemCount) {
                value = itemCount - 1;
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LabeledText(
                    label: l10n.barCode,
                    value: itemList?[value]?.qrCode,
                    valueTextStyle: valueTextStyle,
                    labelTextStyle: labelTextStyle,
                    labelFlex: 1,
                    valueFlex: 2,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: Dimens.space_4),
                  LabeledText(
                    label: l10n.productTitle,
                    value: itemList?[value]?.model,
                    valueTextStyle: valueTextStyle,
                    labelTextStyle: labelTextStyle,
                    labelFlex: 1,
                    valueFlex: 2,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: Dimens.space_4),
                  LabeledText(
                    label: l10n.location,
                    value: itemList?[value]?.qrCode,
                    valueTextStyle: valueTextStyle,
                    labelTextStyle: labelTextStyle,
                    labelFlex: 1,
                    valueFlex: 2,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: Dimens.space_4),
                ],
              );
            },
            selector: (BuildContext context, LotScanProvider provider) {
              return provider.scanPosition;
            },
          ),
          footer: Row(
            children: [
              Expanded(
                  child: CshBigButton(
                text: l10n.skip,
                onPressed: () => _onSkipClick(builderContext),
              )),
            ],
          ),
        );
      }),
    );
  }

  void _onSkipClick(BuildContext context) {
    var provider = LotScanProvider.of(context, listen: false);
    var res = provider.moveNext();

    if (res == false) {
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context, {MlScannerController? controller}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          controller?.stop();
          return AlertDialog(
            title: CshTextNew.h3('Warning'),
            content: CshTextNew.h4('Store Out Completed'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName(StoreOutScreen.route));
                },
                child: CshTextNew.h3('Ok'),
              )
            ],
          );
        });
  }

  _onScannerDetected(BuildContext context, String value, MlScannerController? controller, L10n l10n) {
    var provider = LotScanProvider.of(context, listen: false);
    var item = provider.dataState.data?[provider.scanPosition];

    if (item?.qrCode?.containsIgnoreCase(value) == true) {
      controller?.stop();
      CshLoading().showLoading(context);
      provider
          .normalLotOutVerifyBarCode(
        NormalLotOutRequest(locBarcode: item?.qrCode, stockBarcode: value, lotName: lotName),
      )
          .then((value) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: l10n.lotOutSuccessfully);
        var res = provider.moveNext();
        if (res == false) {
          _showAlert(context, controller: controller);
        } else {
          controller?.start();
        }
      }, onError: (error, stack) {
        CshLoading().hideLoading(context);
        controller?.start();
        CshSnackBar.error(context: context, message: error);
      });
    } else {
      CshSnackBar.error(context: context, message: l10n.barcodeMismatchNTryAgain);
    }
  }
}
