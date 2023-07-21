import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';

import '../../l10n.dart';
import '../providers/shipex_dispatch_provider.dart';

class AwbScannerWidget extends StatefulWidget {
  final Function() onSubmitPressed;

  const AwbScannerWidget({
    super.key,
    required this.onSubmitPressed,
  });

  @override
  State<AwbScannerWidget> createState() => _AwbScannerWidgetState();
}

class _AwbScannerWidgetState extends State<AwbScannerWidget> with AutomaticKeepAliveClientMixin {
  String _lastScannedAWB = "";

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ShipexDispatchProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Validator.isNullOrEmpty(provider.selectedDeliveryPartner?.name))
            Row(
              children: [
                Text(
                  "${l10n.selectDeliveryPartner}: ",
                  style: theme.primaryTextTheme.bodyMedium,
                ),
                const SizedBox(width: Dimens.space_4),
                Expanded(
                  child: Text(
                    provider.selectedDeliveryPartner!.name!,
                    style: theme.primaryTextTheme.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          const SizedBox(height: Dimens.space_20),
          CshCard(
            child: Column(
              children: [
                Text(
                  l10n.scanOrEnterAwb,
                  style: theme.primaryTextTheme.displaySmall,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: TRCScannerWidget(onScanDetected: (scannedData, controller) {
                    if (scannedData.isNotEmpty) {
                      controller?.stop();
                      _checkValidityOfAwbNumber(context, scannedData.trim(), onScanner: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          controller?.start();
                        });
                      });
                    }
                  }),
                ),
              ],
            ),
          ),
          if (!Validator.isNullOrEmpty(_lastScannedAWB)) ...[
            const SizedBox(height: Dimens.space_12),
            CshCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${l10n.lastAwb}: ", style: theme.primaryTextTheme.headlineMedium),
                  const SizedBox(width: Dimens.space_8),
                  Expanded(
                    child: Text(
                      _lastScannedAWB,
                      style: theme.primaryTextTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ],
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.proceed,
              onPressed: (Validator.isListNullOrEmpty(provider.scannedAwbNumber))
                  ? null
                  : () {
                      widget.onSubmitPressed();
                    },
            ),
          )
        ],
      ),
    );
  }

  _checkValidityOfAwbNumber(BuildContext context, String awb, {Function()? onScanner}) {
    var provider = ShipexDispatchProvider.of(context, listen: false);

    CshLoading().showLoading(context);
    provider.checkValidAWBNumber(awb).then((value) {
      CshLoading().hideLoading(context);
      if (Validator.isTrue(value.isValid)) {
        CshSnackBar.success(context: context, message: "Valid AWB Number");
        _lastScannedAWB = value.name ?? "";
        provider.addScannedAwbNumber(awb);
        setState(() {});
        if (onScanner != null) {
          onScanner();
        }
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      if (onScanner != null) {
        onScanner();
      }
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
