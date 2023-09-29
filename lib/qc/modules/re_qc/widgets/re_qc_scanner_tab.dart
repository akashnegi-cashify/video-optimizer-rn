import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

class ReQcScannerTab extends StatelessWidget {
  final ReQcListData reQcListData;
  final VoidCallback onDeviceListPressed;
  final String? doneStatusCount;
  final Function(String scannedData, MlScannerController? controller) onScanDetected;

  const ReQcScannerTab({
    super.key,
    required this.reQcListData,
    required this.doneStatusCount,
    required this.onDeviceListPressed,
    required this.onScanDetected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.subTitle1("Lot Name: ${reQcListData.lotGroupName}"),
                const SizedBox(height: Dimens.space_6),
                CshTextNew.subTitle1("Lot Qty: ${reQcListData.lotCount}"),
                const SizedBox(height: Dimens.space_6),
                CshTextNew.subTitle1("Status: $doneStatusCount Done"),
                const SizedBox(height: Dimens.space_6),
                CshMediumButton(
                  text: "Device List",
                  onPressed: onDeviceListPressed,
                )
              ],
            ),
          ),
          const SizedBox(height: Dimens.space_16),
          Expanded(
            child: CshCard(
              child: TRCScannerWidget(
                isEditTextSubmitButtonDirectionHorizontal: true,
                onScanDetected: onScanDetected,
              ),
            ),
          )
        ],
      ),
    );
  }
}
