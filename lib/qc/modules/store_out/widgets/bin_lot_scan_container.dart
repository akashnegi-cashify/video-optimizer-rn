import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/index.dart';
import 'package:flutter_trc/src/common/utils/string_utils.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../../../src/common/widgets/labeled_text.dart';
import '../providers/lot_scan_provider.dart';
import '../resources/index.dart';
import '../l10n.dart';

class BinLotScanContainer extends StatelessWidget {
  final String lotName;
  final int lotType;

  const BinLotScanContainer({
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
      create: (_) => LotScanProvider.binLotList(lotType: lotType, lotName: lotName),
      lazy: false,
      child: Builder(
        builder: (builderContext) {
          var provider = LotScanProvider.of(builderContext);
          var isLoading = provider.binDataState.status == RequestStatus.initial;
          var itemList = provider.binDataState.data?.lotList;
          var itemCount = itemList?.length ?? 0;

          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : LotScanWidget(
            topContent: Selector<LotScanProvider, int>(
              builder: (BuildContext context, value, Widget? child) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: Dimens.space_100,child: LinearProgressIndicator(value: (value / itemCount))),
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
                  onScannerDetected: (value, controller) => _onScannerDetected(builderContext, value, controller,l10n),
                  content: Selector<LotScanProvider, int>(
                    builder: (BuildContext context, value, Widget? child) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: Dimens.space_4, horizontal: Dimens.space_16),
                        child: Column(
                          children: [
                            LabeledText(
                              label: l10n.barCode,
                              value: itemList?[value]?.barcode,
                              valueTextStyle: valueTextStyle,
                              labelTextStyle: labelTextStyle,
                              labelFlex: 1,
                              valueFlex: 2,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: Dimens.space_4),
                            LabeledText(
                              label: l10n.location,
                              value: itemList?[value]?.itemLocBarCode,
                              valueTextStyle: valueTextStyle,
                              labelTextStyle: labelTextStyle,
                              labelFlex: 1,
                              valueFlex: 2,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: Dimens.space_4),
                          ],
                        ),
                      );
                    },
                    selector: (BuildContext context, LotScanProvider provider) {
                      return provider.scanPosition;
                    },
                  ),
                  footer: Padding(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    child: Row(
                      children: [
                        Expanded(
                            child: CshBigButton(
                          text: l10n.skip,
                          onPressed: () => _onSkipClick(builderContext),
                        )),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  void _onSkipClick(BuildContext context) {
    var provider = LotScanProvider.of(context, listen: false);
    var res = provider.moveNext();

    if (res == false) {
      Navigator.pop(context);
    }
  }

  _onScannerDetected(BuildContext context, String value, MlScannerController controller,L10n l10n) {
    var provider = LotScanProvider.of(context, listen: false);

    var item = provider.binDataState.data?.lotList?[provider.scanPosition];

    if (item?.barcode?.containsIgnoreCase(value) == true) {
      CshLoading().showLoading(context);
      provider.binOutVerifyBarCode(BinOutRequest(locBarcode: item?.itemLocBarCode, stockBarcode: value)).then((value) {
        CshLoading().hideLoading(context);

        if (value?.isValid() == true) {
          CshSnackBar.success(context: context, message: l10n.binOutSuccessfully);
          var res = provider.moveNext();
          if (res == false) {
            Navigator.pop(context);
          }
        } else {
          CshSnackBar.error(context: context, message: value?.message ?? l10n.somethingWentWrong);
        }
      }, onError: (error, stack) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
      });
    } else {
      CshSnackBar.error(context: context, message: l10n.barcodeMismatchNTryAgain);
    }
  }
}
