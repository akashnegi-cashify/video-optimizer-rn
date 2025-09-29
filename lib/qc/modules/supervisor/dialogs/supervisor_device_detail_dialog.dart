import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/supervisor/screens/supervisor_screen.dart';

import '../l10n.dart';

showSupervisorDeviceDetailDialog(BuildContext context, String deviceBarcode, SupervisorDeviceDetailResponse? event) {
  var l10n = L10n(context, listen: false);
  showCshBottomSheet(
    context: context,
    child: Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshTextNew.h3(l10n.verifyDeviceDetails),
          const SizedBox(height: Dimens.space_8),
          const Divider(),
          const SizedBox(height: Dimens.space_16),
          CshTextNew.h3('${l10n.deviceBarcode}: ${event?.deviceBarcode ?? ''}'),
          const SizedBox(height: Dimens.space_8),
          CshTextNew.subTitle1('${l10n.deviceStatus}: ${event?.deviceStatus ?? ''}'),
          const SizedBox(height: Dimens.space_16),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: Dimens.space_16),
          CshTextNew.subTitle1(l10n.manualTestDetails),
          const SizedBox(height: Dimens.space_12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CshTextNew.bodyText2("${l10n.manualTestBy}:", isPrimary: false),
              CshTextNew.bodyText2(event?.manualTestedBy ?? "", isPrimary: false),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CshTextNew.bodyText2("${l10n.manualTestOn}:", isPrimary: false),
              CshTextNew.bodyText2(
                formatDate(timeStamp: event?.manualTestedAt, pattern: DateFormats.dd_MMM_yyyy_h_mm_aa.value),
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: Dimens.space_16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CshTextNew.bodyText2("${l10n.cdpTestedBy}:", isPrimary: false),
              CshTextNew.bodyText2(event?.cdpTestedBy ?? "", isPrimary: false),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CshTextNew.bodyText2("${l10n.cdpTestedOn}:", isPrimary: false),
              CshTextNew.bodyText2(
                formatDate(timeStamp: event?.cdpTestedAt, pattern: DateFormats.dd_MMM_yyyy_h_mm_aa.value),
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.startSupervision,
            onPressed: () {
              Navigator.pop(context); // dismiss bottom sheet
              SupervisorScreen.navigate(context, deviceBarcode);
            },
          )
        ],
      ),
    ),
  );
}
