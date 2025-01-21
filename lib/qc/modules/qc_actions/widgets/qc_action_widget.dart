import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_home_screen.dart';
import 'package:flutter_trc/qc/modules/data_wipe/screens/data_wipe_home_screen.dart';
import 'package:flutter_trc/qc/modules/device_details/screens/device_details_screen.dart';
import 'package:flutter_trc/qc/modules/device_receive_module/screens/device_receive_screen.dart';
import 'package:flutter_trc/qc/modules/external_audit/external_audit_home_screen.dart';
import 'package:flutter_trc/qc/modules/gaurd/screens/qc_guard_home_screen.dart';
import 'package:flutter_trc/qc/modules/imei_validator/resources/imei_qrcode_response.dart';
import 'package:flutter_trc/qc/modules/imei_validator/screens/imei_validator_screen.dart';
import 'package:flutter_trc/qc/modules/qc_actions/resources/services.dart';
import 'package:flutter_trc/qc/modules/re_qc/screens/re_qc_list_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/stock_transfer_list_screen.dart';
import 'package:flutter_trc/qc/modules/store_in/dialog/show_store_in_type_dialog.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/store_in_location_scan_screen.dart';
import 'package:flutter_trc/qc/modules/store_out/screens/index.dart';
import 'package:flutter_trc/qc/modules/supervisor/dialogs/supervisor_device_detail_dialog.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_service.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/screens/on_going_audit_screen.dart';
import 'package:flutter_trc/qc/qc_role_permission/qc_role_permission_helper.dart';
import 'package:flutter_trc/qc/qc_role_permission/widget/qc_role_permission_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../src/modules/elss/common_screen/elss_home_screen.dart';
import '../../dead_repair/screens/index.dart';
import '../../dead_repair/type.dart';
import '../../dispatch_lot/screens/dispatch_lot_screen.dart';
import '../../pre_dispatch/screens/index.dart';
import '../../qc_tester/home/screens/qc_tester_home_screen.dart';
import '../l10n.dart';
import '../models/qc_action_comp_config.dart';

class QCActionWidget extends StatelessWidget {
  final QcActionConfig? configData;

  const QCActionWidget({
    Key? key,
    this.configData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    if (!QcRolePermissionHelper.hasPermission(QcRole.qcVideographer)) {
      return Center(
        child: SizedBox(
          width: double.infinity,
          child: CshBigButton(
            text: l10n.genericDeviceMedia,
            onPressed: () => Navigator.pushNamed(context, D2cVideoHomeScreen.route),
          ),
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QcRolePermissionWidget(
              role: QcRole.qcElss,
              child: CshBigButton(
                text: configData?.button1Text ?? l10n.elss,
                onPressed: () {
                  ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: true);
                  Navigator.of(context).pushNamed(ElssHomeScreen.route, arguments: args);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: configData?.button2Text ?? l10n.deviceTesting,
              onPressed: () {
                Navigator.of(context).pushNamed(QcTesterHomeScreen.route);
              },
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleStoreIn,
              child: CshBigButton(
                text: l10n.storeIn,
                onPressed: () {
                  showStoreInTypeDialog(
                    context,
                    onScanned: (qrCode, isBinStoreIn) {
                      StoreInLocationScanScreen.navigateTo(context, barcode: qrCode, isBinStoreIn: isBinStoreIn);
                    },
                  );
                },
              ),
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleStoreOut,
              child: CshBigButton(
                text: l10n.storeOut,
                onPressed: () {
                  Navigator.of(context).pushNamed(StoreOutScreen.route);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.reQc,
              onPressed: () {
                Navigator.of(context).pushNamed(ReQcListScreen.route);
              },
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleDispatch,
              child: CshBigButton(
                text: l10n.preDispatch,
                onPressed: () {
                  Navigator.of(context).pushNamed(PreDispatchLotScreen.route);
                },
              ),
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleDispatch,
              child: CshBigButton(
                text: l10n.lotDispatch,
                onPressed: () {
                  Navigator.of(context).pushNamed(DispatchLotScreen.route);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.externalRecording,
              onPressed: () {
                Navigator.of(context).pushNamed(ExternalAuditHomeScreen.route);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.repairDevice,
              onPressed: () {
                _onRepairButtonClicked(context);
              },
            ),
            QcRolePermissionWidget(
              role: QcRole.roleGuard,
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: CshBigButton(
                text: l10n.guardRole,
                onPressed: () {
                  Navigator.pushNamed(context, QcGuardHomeScreen.route);
                },
              ),
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleStockTransfer,
              child: CshBigButton(
                text: l10n.stockTransfer,
                onPressed: () {
                  Navigator.of(context).pushNamed(StockTransferListScreen.route);
                },
              ),
            ),
            QcRolePermissionWidget(
              padding: const EdgeInsets.only(top: Dimens.space_16),
              role: QcRole.roleDeadDevice,
              child: CshBigButton(
                text: l10n.deadDevice,
                onPressed: () {
                  DeviceDeadRepairScreen.navigateTo(context);
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.receiveDevice,
              onPressed: () {
                Navigator.pushNamed(context, DeviceReceiveScreen.route);
              },
            ),
            QcRolePermissionWidget(
              role: QcRole.qcSupervision,
              padding: const EdgeInsets.only(top: Dimens.space_16),
              child: CshBigButton(
                text: l10n.supervision,
                onPressed: () {
                  CshMlScannerUtil().openScanner(
                    context,
                    onScanned: (scannedData, controller) {
                      Navigator.pop(context);
                      _onSupervisorScanned(context, scannedData);
                    },
                    header: l10n.scanDeviceBarcode,
                    hintText: l10n.scanDeviceBarcode,
                  );
                },
              ),
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.warehouseAudit,
              onPressed: () {
                Navigator.pushNamed(context, OnGoingAuditScreen.route);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.deviceDetails,
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  onScanned: (scannedData, controller) {
                    Navigator.pop(context);
                    DeviceDetailsScreen.pushNamed(context, scannedData);
                  },
                );
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.dataWipe,
              onPressed: () {
                Navigator.pushNamed(context, DataWipeHomeScreen.route);
              },
            ),
            const SizedBox(height: Dimens.space_16),
            CshBigButton(
              text: l10n.imeiValidator,
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  scanFormatList: [BarcodeFormat.qrCode],
                  header: "Scan QR code from panel",
                  onScanned: (scannedData, controller) {
                    if (!Validator.isNullOrEmpty(scannedData)) {
                      try {
                        scannedData = scannedData.replaceAll("\\", "");
                        scannedData = scannedData.substring(1, scannedData.length - 1);
                        var resMap = jsonDecode(scannedData);
                        ImeiQrcodeResponse res = ImeiQrcodeResponse.fromJson(resMap);
                        Navigator.pop(context); // dismiss scanner screen
                        ImeiValidatorScreen.navigate(context, res);
                      } catch (e) {
                        if (e is FormatException) {
                          CshSnackBar.error(context: context, message: "Invalid QR code");
                        } else {
                          CshSnackBar.error(context: context, message: "Something went wrong");
                        }
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _onRepairButtonClicked(BuildContext context) {
    CshMlScannerUtil().openScanner(context, onScanned: (scanValue, controller) {
      if (isNotEmpty(scanValue)) {
        _fetchReasonList(context).then((value) {
          ReasonSelectionScreen.navigateTo(
            context,
            header: 'Repair Device',
            status: RoleType.REPAIR_DEVICE.value,
            reasonList: value,
            code: scanValue,
          ).whenComplete(() {
            _onRepairButtonClicked(context);
          });
        });
      }
    });
  }

  _onSupervisorScanned(BuildContext context, String scannedData) {
    CshLoading().showLoading(context);
    SupervisorService.getDeviceDetails(scannedData).listen((event) {
      CshLoading().hideLoading(context);
      showSupervisorDeviceDetailDialog(context, scannedData, event);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(error).toString());
    });
  }

  Future<List<String>> _fetchReasonList(BuildContext context) {
    var completer = Completer<List<String>>();
    CshLoading().showLoading(context);
    QcActionServices.fetchRepairReasonList().listen((event) {
      CshLoading().hideLoading(context);

      if (event?.isValid() == true) {
        completer.complete(ArrayUtil.removeNullItems(event?.data ?? []));
      } else {
        completer.completeError(event?.message ?? "Something Went Wrong.");
      }
    }, onError: (error, stackTrace) {
      CshLoading().hideLoading(context);
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
      Logger.debug('QCActionWidget._fetchReasonList', [errorMsg]);
    });

    return completer.future;
  }
}
