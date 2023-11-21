import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';

class LotScanWidget extends StatelessWidget {
  final Widget? footer;
  final Widget? content;
  final Widget? topContent;
  final Function(String value, MlScannerController controller)? onScannerDetected;

  const LotScanWidget({super.key, this.footer, this.content, this.topContent, this.onScannerDetected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (topContent != null) topContent!,
              Expanded(
                child: CshCard(
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
                  child: MlBarcodeScannerWidget(
                    scanFormatList: const [ScanFormats.barcode, ScanFormats.qrCode],
                    onScannerDetected: (value, controller) => {onScannerDetected?.call(value, controller)},
                  ),
                ),
              ),
              if (content != null)
                CshCard(
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_4),
                  child: content!,
                ),
            ],
          ),
        ),
        if (footer != null)
          CshCard(
            margin: const EdgeInsets.only(top: Dimens.space_8),
            child: footer!,
          ),
      ],
    );
  }
}
