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
                child: MlBarcodeScannerWidget(
                  scanFormatList: const [ScanFormats.barcode],
                  onScannerDetected: (value, controller) => {onScannerDetected?.call(value, controller)},
                ),
              ),
              const SizedBox(height: Dimens.space_8),
              if (content != null) content!,
            ],
          ),
        ),
        if (footer != null) footer!,
      ],
    );
  }
}
