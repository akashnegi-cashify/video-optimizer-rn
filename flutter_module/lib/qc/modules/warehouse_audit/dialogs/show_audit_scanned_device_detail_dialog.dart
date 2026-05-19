import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';

Future showAuditScannedDeviceDetailsDialog(BuildContext context, ScanDeviceData? value) {
  return showCshBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: false,
      child: PopScope(
        canPop: false,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_24, Dimens.space_16, Dimens.space_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CshTextNew.subTitle1("Scan Device Details"),
              const SizedBox(height: Dimens.space_12),
              const Divider(thickness: 1, height: 1),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Barcode:")),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(value?.deviceBarcode ?? "NA")),
                ],
              ),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Model Name:")),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(value?.productName ?? "NA")),
                ],
              ),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Current Status:")),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(value?.currentStatus ?? "NA")),
                ],
              ),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Money Out Date:")),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: CshTextNew.subTitle2(
                      formatDate(timeStamp: value?.moneyOutDate, pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("Storage Location:")),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(value?.storageLocation ?? "NA")),
                ],
              ),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("IMEI 1:")),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(value?.imei1 ?? "NA")),
                ],
              ),
              const SizedBox(height: Dimens.space_16),
              Row(
                children: [
                  Flexible(flex: 2, fit: FlexFit.tight, child: CshTextNew.subTitle2("IMEI 2:")),
                  Flexible(flex: 3, fit: FlexFit.tight, child: CshTextNew.subTitle2(value?.imei2 ?? "NA")),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_16),
                child: CshMediumButton(
                  text: "Ok",
                  onPressed: () {
                    Navigator.pop(context); // Dismiss dialog
                  },
                ),
              )
            ],
          ),
        ),
      ));
}
