import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_lot_detail_provider.dart';

class PendingDeviceDetailTab extends StatelessWidget {
  final VoidCallback? onReject;
  final VoidCallback? onDeviceAdded;
  final String? scannedDevice;


  const PendingDeviceDetailTab(this.scannedDevice, {super.key, this.onReject, this.onDeviceAdded});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = PendingLotDetailProvider.of(context);
    var data = provider.scannedDeviceDetailResponse;
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          CshTextNew.subTitle1("Add barcide of transfer lot:-"),
          const SizedBox(height: Dimens.space_8),
          CshTextNew.h3(provider.pendingLotDetailResponse?.lotName ?? ""),
          const SizedBox(height: Dimens.space_8),
          CshCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText1("Barcode")),
                    Flexible(
                      flex: 5,
                      child: Text(scannedDevice ?? "", maxLines: 2, style: theme.primaryTextTheme.displayMedium),
                    )
                  ],
                ),
                const SizedBox(height: Dimens.space_4),
                _buildLabelValueWidget("Model", data?.modal, theme),
                const SizedBox(height: Dimens.space_4),
                _buildLabelValueWidget("Brand", data?.brand, theme),
                const SizedBox(height: Dimens.space_4),
                _buildLabelValueWidget("Source", data?.source, theme),
                const SizedBox(height: Dimens.space_4),
                _buildLabelValueWidget("Status", data?.status, theme),
                const SizedBox(height: Dimens.space_4),
                _buildLabelValueWidget("Eligible", Validator.isTrue(data?.isError) ? data?.errorMsg : "Valid", theme),
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          ComboButton(
            firstBtnText: "Reject",
            secondBtnText: "Add To Lot",
            firstBtnClick: () {
              onReject?.call();
            },
            secondBtnClick: () {
              CshLoading().showLoading(context);
              provider.addDeviceInLot(scannedDevice).then((value) {
                CshLoading().hideLoading(context);
                CshSnackBar.success(context: context, message: "Device added successfully");
                provider.getDeviceList();
                onDeviceAdded?.call();
              }, onError: (error) {
                CshLoading().hideLoading(context);
                CshSnackBar.error(context: context, message: error);
              });
            },
          ),
        ],
      ),
    );
  }

  _buildLabelValueWidget(String label, String? value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.bodyText2(label)),
        Flexible(flex: 5, child: Text(value ?? "", maxLines: 2, style: theme.primaryTextTheme.headlineMedium))
      ],
    );
  }
}
