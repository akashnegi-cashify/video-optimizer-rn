import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReQcDeviceSummaryTab extends StatelessWidget {
  final LotDeviceListData? lotDeviceListData;
  final ReQcListData reQcListData;
  final VoidCallback onProceedClicked;
  final VoidCallback onAccessoriesClicked;
  final String? doneStatusCount;

  const ReQcDeviceSummaryTab({
    super.key,
    required this.lotDeviceListData,
    required this.reQcListData,
    this.doneStatusCount,
    required this.onAccessoriesClicked,
    required this.onProceedClicked,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.space_32),
          CshCard(
            child: Column(
              children: [
                _LabelValueWidget(title: "Lot Name: ", value: reQcListData.lotGroupName ?? ""),
                const SizedBox(height: Dimens.space_6),
                _LabelValueWidget(title: "Barcode: ", value: lotDeviceListData?.qrCode ?? "", isBarcode: true),
                const SizedBox(height: Dimens.space_6),
                _LabelValueWidget(title: "Product Name: ", value: lotDeviceListData?.productTitle ?? ""),
                const SizedBox(height: Dimens.space_6),
                _LabelValueWidget(title: "IMEI: ", value: lotDeviceListData?.imei ?? ""),
                const SizedBox(height: Dimens.space_6),
                _LabelValueWidget(title: "Grade: ", value: lotDeviceListData?.grade ?? ""),
                const SizedBox(height: Dimens.space_6),
                _LabelValueWidget(title: "Device Tested Age: ", value: lotDeviceListData?.testAge.toString() ?? ""),
                const SizedBox(height: Dimens.space_6),
                _LabelValueWidget(title: "Status: ", value: "$doneStatusCount Done"),
                const SizedBox(height: Dimens.space_12),
                CshMediumButton(text: "Accessories", onPressed: onAccessoriesClicked)
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          CshBigButton(text: "Proceed", onPressed: onProceedClicked),
        ],
      ),
    );
  }
}

class _LabelValueWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool isBarcode;

  const _LabelValueWidget({super.key, required this.title, required this.value, this.isBarcode = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    TextStyle? valueStyle;
    if (isBarcode) {
      valueStyle = theme.primaryTextTheme.displayMedium?.copyWith(color: theme.colorScheme.primary);
    } else {
      valueStyle = theme.primaryTextTheme.titleSmall;
    }
    return Row(
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: Text(title, style: theme.textTheme.bodyMedium)),
        Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: InkWell(
                onTap: () {
                  if (isBarcode) {
                    _showQrCode(context, value);
                  }
                },
                child: Text(value, style: valueStyle))),
      ],
    );
  }

  _showQrCode(BuildContext context, String text) {
    showCshBottomSheet(
      context: context,
      child: Container(
        margin: const EdgeInsets.all(Dimens.space_24),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: QrImageView(
            data: text,
            backgroundColor: Colors.white,
            size: 300,
          ),
        ),
      ),
    );
  }
}
