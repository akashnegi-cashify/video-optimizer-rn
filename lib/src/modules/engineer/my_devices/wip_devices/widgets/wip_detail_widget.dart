import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/loading_dialog_widget.dart';
import 'package:flutter_trc/src/common/widgets/multiple_image_upload_screen.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/change_device_status_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_device_action_status_enum.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/providers/wip_device_detail_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/engineer/screens/device_report_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/assigned_device_details.dart';
import 'package:flutter_trc/trc/my_permissions/widget/trc_role_permission_widget.dart';
import 'package:flutter_trc/trc/my_permissions/permissions.dart';

import 'send_to_tl_widget.dart';

class WIPDetailWidget extends StatefulWidget {
  const WIPDetailWidget({super.key});

  @override
  State<WIPDetailWidget> createState() => _WIPDetailWidgetState();
}

class _WIPDetailWidgetState extends State<WIPDetailWidget> {
  bool _isPerformStartWork = false;

  @override
  Widget build(BuildContext context) {
    var provider = WIPDeviceDetailProvider.of(context);
    L10n l10n = L10n(context);

    var deviceInfo = provider.deviceInfo;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
            child: _DeviceCardWidget(deviceInfo: deviceInfo),
          ),
          if (!Validator.isNullOrEmpty(deviceInfo?.returnReason))
            _RMSRemarksWidget(returnReason: deviceInfo!.returnReason!),
          if (!Validator.isListNullOrEmpty(deviceInfo?.repairReasonList))
            Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_8),
                child: _RepairReasonListWidget(repairReasons: deviceInfo!.repairReasonList!)),
          if (!Validator.isNullOrEmpty(deviceInfo?.status) && deviceInfo!.status == "HOLD" && !_isPerformStartWork)
            _StatusUpdateButtonWidget(
              deviceBarcode: provider.deviceBarcode,
              contentPadding: const EdgeInsets.only(top: Dimens.space_16),
              buttonText: l10n.startWork,
              urlPath: EngineerDeviceActionStatusEnum.MARK_IN_PROGRESS.value,
              onApiSuccess: () {
                setState(() {
                  _isPerformStartWork = true;
                });
              },
            ),
          if (!Validator.isNullOrEmpty(deviceInfo?.status) && deviceInfo!.status != "HOLD" || _isPerformStartWork) ...[
            _StatusUpdateButtonWidget(
              deviceBarcode: provider.deviceBarcode,
              contentPadding: const EdgeInsets.only(top: Dimens.space_16),
              buttonText: l10n.putOnHold,
              urlPath: EngineerDeviceActionStatusEnum.MARK_ON_HOLD.value,
              onApiSuccess: () {
                Navigator.pop(context);
              },
            ),
            if (Validator.isTrue(provider.isScrewImagesUploaded()))
              _StatusUpdateButtonWidget(
                deviceBarcode: provider.deviceBarcode,
                contentPadding: const EdgeInsets.only(top: Dimens.space_16),
                buttonText: PermissionController().hasPermission(TrcPermissions.engineer)
                    ? l10n.markOk
                    : l10n.repairDone,
                urlPath: PermissionController().hasPermission(TrcPermissions.engineer)
                    ? EngineerDeviceActionStatusEnum.MARK_OK.value
                    : EngineerDeviceActionStatusEnum.MARK_REPAIR_DONE.value,
                onApiSuccess: () {
                  Navigator.pop(context);
                },
              ),
            const SizedBox(height: Dimens.space_16),
            CshBigOutlineButton(
              text: l10n.viewParts,
              onPressed: () async {
                await Navigator.pushNamed(context, AssignedPartsScreen.route,
                    arguments: AssignedPartsData(true, deviceBarcode: provider.deviceBarcode));
                provider.getDeviceDetails();
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigOutlineButton(
              text: l10n.uploadScrewImages,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultipleImageUploadScreen(
                      DeviceMediaType.screwSealImages,
                      provider.deviceBarcode,
                      callStatusUpdateApi: () {
                        return Future.value();
                      },
                      onMediaUploaded: () {
                        Navigator.pop(context); // dismiss MultipleImageUploadScreen screen
                        CshSnackBar.success(context: context, message: l10n.screwImagesUploadedSuccessfully);
                        provider.getDeviceDetails();
                      },
                    ),
                  ),
                );
              },
            ),
            TRCRolePermissionWidget(
              permission: TrcPermissions.l4Engineer,
              child: _StatusUpdateButtonWidget(
                deviceBarcode: provider.deviceBarcode,
                contentPadding: const EdgeInsets.only(top: Dimens.space_16),
                buttonText: l10n.markFI,
                urlPath: EngineerDeviceActionStatusEnum.MARK_FI.value,
                onApiSuccess: () {
                  Navigator.pop(context);
                },
              ),
            ),
            TRCRolePermissionWidget(
              permission: TrcPermissions.l4Engineer,
              child: _StatusUpdateButtonWidget(
                deviceBarcode: provider.deviceBarcode,
                contentPadding: const EdgeInsets.only(top: Dimens.space_16),
                buttonText: l10n.markFFI,
                urlPath: EngineerDeviceActionStatusEnum.MARK_NFF.value,
                onApiSuccess: () {
                  Navigator.pop(context);
                },
              ),
            ),
            TRCRolePermissionWidget(
              permission: TrcPermissions.l4Engineer,
              child: _StatusUpdateButtonWidget(
                deviceBarcode: provider.deviceBarcode,
                buttonText: l10n.markNR,
                contentPadding: const EdgeInsets.only(top: Dimens.space_16),
                urlPath: EngineerDeviceActionStatusEnum.MARK_NR.value,
                onApiSuccess: () {
                  Navigator.pop(context);
                },
              ),
            ),
            TRCRolePermissionWidget(
              permission: TrcPermissions.engineer,
              child: Padding(
                padding: const EdgeInsets.only(top: Dimens.space_16),
                child: SendToTLWidget(
                    deviceBarcode: provider.deviceBarcode,
                    color: deviceInfo?.color,
                    productTitle: deviceInfo?.productName),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: CshBigOutlineButton(
                text: l10n.qcFailedReasons,
                onPressed: () {
                  DeviceReportScreen.navigate(context, deviceInfo?.did.toString() ?? "");
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class _StatusUpdateButtonWidget extends StatelessWidget {
  final String deviceBarcode;
  final String buttonText;
  final String urlPath;
  final VoidCallback? onApiSuccess;
  final EdgeInsets contentPadding;

  const _StatusUpdateButtonWidget({
    Key? key,
    required this.deviceBarcode,
    required this.buttonText,
    required this.urlPath,
    this.onApiSuccess,
    this.contentPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);

    return Padding(
      padding: contentPadding,
      child: CshBigOutlineButton(
        text: buttonText,
        onPressed: () {
          if (urlPath == EngineerDeviceActionStatusEnum.MARK_OK.value ||
              urlPath == EngineerDeviceActionStatusEnum.MARK_REPAIR_DONE.value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultipleImageUploadScreen(
                  DeviceMediaType.markOk,
                  deviceBarcode,
                  callStatusUpdateApi: () {
                    return _updateStatus(l10n);
                  },
                  onMediaUploaded: () {
                    Navigator.pop(context); // dismiss MultipleImageUploadScreen screen
                    onApiSuccess?.call();
                  },
                ),
              ),
            );
            return;
          }
          _getUpdateStatusStream().doAsyncOp((value) {
            if (value == null) {
              CshSnackBar.error(context: context, message: l10n.somethingWentWrong);
              return;
            }
            if (value.isSuccess == true) {
              CshSnackBar.success(context: context, message: l10n.deviceStatusUpdatedSuccessfully);
              if (onApiSuccess != null) {
                onApiSuccess!();
              }
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
        },
      ),
    );
  }

  Stream<ChangeDeviceStatusResponse?> _getUpdateStatusStream() {
    return EngineerAPIService.updateDeviceStatus(urlPath, deviceBarcode);
  }

  Future<void> _updateStatus(L10n l10n) {
    var completer = Completer<void>();
    _getUpdateStatusStream().listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete();
      } else {
        completer.completeError(event?.errorMsg.toString() ?? l10n.somethingWentWrong);
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}

class _DeviceCardWidget extends StatelessWidget {
  final AssignDeviceDetailsData? deviceInfo;

  const _DeviceCardWidget({Key? key, required this.deviceInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextNew.h3("${l10n.deviceBarcode} - ${deviceInfo?.deviceBarcode}"),
          TitleValueRowWidget(title: l10n.productTitle, value: deviceInfo?.productName ?? ""),
          TitleValueRowWidget(title: l10n.status, value: deviceInfo?.status ?? ""),
          TitleValueRowWidget(title: l10n.repairType, value: deviceInfo?.repairType ?? ""),
          TitleValueRowWidget(title: l10n.grade, value: deviceInfo?.grade ?? ""),
          if (!Validator.isNullOrEmpty(deviceInfo?.imei))
            TitleValueRowWidget(title: l10n.deviceIMEI, value: deviceInfo?.imei ?? ""),
          if (!Validator.isNullOrEmpty(deviceInfo?.serialNumber))
            TitleValueRowWidget(title: l10n.serialNumber, value: deviceInfo?.serialNumber ?? ""),
        ],
      ),
    );
  }
}

class _RMSRemarksWidget extends StatelessWidget {
  final String returnReason;

  const _RMSRemarksWidget({Key? key, required this.returnReason}) : super(key: key);

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
        const SizedBox(height: Dimens.space_8),
        CshTextNew.h3(l10n.reQcFailReason),
        CshTextNew.bodyText1(returnReason)
      ],
    );
  }
}

class _RepairReasonListWidget extends StatelessWidget {
  final List<String> repairReasons;

  const _RepairReasonListWidget({Key? key, required this.repairReasons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: repairReasons.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return CshTextNew(repairReasons[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Dimens.space_8);
      },
    );
  }
}
