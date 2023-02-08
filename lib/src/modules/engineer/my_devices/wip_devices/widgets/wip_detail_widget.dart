import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/loading_dialog_widget.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_widget.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';

import 'send_to_tl_widget.dart';

class WIPDetailScreen extends StatelessWidget {
  const WIPDetailScreen({Key? key}) : super(key: key);
  static const route = "/engineer/wip-detail";

  @override
  Widget build(BuildContext context) {
    return const _WIPDetailWidget();
  }
}

class _WIPDetailWidget extends StatelessWidget {
  const _WIPDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EngineerDeviceInfo? deviceInfo = ModalRoute.of(context)?.settings.arguments as EngineerDeviceInfo?;

    assert(deviceInfo != null, "Device info can't be null here");

    L10n l10n = L10n(context);

    return Scaffold(
      appBar: CshHeader(l10n.wipOption),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //
              const SizedBox(
                height: Dimens.space_8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                child: DeviceCardWidget(deviceInfo: deviceInfo!),
              ),

              if (!Validator.isNullOrEmpty(deviceInfo.returnReason))
                RMSRemarksWidget(returnReason: deviceInfo.returnReason!),

              if (!Validator.isListNullOrEmpty(deviceInfo.repairReasonList))
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                    child: RepairReasonListWidget(repairReasons: deviceInfo.repairReasonList!)),

              const SizedBox(
                height: Dimens.space_16,
              ),

              _StatusUpdateButtonWidget(
                deviceInfo: deviceInfo,
                buttonText: l10n.putOnHold,
                urlPath: "mark-onhold",
              ),

              const SizedBox(
                height: Dimens.space_16,
              ),

              _StatusUpdateButtonWidget(
                deviceInfo: deviceInfo,
                buttonText: l10n.markOk,
                urlPath: "mark-ok",
              ),

              const SizedBox(
                height: Dimens.space_16,
              ),

              CshBigOutlineButton(
                text: l10n.viewParts,
                onPressed: () {
                  Navigator.pushNamed(context, AssignedPartsScreen.route,
                      arguments: AssignedPartsData(true, deviceInfo));
                },
              ),

              const SizedBox(
                height: Dimens.space_16,
              ),
              SendToTLWidget(deviceInfo: deviceInfo)
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusUpdateButtonWidget extends StatelessWidget {
  final EngineerDeviceInfo deviceInfo;
  final String buttonText;
  final String urlPath;

  const _StatusUpdateButtonWidget({Key? key, required this.deviceInfo, required this.buttonText, required this.urlPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //mark-onhold
    L10n l10n = L10n(context);

    return CshBigOutlineButton(
      text: buttonText,
      onPressed: () {
        var deviceBarcode = deviceInfo.deviceBarcode;
        if (deviceBarcode != null) {
          EngineerAPIService.updateDeviceStatus(urlPath, deviceInfo.deviceBarcode!).doAsyncOp((value) {
            if (value == null) {
              CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
              return;
            }
            if (value.isSuccess == true) {
              CshSnackBar.success(context: context, message: l10n.deviceStatusUpdatedSuccessfully);
            } else if (value.errorMsg != null) {
              CshSnackBar.error(context: context, message: value.errorMsg!);
            } else {
              CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
            }
          }, (loading) {
            if (loading) {
              CshLoading().showLoading(context);
            } else {
              CshLoading().hideLoading(context);
            }
          }, (error, stacktrace) {
            CshSnackBar.error(
                context: context, message: ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong);
          });
        }
      },
    );
  }
}

class DeviceCardWidget extends StatelessWidget {
  final EngineerDeviceInfo deviceInfo;

  const DeviceCardWidget({Key? key, required this.deviceInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CshTextNew.h3("${l10n.deviceBarcode} - ${deviceInfo.deviceBarcode}"),
        TitleValueRowWidget(title: l10n.productTitle, value: deviceInfo.productTitle ?? ""),
        TitleValueRowWidget(title: l10n.status, value: deviceInfo.status ?? ""),
        TitleValueRowWidget(title: l10n.repairType, value: deviceInfo.repairType ?? ""),
        TitleValueRowWidget(title: l10n.grade, value: deviceInfo.grade ?? ""),
        TitleValueRowWidget(title: l10n.deviceIMEI, value: deviceInfo.imei ?? "")
      ],
    ));
  }
}

class RMSRemarksWidget extends StatelessWidget {
  final String returnReason;

  const RMSRemarksWidget({Key? key, required this.returnReason}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CshCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CshTextNew.h3(l10n.rmsRemarks), CshTextNew.bodyText1(returnReason)],
          ),
        ),
        const SizedBox(
          height: Dimens.space_8,
        ),
        CshTextNew.h3(l10n.reQcFailReason),
        CshTextNew.bodyText1(returnReason)
      ],
    );
  }
}

class RepairReasonListWidget extends StatelessWidget {
  final List<String> repairReasons;

  const RepairReasonListWidget({Key? key, required this.repairReasons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CshList(
      rowCount: repairReasons.length,
      getRowWidget: (index) {
        return CshTextNew(repairReasons[index]);
      },
    );
  }
}
